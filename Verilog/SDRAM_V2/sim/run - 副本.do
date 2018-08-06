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
#vlog	../core/read_fifo.v
#vlog	../core/write_fifo.v
vlog	../sim/SDRAM_tb.v
vlog	../sim/sdram_model_plus.v
vlog	../src/*.v


#==============================================
# simulate the design file by optimization
vsim  -t ns -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver  work.SDRAM_tb
#==============================================
# add signal to wave window
add wave -noupdate /SDRAM_tb/rst_n
add wave -noupdate -divider write_fifo
add wave -noupdate -expand -group write_fifo -radix unsigned /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/wrusedw
add wave -noupdate -expand -group write_fifo /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/rdreq
add wave -noupdate -expand -group write_fifo /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/wrreq
add wave -noupdate -expand -group write_fifo /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/q
add wave -noupdate -expand -group write_fifo /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/data
add wave -noupdate -divider read_fifo
add wave -noupdate -expand -group read_fifo /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_read/rdreq
add wave -noupdate -expand -group read_fifo /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_read/wrreq
add wave -noupdate -expand -group read_fifo -radix unsigned /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_read/wrusedw
add wave -noupdate -expand -group read_fifo /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_read/data
add wave -noupdate -expand -group read_fifo /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_read/q
add wave -noupdate -divider SDRAM_2port_top
add wave -noupdate -expand -group sdram_2port_top /SDRAM_tb/sdram_2port_top_inst/read_en
add wave -noupdate -expand -group sdram_2port_top /SDRAM_tb/sdram_2port_top_inst/read_flag
add wave -noupdate -expand -group sdram_2port_top /SDRAM_tb/sdram_2port_top_inst/write_flag
add wave -noupdate -expand -group sdram_2port_top /SDRAM_tb/sdram_2port_top_inst/sdram_init_done
add wave -noupdate -expand -group sdram_2port_top /SDRAM_tb/sdram_2port_top_inst/sdram_ctrl_inst/cmd_ack
add wave -noupdate -divider sdram_ctrl
add wave -noupdate -expand -group sdram_ctrl /SDRAM_tb/sdram_2port_top_inst/sdram_ctrl_inst/state
add wave -noupdate -expand -group sdram_ctrl /SDRAM_tb/sdram_2port_top_inst/sdram_ctrl_inst/sys_w_req
add wave -noupdate -expand -group sdram_ctrl /SDRAM_tb/sdram_2port_top_inst/sdram_ctrl_inst/sys_r_req
add wave -noupdate -divider sdram_cmd
add wave -noupdate -expand -group sdram_cmd /SDRAM_tb/sdram_2port_top_inst/sdram_cmd_inst/ctrl_cmd
add wave -noupdate -expand -group sdram_cmd /SDRAM_tb/sdram_2port_top_inst/sdram_cmd_inst/do_write
add wave -noupdate /SDRAM_tb/clk
add wave -noupdate -divider sdram
add wave -noupdate -radix unsigned /SDRAM_tb/SDRAM_DQ
#==============================================
# run the simulation
run		220us
















