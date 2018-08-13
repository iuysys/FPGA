#==============================================
# exit the current simulation
quit	-sim

#==============================================
# clear the console message
.main	clear

#==============================================
# make the phyical library
vlib	work

#==============================================
# mapping the logic library and phyical library
vmap	work work

#==============================================
# complie the design file
vlog	../sim/SDRAM_TOP_tb.v
vlog	../sim/sdram_model_plus.v
vlog	../src/*.v


#==============================================
# simulate the design file by optimization
vsim  -t ns -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver  work.SDRAM_TOP_tb
#==============================================
# add signal to wave window
add wave -noupdate /SDRAM_TOP_tb/clk
add wave -noupdate /SDRAM_TOP_tb/sdram_clk_in
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/sys_addr
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/ctrl_cmd
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/dq_oe
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_fifo_write/wrusedw
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_fifo_read/rdusedw
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/step_cnt
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/cmd_ack
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/do_aref
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/do_write
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/do_read
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/m_cmd
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/m_bank
add wave -noupdate /SDRAM_TOP_tb/sdram_2port_top_inst/sdram_cmd_inst/m_addr
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_ADDR
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_DQ
add wave -noupdate /SDRAM_TOP_tb/SDRAM_RAS
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CAS
add wave -noupdate /SDRAM_TOP_tb/SDRAM_WE
#==============================================
# run the simulation
run		220us
















