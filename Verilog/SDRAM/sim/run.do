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
add wave -noupdate -divider SDRAM_CTRL_inst
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/read_en
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_image_pixel_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/read_image_pixel_cnt
add wave -noupdate -divider SDRAM_TOP_tb
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/STATE
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_CLK
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_CKE
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_CS
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_RAS
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_CAS
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WE
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_BANK
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_ADDR
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_DQ
add wave -noupdate -divider SDRAM_WTRITE
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_ack
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/aref_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/fifo_rd_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/STATE
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/burst_cnt
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/flag_aref
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/flag_next_row
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/flag_wd_end
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/row_addr_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/col_addr_cnt
add wave -noupdate -divider SDRAM_READ
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_ack
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/aref_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/fifo_wd_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/STATE
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/burst_cnt
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_aref
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_next_row
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_rd_end
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/row_addr_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/col_addr_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/cas_cnt
#==============================================
# run the simulation
run		220us
