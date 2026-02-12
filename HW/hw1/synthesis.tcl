# 0. Setup Directories
file mkdir reports
file mkdir output

# 1. Environment & Library Setup
set_app_var target_library {class.db}
set_app_var link_library   {* class.db}

# 2. Design Ingestion 
# Analyze all source files once (Full Adder is likely a dependency for RCA)
analyze -format sverilog {src/full_adder.sv src/rca.sv src/cla.sv}

# Define the list of top-level modules to synthesize
set designs {rca cla}

# Loop through each design
foreach design $designs {
    puts "----------------------------------------------------------------"
    puts "Starting Synthesis for: $design"
    puts "----------------------------------------------------------------"

    # Elaborate the specific current design
    elaborate $design
    link

    # 3. Constraints (Applied specifically to the current design)
    create_clock -name VCLK -period 1.0 
    set_max_delay 1.0 -from [all_inputs] -to [all_outputs]

    # 4. Synthesis Execution
    check_design
    compile_ultra

    # 5. Comprehensive Reporting (Using specific filenames per design)
    report_qor > reports/${design}_qor.txt
    report_timing -delay_type max -max_paths 10 > reports/${design}_timing.rpt
    report_area -hierarchy > reports/${design}_area.rpt
    report_power > reports/${design}_power.rpt
    report_resources > reports/${design}_resources.rpt

    # 6. Finalize
    write -format verilog -hierarchy -output output/${design}_synthesized.v

    # Clean up the design from memory before the next iteration
    remove_design -all
}

puts "All synthesis runs completed."
exit
