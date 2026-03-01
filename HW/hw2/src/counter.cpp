#include <systemc>

using namespace sc_core;
using namespace sc_dt;

SC_MODULE(Counter4) {
  sc_in<bool> clk, reset;
  sc_out<sc_uint<4>> count;
  sc_uint<4> current_val; // Internal state

  void count_proc() {
    // Synchronous active-high reset
    if (reset.read() == true) {
      current_val = 0;
    } else {
      // sc_uint<4> automatically wraps at 15
      current_val = current_val + 1;
    }
    count.write(current_val);
  }

  SC_CTOR(Counter4) {
    SC_METHOD(count_proc);
    sensitive << clk.pos(); // Trigger on rising edge of clock
  }
};
