source [file join [file dirname [info script]] ./../../ip/top_juart/sim/common/riviera_files.tcl]
source [file join [file dirname [info script]] ./../../ip/top_niosv/sim/common/riviera_files.tcl]
source [file join [file dirname [info script]] ./../../ip/top_ram/sim/common/riviera_files.tcl]
source [file join [file dirname [info script]] ./../../ip/top_clk/sim/common/riviera_files.tcl]

namespace eval top {
  proc get_design_libraries {} {
    set libraries [dict create]
    set libraries [dict merge $libraries [top_juart::get_design_libraries]]
    set libraries [dict merge $libraries [top_niosv::get_design_libraries]]
    set libraries [dict merge $libraries [top_ram::get_design_libraries]]
    set libraries [dict merge $libraries [top_clk::get_design_libraries]]
    dict set libraries altera_merlin_axi_translator_1987    1
    dict set libraries altera_merlin_slave_translator_191   1
    dict set libraries altera_merlin_axi_master_ni_19117    1
    dict set libraries altera_merlin_slave_agent_1930       1
    dict set libraries altera_avalon_sc_fifo_1932           1
    dict set libraries altera_merlin_axi_slave_ni_19129     1
    dict set libraries altera_avalon_st_pipeline_stage_1930 1
    dict set libraries altera_merlin_router_1921            1
    dict set libraries altera_merlin_demultiplexer_1921     1
    dict set libraries altera_merlin_multiplexer_1922       1
    dict set libraries altera_mm_interconnect_1920          1
    dict set libraries altera_reset_controller_1924         1
    dict set libraries top                                  1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR QUARTUS_INSTALL_DIR} {
    set memory_files [list]
    set memory_files [concat $memory_files [top_juart::get_memory_files "$QSYS_SIMDIR/../ip/top_juart/sim/" "$QUARTUS_INSTALL_DIR"]]
    set memory_files [concat $memory_files [top_niosv::get_memory_files "$QSYS_SIMDIR/../ip/top_niosv/sim/" "$QUARTUS_INSTALL_DIR"]]
    set memory_files [concat $memory_files [top_ram::get_memory_files "$QSYS_SIMDIR/../ip/top_ram/sim/" "$QUARTUS_INSTALL_DIR"]]
    set memory_files [concat $memory_files [top_clk::get_memory_files "$QSYS_SIMDIR/../ip/top_clk/sim/" "$QUARTUS_INSTALL_DIR"]]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    set design_files [dict merge $design_files [top_juart::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_juart/sim/"]]
    set design_files [dict merge $design_files [top_niosv::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_niosv/sim/"]]
    set design_files [dict merge $design_files [top_ram::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_ram/sim/"]]
    set design_files [dict merge $design_files [top_clk::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_clk/sim/"]]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR QUARTUS_INSTALL_DIR} {
    set design_files [list]
    set design_files [concat $design_files [top_juart::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_juart/sim/" "$QUARTUS_INSTALL_DIR"]]
    set design_files [concat $design_files [top_niosv::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_niosv/sim/" "$QUARTUS_INSTALL_DIR"]]
    set design_files [concat $design_files [top_ram::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_ram/sim/" "$QUARTUS_INSTALL_DIR"]]
    set design_files [concat $design_files [top_clk::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_clk/sim/" "$QUARTUS_INSTALL_DIR"]]
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_translator_1987/sim/top_altera_merlin_axi_translator_1987_jmx322a.sv"]\"  -work altera_merlin_axi_translator_1987"                                 
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_slave_translator_191/sim/top_altera_merlin_slave_translator_191_xg7rzxi.sv"]\"  -work altera_merlin_slave_translator_191"                              
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_translator_1987/sim/top_altera_merlin_axi_translator_1987_lty7xoq.sv"]\"  -work altera_merlin_axi_translator_1987"                                 
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_master_ni_19117/sim/altera_merlin_address_alignment.sv"]\"  -work altera_merlin_axi_master_ni_19117"                                               
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_master_ni_19117/sim/top_altera_merlin_axi_master_ni_19117_a33l7ua.sv"]\"  -work altera_merlin_axi_master_ni_19117"                                 
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_slave_agent_1930/sim/top_altera_merlin_slave_agent_1930_jxauz3i.sv"]\"  -work altera_merlin_slave_agent_1930"                                          
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_slave_agent_1930/sim/altera_merlin_burst_uncompressor.sv"]\"  -work altera_merlin_slave_agent_1930"                                                    
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_avalon_sc_fifo_1932/sim/top_altera_avalon_sc_fifo_1932_22gxxgi.v"]\"  -work altera_avalon_sc_fifo_1932"                                                  
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/top_altera_merlin_axi_slave_ni_altera_avalon_sc_fifo_19129_fs67l3a.v"]\"  -work altera_merlin_axi_slave_ni_19129"          
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_avalon_st_pipeline_stage_1930/sim/top_altera_avalon_st_pipeline_stage_1930_oiupeiq.sv"]\"  -work altera_avalon_st_pipeline_stage_1930"                        
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_avalon_st_pipeline_stage_1930/sim/altera_avalon_st_pipeline_base.v"]\"  -work altera_avalon_st_pipeline_stage_1930"                                           
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/top_altera_merlin_axi_slave_ni_altera_avalon_st_pipeline_stage_19129_a5cmeay.v"]\"  -work altera_merlin_axi_slave_ni_19129"
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/top_altera_merlin_axi_slave_ni_altera_avalon_st_pipeline_stage_19129_zyff54i.v"]\"  -work altera_merlin_axi_slave_ni_19129"
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/top_altera_merlin_axi_slave_ni_altera_avalon_st_pipeline_stage_19129_6ngu5fy.v"]\"  -work altera_merlin_axi_slave_ni_19129"
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/altera_merlin_burst_uncompressor.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/altera_merlin_address_alignment.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                 
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/compare_eq.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                                      
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/rd_response_mem_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/rd_comp_sel_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                             
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/rd_pri_mux_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                              
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/rd_sipo_plus_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                            
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/wr_response_mem_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/wr_comp_sel_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                             
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/wr_pri_mux_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                              
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/wr_sipo_plus_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                                            
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_axi_slave_ni_19129/sim/top_altera_merlin_axi_slave_ni_19129_jimy6za.sv"]\"  -work altera_merlin_axi_slave_ni_19129"                                    
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/top_altera_merlin_router_1921_v5rfyli.sv"]\"  -work altera_merlin_router_1921"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/top_altera_merlin_router_1921_jbra4kq.sv"]\"  -work altera_merlin_router_1921"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/top_altera_merlin_router_1921_et7blli.sv"]\"  -work altera_merlin_router_1921"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/top_altera_merlin_router_1921_rw2a5pi.sv"]\"  -work altera_merlin_router_1921"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/top_altera_merlin_router_1921_wud6yfi.sv"]\"  -work altera_merlin_router_1921"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/top_altera_merlin_router_1921_23fta3q.sv"]\"  -work altera_merlin_router_1921"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/top_altera_merlin_router_1921_dkyrmhq.sv"]\"  -work altera_merlin_router_1921"                                                         
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_demultiplexer_1921/sim/top_altera_merlin_demultiplexer_1921_jd7cwai.sv"]\"  -work altera_merlin_demultiplexer_1921"                                    
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_demultiplexer_1921/sim/top_altera_merlin_demultiplexer_1921_donqkmi.sv"]\"  -work altera_merlin_demultiplexer_1921"                                    
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1922/sim/top_altera_merlin_multiplexer_1922_w4guyuy.sv"]\"  -work altera_merlin_multiplexer_1922"                                          
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1922/sim/altera_merlin_arbitrator.sv"]\"  -work altera_merlin_multiplexer_1922"                                                            
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1922/sim/top_altera_merlin_multiplexer_1922_4zg7kyq.sv"]\"  -work altera_merlin_multiplexer_1922"                                          
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1922/sim/altera_merlin_arbitrator.sv"]\"  -work altera_merlin_multiplexer_1922"                                                            
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1922/sim/top_altera_merlin_multiplexer_1922_ql6jrba.sv"]\"  -work altera_merlin_multiplexer_1922"                                          
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1922/sim/altera_merlin_arbitrator.sv"]\"  -work altera_merlin_multiplexer_1922"                                                            
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_mm_interconnect_1920/sim/top_altera_mm_interconnect_1920_wwna2kq.v"]\"  -work altera_mm_interconnect_1920"                                               
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_reset_controller_1924/sim/altera_reset_controller.v"]\"  -work altera_reset_controller_1924"                                                             
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_reset_controller_1924/sim/altera_reset_synchronizer.v"]\"  -work altera_reset_controller_1924"                                                           
    lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/top.v"]\"  -work top"                                                                                                                                              
    return $design_files
  }
  
  proc get_non_duplicate_elab_option {ELAB_OPTIONS NEW_ELAB_OPTION} {
    set IS_DUPLICATE [string first $NEW_ELAB_OPTION $ELAB_OPTIONS]
    if {$IS_DUPLICATE == -1} {
      return $NEW_ELAB_OPTION
    } else {
      return ""
    }
  }
  
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [top_juart::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [top_niosv::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [top_ram::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [top_clk::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    append SIM_OPTIONS [top_juart::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [top_niosv::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [top_ram::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [top_clk::get_sim_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_juart::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_niosv::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_ram::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_clk::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ENV_VARIABLES
  }
  
  
  proc normalize_path {FILEPATH} {
      if {[catch { package require fileutil } err]} { 
          return $FILEPATH 
      } 
      set path [fileutil::lexnormalize [file join [pwd] $FILEPATH]]  
      if {[file pathtype $FILEPATH] eq "relative"} { 
          set path [fileutil::relative [pwd] $path] 
      } 
      return $path 
  } 
  proc get_dpi_libraries {QSYS_SIMDIR} {
    set libraries [dict create]
    set libraries [dict merge $libraries [top_juart::get_dpi_libraries "$QSYS_SIMDIR/../ip/top_juart/sim/"]]
    set libraries [dict merge $libraries [top_niosv::get_dpi_libraries "$QSYS_SIMDIR/../ip/top_niosv/sim/"]]
    set libraries [dict merge $libraries [top_ram::get_dpi_libraries "$QSYS_SIMDIR/../ip/top_ram/sim/"]]
    set libraries [dict merge $libraries [top_clk::get_dpi_libraries "$QSYS_SIMDIR/../ip/top_clk/sim/"]]
    
    return $libraries
  }
  
}
