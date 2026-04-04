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

# Synthesis using Vivado
puts "\nStarting Vivado Synthesis..."
set synth_tcl [open "synth_vivado.tcl" w]
puts $synth_tcl "read_verilog -sv src/unpipelined.sv"
puts $synth_tcl "read_verilog -sv src/pipelined.sv"
puts $synth_tcl "synth_design -top pipelined -part xc7k70tfbg484-2"
puts $synth_tcl "report_utilization -file utilization_pipe.txt"
puts $synth_tcl "report_timing -file timing_pipe.txt"
puts $synth_tcl "synth_design -top unpipelined -part xc7k70tfbg484-2"
puts $synth_tcl "report_utilization -file utilization_un.txt"
puts $synth_tcl "report_timing -file timing_un.txt"
puts $synth_tcl "exit"
close $synth_tcl

set vivado_cmd "vivado -mode batch -source synth_vivado.tcl -nolog -nojournal"
if {[catch {exec {*}$vivado_cmd} vivado_result]} {
    puts "Vivado Error: $vivado_result"
} else {
    puts "Vivado Synthesis Successful."
    puts "Reports generated: utilization_pipe.txt, timing_pipe.txt, utilization_un.txt, timing_un.txt"
}
