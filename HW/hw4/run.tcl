# Verification using VCS
puts "Starting VCS Verification..."
set vcs_cmd "vcs -full64 -sverilog +define+VCS src/unpipelined.sv src/pipelined.sv testbench/tb_top.sv -o simv"
if {[catch {exec {*}$vcs_cmd} result]} {
    puts "VCS Compilation Error: $result"
} else {
    puts "VCS Compilation Successful."
    set sim_cmd "./simv"
    if {[catch {exec {*}$sim_cmd} sim_result]} {
        puts "Simulation Output:\n$sim_result"
    } else {
        puts "Simulation Output:\n$sim_result"
    }
}

# Synthesis using Synplify
puts "\nStarting Synplify Synthesis..."
set syn_tcl [open "synth.tcl" w]
puts $syn_tcl "add_file -verilog src/unpipelined.sv"
puts $syn_tcl "add_file -verilog src/pipelined.sv"
puts $syn_tcl "set_option -technology 7-Series"
puts $syn_tcl "set_option -part XC7K70T"
puts $syn_tcl "project -run"
puts $syn_tcl "project -save hw4_synthesis.prj"
close $syn_tcl

set syn_cmd "synplify_pro -batch synth.tcl"
if {[catch {exec {*}$syn_cmd} syn_result]} {
    puts "Synplify Error: $syn_result"
} else {
    puts "Synplify Synthesis Successful."
    puts $syn_result
}
