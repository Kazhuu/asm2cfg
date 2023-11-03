#!/usr/bin/env python3
"""Class for parsing the objdump SPARC input"""

import re
from typing import List

from ...data.address import Address
from ...data.encoding import Encoding
from ...data.instruction import Instruction

from .disassembler import Disassembler, DisassemblerError

# Common regexes
HEX_PATTERN = r"[0-9a-fA-F]+"
HEX_LONG_PATTERN = r"(?:0x0*)?" + HEX_PATTERN


class ObjDumpSparcDisassembler(Disassembler):
    """Objdump SPARC disassembler"""

    name: str = "SPARC Objdump Disassembler (SparcV8 Binutils)"

    # Expected format: <hex address> <<label+offset>>: <opcode> <interpreted opcode>
    regex: str = r"(\S+)( <(\S+)>|):\s+([\S ]+)\s([\S  ]+)"
    regex_information: dict[str, int] = {
        "address": 1,
        "location": 3,
        "instruction_hex": 4,
        "instruction_str": 5,
    }

    def extract_information(self, str_input: str) -> dict[str, str]:
        result = {}

        if "=> " in str_input:
            extracted_line = str_input.split("=> ", 1)[1].split("\n", 1)[0]

            information = re.search(self.regex, extracted_line)
            if not information:
                raise DisassemblerError("Line not processable: \n" + str(extracted_line))

            address = str(information.group(self.regex_information.get("address")))
            location = str(information.group(self.regex_information.get("location")))
            instr_d = str(information.group(self.regex_information.get("instruction_str")))
            instr_h = str(information.group(self.regex_information.get("instruction_hex")))
            opcode = (instr_d.split()[0],)

            result = {
                "address": address,
                "location": location,
                "instr_h": instr_h,
                "instr_d": instr_d,
                "opcode": opcode,
                "printable": extracted_line,
            }
        else:
            raise DisassemblerError("Line not processable: \n" + str(str_input))

        return result

    def parse_function_header(self, line: str) -> str | None:
        """
        Return function name of memory range from the given string line.

        Match lines for non-stripped binaries:
        'Dump of assembler code for function test_function:'
        lines for stripped binaries:
        'Dump of assembler code from 0x555555555faf to 0x555555557008:'
        and lines for objdump disassembly:
        '0000000000016bb0 <_obstack_allocated_p@@Base>:'
        """
        objdump_name_pattern = re.compile(rf"{HEX_PATTERN} <([a-zA-Z_0-9@.]+)>:")
        function_name = objdump_name_pattern.search(line)
        if function_name is not None:
            return function_name[1]

        function_name_pattern = re.compile(r"function (\w+):$")
        function_name = function_name_pattern.search(line)
        if function_name is not None:
            return function_name[1]

        memory_range_pattern = re.compile(
            rf"(?:Address range|from) ({HEX_LONG_PATTERN}) to ({HEX_LONG_PATTERN}):$"
        )
        memory_range = memory_range_pattern.search(line)
        if memory_range is not None:
            return f"{memory_range[1]}-{memory_range[2]}"

        return None

    def parse_address(self, line: str) -> (Address, str):
        """
        Parses leading address of instruction
        """
        address_match = re.match(rf"^\s*(?:0x)?({HEX_PATTERN})\s*(?:<([+-][0-9]+)>)?:(.*)", line)
        if address_match is None:
            return None, line
        address = Address(
            int(address_match[1], 16), None, int(address_match[2]) if address_match[2] else None
        )
        return address, address_match[3]

    def split_nth(self, string: str, count: int) -> List[str]:
        """
        Splits string to equally-sized chunks
        """
        return [string[i : i + count] for i in range(0, len(string), count)]

    def parse_encoding(self, line):
        """
        Parses byte encoding of instruction for objdump disassemblies
        e.g. the '31 c0' in
        '16bd3:	31 c0                	xor    %eax,%eax'
        In addition to X86 supports ARM encoding styles:
        '4:	e1a01000 	mov	r1, r0'
        '50:	f7ff fffe 	bl	0 <__aeabi_dadd>'
        '54:	0002      	movs	r2, r0'
        """
        # Encoding is separated from assembly mnemonic via tab
        # so we allow whitespace separators between bytes
        # to avoid accidentally matching the mnemonic.
        enc_match = re.match(r"^\s*((?:[0-9a-f]{2,8} +)+)(.*)", line)
        if enc_match is None:
            return None, line
        bites = []
        for chunk in enc_match[1].strip().split(" "):
            bites.extend(int(byte, 16) for byte in self.split_nth(chunk, 2))
        return Encoding(bites), enc_match[2]

    def parse_body(self, line: str) -> (str, str, List[str], str):
        """Parses instruction body (opcode and operands)"""
        comment_symbol = self.architecture.comment()
        body_match = re.match(rf"^\s*([^{comment_symbol}<]+)(.*)", line)
        if body_match is None:
            return None, None, None, line
        body = body_match[1].strip()
        line = body_match[2]
        opcode_match = re.match(r"^(\S*)\s*(.*)", body)
        if opcode_match is None:
            return None, None, None, line
        opcode = opcode_match[1]
        ops = opcode_match[2].split(",") if opcode_match[2] else []
        return body, opcode, ops, line

    def parse_target(self, line: str) -> (Address, str):
        """
        Parses optional instruction branch target hint
        """
        target_match = re.match(r"\s*<([.a-zA-Z_@0-9]+)([+-]0x[0-9a-f]+|[+-][0-9]+)?>(.*)", line)
        if target_match is None:
            return None, line
        offset = target_match[2] or "+0"
        address = Address(None, target_match[1], int(offset, 0))
        return address, target_match[3]

    def parse_comment(self, line: str) -> (Address, str):
        """
        Parses optional instruction comment
        """
        comment_symbol = self.architecture.comment()
        comment_match = re.match(rf"^\s*{comment_symbol}\s*(.*)", line)
        if comment_match is None:
            return None, line
        comment = comment_match[1]
        imm_match = re.match(rf"^(?:0x)?({HEX_PATTERN})\s*(<.*>)?(.*)", comment)
        if imm_match is None:
            # If no imm was found, ignore the comment.
            # In particular this takes care of useless ARM comments like
            # '82:	46c0      	nop			; (mov r8, r8)'
            return None, ""
        abs_addr = int(imm_match[1], 16)
        if imm_match[2]:
            target, _ = self.parse_target(imm_match[2])
            target.abs = abs_addr
        else:
            target = Address(abs_addr)
        return target, imm_match[3]

    def parse_line(self, line: str, lineno, function_name: str) -> Instruction | None:
        """
        Parses a single line of assembly to create Instruction instance
        """
        # Strip GDB prefix and leading whites
        line = line.removeprefix("=> ")
        line = line.lstrip()

        address, line = self.parse_address(line)
        if address is None:
            return None

        encoding, line = self.parse_encoding(line)
        if not line:
            return encoding

        original_line = line
        body, opcode, ops, line = self.parse_body(line)
        if opcode is None:
            return None

        target, line = self.parse_target(line)

        _, line = self.parse_comment(line)
        if line:
            # Expecting complete parse
            return None

        # Set base symbol for relative addresses
        if address.base is None:
            address.base = function_name
        if target is not None and target.base is None:
            target.base = function_name

        return Instruction(
            body,
            original_line.strip(),
            lineno,
            address,
            opcode,
            ops,
            target,
        )

    def parse_jump_target(self, ops: List[str]) -> int | None:
        # it assumes the first operand to contain the target address
        return int(ops.pop(), 16)
