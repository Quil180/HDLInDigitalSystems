# 1. Environment & Library Setup
set_app_var target_library {gtech.db}
set_app_var link_library   {* gtech.db}

# 2. Design Ingestion
# Note: testbench_adders.sv is excluded as it is for simulation [cite: 1, 5]
analyze -format sverilog {src/full_adder.sv src/rca.sv src/cla.sv}
elaborate cla 

# 3. Constraints
# Virtual clock to guide the synthesis of combinational logic [cite: 21]
create_clock -name VCLK -period 1.0 
set_max_delay 1.0 -from [all_inputs] -to [all_outputs]

# 4. Synthesis Execution
check_design
compile_exploration

# 5. Comprehensive Reporting
# The "Overall Report" (Quality of Results)
report_qor > reports/overall_qor_report.txt

# Detailed breakdowns
report_timing -delay_type max -max_paths 10 > reports/timing_detail.rpt
report_area -hierarchy > reports/area_hierarchy.rpt
report_power > reports/power_est.rpt
report_resources > reports/resources.rpt

# 6. Finalize
write_hdl -format verilog -output output/cla_synthesized.v
exit
