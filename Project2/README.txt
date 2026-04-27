EEL4783 Project 2: 4-Element Dot Product Engine
=====================================================

Description:
This project implements a 4-element dot product engine in SystemVerilog. 
It features a 2-stage pipeline (Stage 1: Multiplications, Stage 2: Summation) 
for high-performance operation and includes a constrained randomized testbench 
with SystemVerilog Assertions (SVA) for verification.

Files:
- dot_product.sv: RTL implementation of the pipelined engine.
- dot_product_tb.sv: Constrained randomized testbench with SVA.
- README.txt: This file.

Simulation Instructions (Using Questasim/ModelSim):
--------------------------------------------------
1. Log into the VLSI server.
2. Create a library:
   vlib work
3. Compile the design and testbench:
   vlog dot_product.sv dot_product_tb.sv
4. Run the simulation:
   vsim -c dot_product_tb -do "run -all; quit"
   (Omit -c and the -do string to run in GUI mode for waveforms).

Simulation Instructions (Using VCS):
------------------------------------
1. Compile:
   vcs -sverilog dot_product.sv dot_product_tb.sv -o simv
2. Run:
   ./simv

Waveforms:
----------
To generate screenshots for the report:
1. Run the simulation in GUI mode (e.g., 'vsim dot_product_tb').
2. Add signals 'clk', 'rst', 'a', 'b', and 'y' to the wave window.
3. Run for sufficient time (e.g., 'run 300ns').
4. Capture 3 distinct test cases showing the 2-cycle latency between input change and output result.
