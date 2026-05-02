create_clock -name clk -period 1 [get_ports clk]
set_input_delay -clock { clk } 0 [get_ports {a*}]
set_output_delay -clock { clk } 0 [get_ports {resulta[*]}]