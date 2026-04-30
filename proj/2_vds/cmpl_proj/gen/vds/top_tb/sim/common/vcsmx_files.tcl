source [file join [file dirname [info script]] ./../../../top/sim/common/vcsmx_files.tcl]
source [file join [file dirname [info script]] ./../../ip/top_inst_clk_bfm_ip/sim/common/vcsmx_files.tcl]
source [file join [file dirname [info script]] ./../../ip/top_inst_reset_bfm_ip/sim/common/vcsmx_files.tcl]

namespace eval top_tb {
  proc get_design_libraries {} {
    set libraries [dict create]
    set libraries [dict merge $libraries [top::get_design_libraries]]
    set libraries [dict merge $libraries [top_inst_clk_bfm_ip::get_design_libraries]]
    set libraries [dict merge $libraries [top_inst_reset_bfm_ip::get_design_libraries]]
    dict set libraries top_tb 1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR QUARTUS_INSTALL_DIR} {
    set memory_files [list]
    set memory_files [concat $memory_files [top::get_memory_files "$QSYS_SIMDIR/../../top/sim/" "$QUARTUS_INSTALL_DIR"]]
    set memory_files [concat $memory_files [top_inst_clk_bfm_ip::get_memory_files "$QSYS_SIMDIR/../ip/top_inst_clk_bfm_ip/sim/" "$QUARTUS_INSTALL_DIR"]]
    set memory_files [concat $memory_files [top_inst_reset_bfm_ip::get_memory_files "$QSYS_SIMDIR/../ip/top_inst_reset_bfm_ip/sim/" "$QUARTUS_INSTALL_DIR"]]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    set design_files [dict merge $design_files [top::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../top/sim/"]]
    set design_files [dict merge $design_files [top_inst_clk_bfm_ip::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_inst_clk_bfm_ip/sim/"]]
    set design_files [dict merge $design_files [top_inst_reset_bfm_ip::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_inst_reset_bfm_ip/sim/"]]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR QUARTUS_INSTALL_DIR} {
    set design_files [list]
    set design_files [concat $design_files [top::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../top/sim/" "$QUARTUS_INSTALL_DIR"]]
    set design_files [concat $design_files [top_inst_clk_bfm_ip::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_inst_clk_bfm_ip/sim/" "$QUARTUS_INSTALL_DIR"]]
    set design_files [concat $design_files [top_inst_reset_bfm_ip::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../ip/top_inst_reset_bfm_ip/sim/" "$QUARTUS_INSTALL_DIR"]]
    lappend design_files "vlogan +v2k $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"$QSYS_SIMDIR/top_tb.v\"  -work top_tb"
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
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [top::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [top_inst_clk_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    append ELAB_OPTIONS [get_non_duplicate_elab_option $ELAB_OPTIONS [top_inst_reset_bfm_ip::get_elab_options $SIMULATOR_TOOL_BITNESS]]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    append SIM_OPTIONS [top::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [top_inst_clk_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [top_inst_reset_bfm_ip::get_sim_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_inst_clk_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [top_inst_reset_bfm_ip::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ENV_VARIABLES
  }
  
  
  proc get_dpi_libraries {QSYS_SIMDIR} {
    set libraries [dict create]
    set libraries [dict merge $libraries [top::get_dpi_libraries "$QSYS_SIMDIR/../../top/sim/"]]
    set libraries [dict merge $libraries [top_inst_clk_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../ip/top_inst_clk_bfm_ip/sim/"]]
    set libraries [dict merge $libraries [top_inst_reset_bfm_ip::get_dpi_libraries "$QSYS_SIMDIR/../ip/top_inst_reset_bfm_ip/sim/"]]
    
    return $libraries
  }
  
}
