# Synthesis script for Pipelined Design (Design Compiler)
# Usage: dc_shell -f scripts/synth_pipelined.tcl

# --- Setup Work Library ---
sh mkdir -p work
define_design_lib WORK -path ./work

# --- Library Setup ---
set search_path [list . /home/net/synopsys/installs/syn/X-2025.06-SP4/libraries/syn/]
set target_library {class.db}
set link_library [list * class.db]

# --- 1. Read the design ---
analyze -format sverilog {src/dot_product.sv}
elaborate dot_product

# --- 2. Define Constraints ---
# 100MHz Target Frequency
create_clock clk -period 10.0
set_input_delay 2.0 -clock clk [all_inputs]
set_output_delay 2.0 -clock clk [all_outputs]

# --- 3. Synthesize ---
compile -map_effort high

# --- 4. Generate Reports ---
# Timing Report (Slack/Fmax)
report_timing > reports/timing_pipelined.txt
# Resource/Area Report (Registers/LUTs)
report_area > reports/area_pipelined.txt
# QoR Summary
report_qor > reports/qor_pipelined.txt

sh mkdir -p reports
mv timing_pipelined.txt reports/
mv area_pipelined.txt reports/
mv qor_pipelined.txt reports/

quit
