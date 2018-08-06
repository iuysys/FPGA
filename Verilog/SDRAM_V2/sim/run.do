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
add wave -noupdate /SDRAM_tb/clk
add wave -noupdate /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/rdreq
add wave -noupdate /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/rdclk
add wave -noupdate /SDRAM_tb/sdram_2port_top_inst/sdram_cmd_inst/do_write
add wave -noupdate -radix unsigned /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/q
add wave -noupdate -radix unsigned /SDRAM_tb/sdram_2port_top_inst/SDRAM_DQ
add wave -noupdate /SDRAM_tb/SDRAM_CLK
#==============================================
# run the simulation
run		220us
















