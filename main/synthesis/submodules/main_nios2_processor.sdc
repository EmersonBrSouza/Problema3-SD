# Legal Notice: (C)2019 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	main_nios2_processor 	main_nios2_processor:*
set 	main_nios2_processor_oci 	main_nios2_processor_nios2_oci:the_main_nios2_processor_nios2_oci
set 	main_nios2_processor_oci_break 	main_nios2_processor_nios2_oci_break:the_main_nios2_processor_nios2_oci_break
set 	main_nios2_processor_ocimem 	main_nios2_processor_nios2_ocimem:the_main_nios2_processor_nios2_ocimem
set 	main_nios2_processor_oci_debug 	main_nios2_processor_nios2_oci_debug:the_main_nios2_processor_nios2_oci_debug
set 	main_nios2_processor_wrapper 	main_nios2_processor_jtag_debug_module_wrapper:the_main_nios2_processor_jtag_debug_module_wrapper
set 	main_nios2_processor_jtag_tck 	main_nios2_processor_jtag_debug_module_tck:the_main_nios2_processor_jtag_debug_module_tck
set 	main_nios2_processor_jtag_sysclk 	main_nios2_processor_jtag_debug_module_sysclk:the_main_nios2_processor_jtag_debug_module_sysclk
set 	main_nios2_processor_oci_path 	 [format "%s|%s" $main_nios2_processor $main_nios2_processor_oci]
set 	main_nios2_processor_oci_break_path 	 [format "%s|%s" $main_nios2_processor_oci_path $main_nios2_processor_oci_break]
set 	main_nios2_processor_ocimem_path 	 [format "%s|%s" $main_nios2_processor_oci_path $main_nios2_processor_ocimem]
set 	main_nios2_processor_oci_debug_path 	 [format "%s|%s" $main_nios2_processor_oci_path $main_nios2_processor_oci_debug]
set 	main_nios2_processor_jtag_tck_path 	 [format "%s|%s|%s" $main_nios2_processor_oci_path $main_nios2_processor_wrapper $main_nios2_processor_jtag_tck]
set 	main_nios2_processor_jtag_sysclk_path 	 [format "%s|%s|%s" $main_nios2_processor_oci_path $main_nios2_processor_wrapper $main_nios2_processor_jtag_sysclk]
set 	main_nios2_processor_jtag_sr 	 [format "%s|*sr" $main_nios2_processor_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$main_nios2_processor_oci_break_path|break_readreg*] -to [get_keepers *$main_nios2_processor_jtag_sr*]
set_false_path -from [get_keepers *$main_nios2_processor_oci_debug_path|*resetlatch]     -to [get_keepers *$main_nios2_processor_jtag_sr[33]]
set_false_path -from [get_keepers *$main_nios2_processor_oci_debug_path|monitor_ready]  -to [get_keepers *$main_nios2_processor_jtag_sr[0]]
set_false_path -from [get_keepers *$main_nios2_processor_oci_debug_path|monitor_error]  -to [get_keepers *$main_nios2_processor_jtag_sr[34]]
set_false_path -from [get_keepers *$main_nios2_processor_ocimem_path|*MonDReg*] -to [get_keepers *$main_nios2_processor_jtag_sr*]
set_false_path -from *$main_nios2_processor_jtag_sr*    -to *$main_nios2_processor_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$main_nios2_processor_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$main_nios2_processor_oci_debug_path|monitor_go
