# 1. Environment & Library Setup
set_app_var target_library {gtech.db}
set_app_var link_library   {* gtech.db}

# 2. Design Ingestion
analyze -format sverilog {src/full_adder.sv src/rca.sv src/cla.sv}
elaborate cla 
# Note: In DC, 'link' is usually automatic during simple flows, 
# but adding it explicitly is good practice.
link 

# 3. Constraints
# Virtual clock is fine for combinational logic (Input-to-Output constraints)
create_clock -name VCLK -period 1.0 
set_max_delay 1.0 -from [all_inputs] -to [all_outputs]

# 4. Synthesis Execution
check_design

# FIX 1: Use 'compile_ultra' instead of the RTL Architect command 'compile_exploration'
# compile_ultra provides the best quality of results for DC.
compile_ultra

# 5. Comprehensive Reporting
# FIX 2: Create directories before writing to them to avoid "could not open" errors
file mkdir reports
file mkdir output

report_qor > reports/overall_qor_report.txt
report_timing -delay_type max -max_paths 10 > reports/timing_detail.rpt
report_area -hierarchy > reports/area_hierarchy.rpt
report_power > reports/power_est.rpt
report_resources > reports/resources.rpt

# 6. Finalize
# FIX 3: Use 'write' instead of 'write_hdl'
write -format verilog -hierarchy -output output/cla_synthesized.v
exit
