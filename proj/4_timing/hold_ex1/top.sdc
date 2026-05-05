
set_input_delay -clock { the_pll_inst|iopll_0_refclk } -min 0 [get_ports {in_ex1}]
set_input_delay -clock { the_pll_inst|iopll_0_refclk } -max 1 [get_ports {in_ex1}]

set_false_path -to [get_ports {out_ex1}]

set_false_path -from [get_keepers {reset_in reset_sh[0]}]
set_false_path -from [get_ports in_vec*]
set_false_path -to [get_ports out_vec*]
