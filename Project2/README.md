# EEL4783 Project 2: 4-Element Dot Product Engine

## Overview
This project implements a 4-element dot product engine in SystemVerilog. 
It features a 2-stage pipeline (Stage 1: Multiplications, Stage 2: Summation) for high-performance operation and includes a constrained randomized testbench with SystemVerilog Assertions (SVA) for verification.

### Key Features
- **Pipelined Architecture**: 2-stage synchronous datapath for throughput.
- **Handshake Protocol**: Added `vld_in` and `vld_out` signals to gate valid data and ignore pipeline "warm-up" transients.
- **Signed Arithmetic**: Uses `logic signed` throughout to correctly handle two's complement 8-bit inputs (-128 to 127).
- **Automated Verification**: SVA properties ensure cycle-accurate correctness matching the 2-cycle latency.

## Project Structure
- `src/`: Core RTL implementation files.
  - `dot_product.sv`: Pipelined dot product engine.
  - `dot_product_single.sv`: Single-cycle dot product engine.
- `tb/`: Testbench files.
  - `dot_product_tb.sv`: Constrained randomized testbench with SVA.
- `scripts/`: Automation and synthesis scripts.
  - `run_vcs.tcl`: VCS simulation automation.
  - `synth_pipelined.tcl`: Design Compiler synthesis for pipelined design.
  - `synth_single.tcl`: Design Compiler synthesis for single-cycle design.
- `docs/`: Project documentation and reports.
  - `EEL4783_project_2_given.pdf`: Original project specification.
  - `report_guide.txt`: Guidelines for writing the project report.
  - `report.pdf`: Final project report.
  - `report.tex`: LaTeX source for the report.

## Simulation Instructions

### Using VCS Automation Script
1. Ensure `vcs` and `tclsh` are in your PATH.
2. From the project root, run:
   ```bash
   tclsh scripts/run_vcs.tcl
   ```
This script handles compilation, elaboration, and running the simulation automatically.

### Manual VCS Commands
1. **Compile and Elaboration:**
   ```bash
   vcs -sverilog -full64 -debug_acc+all -kdb src/dot_product.sv tb/dot_product_tb.sv -o simv
   ```
2. **Run Simulation:**
   ```bash
   ./simv -ucli -do "run; quit"
   ```
This will generate `inter.fsdb` for waveform viewing.

## Waveforms (Using Synopsys Verdi)
1. Open Verdi with the simulation database:
   ```bash
   verdi -dbdir simv.daidir &
   ```
2. Open the Waveform window (**Ctrl+W**).
3. In the Waveform window, go to **File -> Import Waveform** and select `inter.fsdb`.
4. In the main Verdi window, select `dot_product_tb` in the Hierarchy pane.
5. Drag signals `clk`, `rst`, `a`, `b`, and `y` into the Waveform window.
6. To see decimal values, right-click signals in the Waveform window and select **Radix -> Decimal (Signed)**.

## Synthesis
To perform synthesis using Synopsys Design Compiler:
```bash
dc_shell -f scripts/synth_pipelined.tcl
```
or
```bash
dc_shell -f scripts/synth_single.tcl
```
