# TCL script to automate VCS compilation and simulation
# To run this: tclsh run_vcs.tcl

set RTL_FILES "dot_product.sv"
set TB_FILES  "dot_product_tb.sv"
set OUTPUT    "simv"

puts "===================================================="
puts "  VCS Automation Script - Dot Product Engine"
puts "===================================================="

# 1. Compilation
# -sverilog: Enable SystemVerilog support
# -full64: Run in 64-bit mode (common on VLSI servers)
# -debug_acc+all: Enable debug visibility for waveforms and assertions
# -kdb: Generate Knowledge Database for Verdi (if available)
puts "\nStep 1: Compiling Design..."
set compile_cmd "vcs -sverilog -full64 -debug_acc+all -kdb $RTL_FILES $TB_FILES -o $OUTPUT"

if {[catch {exec {*}$compile_cmd} compile_out]} {
    puts "Compilation Output/Errors:\n$compile_out"
    if {![file exists $OUTPUT]} {
        puts "\nERROR: Compilation failed. Simulation binary not created."
        exit 1
    }
} else {
    puts $compile_out
    puts "Compilation successful."
}

# 2. Simulation
puts "\nStep 2: Running Simulation..."
# Open the simulation process for reading
set sim_pipe [open "|./$OUTPUT -ucli -do \"run -all; quit\"" r]

# Print each line as it comes from the simulation
while {[gets $sim_pipe line] >= 0} {
    puts $line
    flush stdout
}

if {[catch {close $sim_pipe} sim_err]} {
    puts "Simulation finished with possible error: $sim_err"
}

puts "\n===================================================="
puts "  Simulation Finished"
puts "===================================================="
