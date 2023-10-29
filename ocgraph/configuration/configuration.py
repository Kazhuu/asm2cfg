#!/usr/bin/env python3
"""Module for configuration of the ocgraph package."""
import logging

from .architecture.architecture import Architecture
from .architecture.x86 import X86Architecture
from .architecture.arm import ArmArchitecture
from .architecture.sparc import SparcArchitecture
from .architecture.ppc import PpcArchitecture

from .disassembler.disassembler import Disassembler
from .disassembler.objdump_sparc import ObjDumpSparcDisassembler
from .disassembler.objdump_ppc import ObjDumpPpcDisassembler
from .disassembler.gdb_default import GdbDisassembler

# fmt: off
disassembler_option: dict[str, dict] = {
    "OBJDUMP": {
        "sparc": ObjDumpSparcDisassembler(),
        "ppc": ObjDumpPpcDisassembler(),
    },
    "GDB": {
        "sparc": GdbDisassembler(),
        "ppc": GdbDisassembler(),
    },
}

architecture_option: dict[str, dict] = {
    "x86": {
        "platform": "X86",
        "architecture": X86Architecture(),
    },
    "arm": {
        "platform": "ARM",
        "architecture": ArmArchitecture(),
    },
    "sparc": {
        "platform": "SPARC",
        "architecture": SparcArchitecture(),
    },
    "ppc": {
        "platform": "PPC",
        "architecture": PpcArchitecture(),
    },
}

preset_logging: dict[str, dict] = {
    "development": {
        "file_log": "debug.log",
        "file_level": logging.DEBUG,
        "console_log": True,
        "console_level": logging.DEBUG,
    },
    "module": {
        "file_log": None,
        "file_level": logging.ERROR,
        "console_log": False,
        "console_level": logging.ERROR,
    },
    "default": {
        "file_log": "asm2cfg.log",
        "file_level": logging.INFO,
        "console_log": True,
        "console_level": logging.INFO,
    },
}
# fmt: on


class OcGraphConfiguration:
    """Implement configuration presets for the ASM2CFG tool."""

    def __init__(
        self, arch: str = "sparc", disassembler: str = "OBJDUMP", logging_preset="default"
    ):
        if architecture_option.get(arch) is None:
            raise NotImplementedError("Architecture option not supported!")
        if disassembler_option.get(disassembler) is None:
            raise NotImplementedError("Disassembler option not supported!")
        if preset_logging.get(logging_preset) is None:
            raise NotImplementedError("Logging preset not supported!")

        # load module preset
        _preset = architecture_option[arch]
        _preset["disassembler"] = disassembler_option[disassembler][arch]
        self.__dict__ = _preset

        # configure logging
        log_config = preset_logging.get(logging_preset)
        if log_config["file_log"]:
            file_stream: logging.FileHandler = logging.FileHandler(log_config["file_log"])
            file_stream.setLevel(log_config["file_level"])
            self.logger.addHandler(file_stream)
        if log_config["console_log"]:
            console_stream: logging.StreamHandler = logging.StreamHandler()
            console_stream.setLevel(log_config["console_level"])
            self.logger.addHandler(console_stream)

    @staticmethod
    def architectures():
        """Return all available architectures options"""
        return architecture_option.keys()

    @staticmethod
    def disassemblers():
        """Return all available disassemblers options"""
        return disassembler_option.keys()

    @staticmethod
    def loggers():
        """Return all available disassemblers options"""
        return preset_logging.keys()

    logger: logging.Logger = logging.Logger("OcGraph")
    """Logging mechanism for module"""

    architecture: Architecture
    """Target architecture instance"""

    disassembler: Disassembler
    """Target disassembler tool like OBJDump, GDB, ..."""
