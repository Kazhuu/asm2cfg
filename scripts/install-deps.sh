#!/bin/sh

set -eu
set -x

PYTHON=${PYTHON:-python3}

sudo apt-get update
sudo apt-get install $PYTHON gdb graphviz -y ${PYTHON}-distutils
# Install graphviz globally because of GDB using global python
# installation and not active pipenv.
pip3 install graphviz
