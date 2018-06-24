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
vlog	-work   work ./*.v
vlog	-work   work ./../src/*.v

#==============================================
# simulate the design file by optimization
vsim -t ns -novopt +notimingchecks  work.SDRAM_TOP_tb

#==============================================
# add signal to wave window
add wave	-divider { SDRAM_CTRL_inst }
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_en
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/image_cnt
add wave	-divider { SDRAM_TOP_tb }
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/STATE
add wave	-divider { SDRAM_WTRITE }
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/S_CLK
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/RST_N
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_ack
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/aref_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/fifo_rd_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/sdram_addr
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_addr
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_cmd
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/STATE
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/burst_cnt
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/flag_aref
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/flag_next_row
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/flag_wd_end
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/row_addr_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/col_addr_cnt

#==============================================
# run the simulation
run		220us
