
set_input_delay -clock { the_pll_inst|iopll_0_refclk } -min 0 [get_ports {in_ex1}]
set_input_delay -clock { the_pll_inst|iopll_0_refclk } -max 1 [get_ports {in_ex1}]
