#!/bin/bash

# 1. Clean up old files
rm -rf csrc simv* ucli.key vc_hdrs.h

# 2. Compile the design and testbench
# -sverilog: Enables SystemVerilog support
# -debug_access+all: Enables debugging/waveform generation
# -kdb: (Optional) Enables Verdi Knowledge Database
vcs -full64 -sverilog -debug_access+all \
    src/*.sv \
    -o simv

# 3. Run the simulation
# +ntb_random_seed_automatic: Good for randomized TBs
./simv +ntb_random_seed_automatic
