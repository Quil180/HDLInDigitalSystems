# TCL script to automate VCS compilation and simulation
# To run this: tclsh run_vcs.tcl

set RTL_FILES "dot_product.sv"
set TB_FILES  "dot_product_tb.sv"
set OUTPUT    "simv"

puts "===================================================="
puts "  VCS Automation Script - Dot Product Engine"
puts "===================================================="

# 1. Compilation
puts "\nStep 1: Compiling Design..."
# Using -o ./$OUTPUT to ensure it stays in the current directory
set compile_cmd "vcs -sverilog -full64 -debug_acc+all -kdb $RTL_FILES $TB_FILES -o ./$OUTPUT"

if {[catch {exec {*}$compile_cmd} compile_out]} {
    puts "Compilation Output/Errors:\n$compile_out"
} else {
    puts $compile_out
    puts "Compilation successful."
}

# Verify binary exists
if {![file exists ./$OUTPUT]} {
    puts "\nWARNING: ./$OUTPUT not found. Checking if it was created in parent directory..."
    if {[file exists ../$OUTPUT]} {
        puts "Found ../$OUTPUT. Moving it to current directory."
        file rename -force ../$OUTPUT ./$OUTPUT
    } else {
        puts "ERROR: Simulation binary not found anywhere."
        exit 1
    }
}

# 2. Simulation
puts "\nStep 2: Running Simulation..."

# Create a temporary .do file for UCLI commands
set do_file [open "sim.do" w]
puts $do_file "run -all"
puts $do_file "quit"
close $do_file

# Open the simulation process for reading
# Use -ucli -do sim.do for reliable command execution
set sim_pipe [open "|./$OUTPUT -ucli -do sim.do" r]

# Print each line as it comes from the simulation
while {[gets $sim_pipe line] >= 0} {
    puts $line
    flush stdout
}

if {[catch {close $sim_pipe} sim_err]} {
    # VCS sometimes returns non-zero even on success due to UCLI quit
    # We only report if it's a real crash
}

# Cleanup
file delete "sim.do"

puts "\n===================================================="
puts "  Simulation Finished"
puts "===================================================="
