#include "counter.cpp"
#include <systemc>

using namespace sc_core;
using namespace sc_dt;

int sc_main(int argc, char *argv[]) {
  // 1. Instantiate signals and clock (10ns period, 50% duty cycle)
  sc_clock clk("clk", 10, SC_NS, 0.5);
  sc_signal<bool> reset;
  sc_signal<sc_uint<4>> count;

  // 2. Instantiate Counter4
  Counter4 dut("dut");
  dut.clk(clk);
  dut.reset(reset);
  dut.count(count);

  // 3. Enable VCD tracing
  sc_trace_file *wf = sc_create_vcd_trace_file("counter_trace");
  sc_trace(wf, clk, "clk");
  sc_trace(wf, reset, "reset");
  sc_trace(wf, count, "count");

  // 4. Stimulus and Simulation Control
  std::cout << "Starting simulation..." << std::endl;

  reset.write(true);   // Assert reset
  sc_start(15, SC_NS); // For first 15ns

  reset.write(false); // Release reset

  // Run for the remainder of the 200ns total simulation time
  sc_start(185, SC_NS);

  // 5. Clean up
  std::cout << "Simulation finished. Trace saved to counter_trace.vcd"
            << std::endl;
  sc_close_vcd_trace_file(wf);

  return 0;
}
