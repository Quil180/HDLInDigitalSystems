# ============================================================
# Vivado HLS Tcl Script — Sobel Edge Detection Filter
# Run:  vivado_hls -f run_hls.tcl
# ============================================================

# 1. Create / open project
open_project sobel_hls
set_top sobel_filter
add_files sobel.cpp
add_files -tb sobel_tb.cpp

# 2. Create solution with target device
open_solution "solution1"
# Zynq-7020 (common academic board — change if needed)
set_part {xc7z020clg484-1}
create_clock -period 10 -name default

# 3. C Simulation — verify functional correctness
csim_design

# 4. C Synthesis — default scheduling (no pragmas)
csynth_design

# 5. C/RTL Co-Simulation (VHDL as specified in project)
cosim_design -tool auto -rtl verilog

# 6. Export RTL (use syn_dcp to avoid ip_catalog timestamp overflow bug in 2019.1)
export_design -format syn_dcp

exit
