create_clock -name clk -period 2 [get_ports clk]
set_input_delay -clock { clk } -min 0 [get_ports {in_ex1}]
set_input_delay -clock { clk } -max 1 [get_ports {in_ex1}]

set_false_path -to [get_ports {out_ex1}]

#set_false_path -from [get_keepers {reset_in reset_sh[0]}]
