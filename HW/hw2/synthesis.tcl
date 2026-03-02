# ==========================================
# Design Compiler Synthesis Script
# Target: shift_reg
# ==========================================

# Create directories for outputs to keep the workspace clean
file mkdir reports
file mkdir netlist

# 2. Read and Elaborate the Design
analyze -format sverilog {"src/shift_reg.sv"}
elaborate shift_reg

# Set the current design to the top-level module
current_design shift_reg

# 3. Apply Constraints
create_clock -name clk -period 10 [get_ports clk]

# 4. Compile the Design
compile_ultra

# 5. Generate Reports
report_timing > reports/timing.rpt
report_area   > reports/area.rpt
report_power  > reports/power.rpt

# 6. Export the Synthesized Netlist
write -format verilog -hierarchy -output netlist/shift_reg_synth.v

# 7. Exit Design Compiler
exit
