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
# -ucli: Use Universal Command Line Interface
# -do: Run commands (run all and then quit)
set sim_cmd "./$OUTPUT -ucli -do \"run -all; quit\""

if {[catch {exec {*}$sim_cmd} sim_out]} {
    puts "Simulation Output/Errors:\n$sim_out"
} else {
    puts $sim_out
}

puts "\n===================================================="
puts "  Simulation Finished"
puts "===================================================="
