#! /bin/bash

make clean

./install_lowlevelhw_env.sh
source .lowlevelhw/bin/activate
./gen_essffw_regbanks.sh
hdlmake
make synthesize
