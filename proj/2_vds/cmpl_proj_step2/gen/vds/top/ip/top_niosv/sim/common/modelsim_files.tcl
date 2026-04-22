
namespace eval top_niosv {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries altera_reset_controller_1924 1
    dict set libraries intel_niosv_c_unit_420       1
    dict set libraries intel_niosv_c_420            1
    dict set libraries top_niosv                    1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR QUARTUS_INSTALL_DIR} {
    set memory_files [list]
    return $memory_files
  }
  
  proc get_common_design_files {QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {QSYS_SIMDIR QUARTUS_INSTALL_DIR} {
    set design_files [list]
    lappend design_files "-makelib altera_reset_controller_1924 \"[normalize_path "$QSYS_SIMDIR/../altera_reset_controller_1924/sim/altera_reset_controller.v"]\"   -end"                
    lappend design_files "-makelib altera_reset_controller_1924 \"[normalize_path "$QSYS_SIMDIR/../altera_reset_controller_1924/sim/altera_reset_synchronizer.v"]\"   -end"              
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/niosv_reset_controller.v"]\"   -end"                             
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/ecc_enc.sv"]\"   -end"                                 
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/ecc_dec.sv"]\"   -end"                                 
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/altecc_enc.sv"]\"   -end"                              
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/altecc_dec.sv"]\"   -end"                              
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/riscv.pkg.sv"]\"   -end"                               
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv.pkg.sv"]\"   -end"                               
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_ram.sv"]\"   -end"                               
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp.pkg.sv"]\"   -end"                           
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_alu.sv"]\"   -end"                           
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_mult.sv"]\"   -end"                          
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_shift.sv"]\"   -end"                         
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_shift_fast.sv"]\"   -end"                    
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_zbb.sv"]\"   -end"                           
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_rf.sv"]\"   -end"                            
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_csr.sv"]\"   -end"                           
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_cdec.sv"]\"   -end"                          
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_fsm.sv"]\"   -end"                           
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_axi_channel_fsm.sv"]\"   -end"                   
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_axi4lite_if.sv"]\"   -end"                   
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_avalon_if.sv"]\"   -end"                     
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/niosv_cpp_core.sv"]\"   -end"                          
    lappend design_files "-makelib intel_niosv_c_unit_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_unit_420/sim/intelfpga/top_niosv_intel_niosv_c_unit_420_i5xhjda.sv"]\"   -end"
    lappend design_files "-makelib intel_niosv_c_420 \"[normalize_path "$QSYS_SIMDIR/../intel_niosv_c_420/sim/top_niosv_intel_niosv_c_420_qiadggq.v"]\"   -end"                          
    lappend design_files "-makelib top_niosv \"[normalize_path "$QSYS_SIMDIR/top_niosv.v"]\"   -end"                                                                                     
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
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
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
    
    return $libraries
  }
  
}
