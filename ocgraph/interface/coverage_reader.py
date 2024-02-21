#!/usr/bin/env python
# SPDX-License-Identifier: GTDGmbH
"""Class for read coverage input and update the instruction."""
import ast
import csv

from ..data.instruction import Instruction
from ..configuration.configuration import OcGraphConfiguration


class CoverageReader:  # pylint: disable=too-few-public-methods
    """CoverageReader Class"""

    def __init__(self, instructions: [Instruction], config: OcGraphConfiguration):
        self.instructions = instructions
        self.config = config

    def update_by_csv(self, file_path: str):
        """Read coverage csv file and update"""
        # Store for coverage information
        coverage_info: dict[int, set[int]] = {}

        # read the csv file. expected values in address and branch_jumps
        with open(file_path, "r", newline="", encoding="utf-8") as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                _temp = ast.literal_eval(row["branch_jumps"])
                coverage_info[int(row["address"], 0)] = {int(x, 0) for x in _temp}
        # update instructions
        for instr in self.instructions:
            if coverage_info.get(instr.address.abs, None) is not None:
                is_branch = self.config.architecture.is_branch(instr)
                instr.update_coverage(coverage_info[instr.address.abs], is_branch=is_branch)
