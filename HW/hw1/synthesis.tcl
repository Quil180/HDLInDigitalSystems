# 0. Setup Directories (Prevents "could not open file" errors)
file mkdir reports
file mkdir output

# 1. Environment & Library Setup
set_app_var target_library {gtech.db}
set_app_var link_library   {* gtech.db}

# 2. Design Ingestion
analyze -format sverilog {src/full_adder.sv src/rca.sv src/cla.sv}
elaborate cla 
link

# 3. Constraints
create_clock -name VCLK -period 1.0 
set_max_delay 1.0 -from [all_inputs] -to [all_outputs]

# 4. Synthesis Execution
check_design
# REPLACEMENT: 'compile_ultra' is the standard DC command
compile_ultra

# 5. Comprehensive Reporting
report_qor > reports/overall_qor_report.txt
report_timing -delay_type max -max_paths 10 > reports/timing_detail.rpt
report_area -hierarchy > reports/area_hierarchy.rpt
report_power > reports/power_est.rpt
report_resources > reports/resources.rpt

# 6. Finalize
# REPLACEMENT: 'write' is the standard DC command
write -format verilog -hierarchy -output output/cla_synthesized.v
exit
