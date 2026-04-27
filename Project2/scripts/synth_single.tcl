# Synthesis script for Single-Cycle Design (Design Compiler)
# Usage: dc_shell -f scripts/synth_single.tcl

# --- Setup Work Library ---
sh mkdir -p work
define_design_lib WORK -path ./work

# --- Library Setup ---
set search_path [list . /home/net/synopsys/installs/syn/X-2025.06-SP4/libraries/syn/]
set target_library {class.db}
set link_library [list * class.db]

# --- 1. Read the design ---
analyze -format sverilog {src/dot_product_single.sv}
elaborate dot_product_single

# --- 2. Define Constraints ---
create_clock clk -period 10.0
set_input_delay 2.0 -clock clk [all_inputs]
set_output_delay 2.0 -clock clk [all_outputs]

# --- 3. Synthesize ---
compile -map_effort high

# --- 4. Generate Reports ---
sh mkdir -p reports
report_timing > reports/timing_single.txt
report_area > reports/area_single.txt
report_qor > reports/qor_single.txt

quit
