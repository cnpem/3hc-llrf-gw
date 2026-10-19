#! /bin/bash

python3 -m venv .lowlevelhw

pushd ../ip_cores/ess-fpga-framework
make install_py
popd
