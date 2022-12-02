"""
asm format adjustment
"""

import re
import sys
import tempfile
from collections import defaultdict
from graphviz import Digraph
from colour import Color

def replaceline(infile, outfile):
    infopen = open(infile, 'r', encoding="utf-8")
    outfopen = open(outfile, 'w', encoding="utf-8")

    lines = infopen.readlines()
    for line in lines:
        if line.split():
            # print(str(line).replace(">debug", " fill='"'red'"'>"))
            outfopen.writelines(str(line).replace(">debug", " fill='"'green'"'>"))
        else:
            outfopen.writelines("")

    infopen.close()
    outfopen.close()
def replaceline_0(infile, outfile):
    infopen = open(infile, 'r', encoding="utf-8")
    outfopen = open(outfile, 'w', encoding="utf-8")

    lines = infopen.readlines()
    for line in lines:
        if line.split():
            tmp = str(line)
            tmp = tmp.replace("fill="+'"'+"#000000"+'"', "")
            tmp = tmp.replace("fill="+'"'+"#ffffff"+'"', "")
            # fill="#ffffff"
            outfopen.writelines(tmp)
            
        else:
            outfopen.writelines("")

    infopen.close()
    outfopen.close()

def replaceline2(infile, outfile):
    infopen = open(infile, 'r', encoding="utf-8")
    outfopen = open(outfile, 'w', encoding="utf-8")

    lines = infopen.readlines()
    for line in lines:
        if line.split():
            # print(str(line).replace(">debug", " fill='"'red'"'>"))
            
            # if(str(line).find("white") >=0):
            if(str(line).find("green") <=0):
                outfopen.writelines(str(line).replace(">0x","fill=\"white\">0x"))
            else:
                outfopen.writelines(str(line))
            
        else:
            outfopen.writelines("")

    infopen.close()
    outfopen.close()

def delblankline(infile, outfile):
    infopen = open(infile, 'r', encoding="utf-8")
    outfopen = open(outfile, 'w', encoding="utf-8")

    lines = infopen.readlines()
    for line in lines:
        if line.split():
            outfopen.writelines(line)
        else:
            outfopen.writelines("")
    infopen.close()
    outfopen.close()