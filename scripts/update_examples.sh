#!/bin/sh

set -eu

cd $(dirname $0)/..

for asm in examples/*.asm; do
  flags=
  if echo $asm | grep -q 'arm.asm'; then
    flags="$flags --target arm"
  fi
  pdf=$(python3 -m src.asm2cfg $flags -c $asm | awk '/Saved CFG/{print $NF}')
  mv $pdf $(echo $asm | sed 's/\.asm/\.pdf/')
done
