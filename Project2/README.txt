EEL4783 Project 2: 4-Element Dot Product Engine
=====================================================

Description:
This project implements a 4-element dot product engine in SystemVerilog. 
It features a 2-stage pipeline (Stage 1: Multiplications, Stage 2: Summation) 
for high-performance operation and includes a constrained randomized testbench 
with SystemVerilog Assertions (SVA) for verification.

Files:
- dot_product.sv: RTL implementation of the pipelined engine.
- dot_product_tb.sv: Constrained randomized testbench with SVA and FSDB dumping.
- run_vcs.tcl: Automation script for compilation and simulation.
- README.txt: This file.

Simulation Instructions (Using VCS Automation Script):
------------------------------------------------------
1. Ensure 'vcs' and 'tclsh' are in your PATH.
2. Run the automation script:
   tclsh run_vcs.tcl
   
This script handles compilation, elabration, and running the simulation 
automatically.

Simulation Instructions (Manual VCS Commands):
----------------------------------------------
1. Compile and Elaboration:
   vcs -sverilog -full64 -debug_acc+all -kdb dot_product.sv dot_product_tb.sv -o simv
2. Run Simulation:
   ./simv -ucli -do "run; quit"
   
This will generate 'inter.fsdb' for waveform viewing.

Waveforms (Using Synopsys Verdi):
---------------------------------
1. Open Verdi with the simulation database:
   verdi -dbdir simv.daidir &
2. Open the Waveform window (Ctrl+W).
3. In the Waveform window, go to File -> Import Waveform and select 'inter.fsdb'.
4. In the main Verdi window, select 'dot_product_tb' in the Hierarchy pane.
5. Drag signals 'clk', 'rst', 'a', 'b', and 'y' into the Waveform window.
6. To see decimal values, right-click signals in the Waveform window and 
   select Radix -> Decimal (Signed).
