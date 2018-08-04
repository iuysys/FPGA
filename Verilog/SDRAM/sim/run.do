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
vlog	../core/read_fifo.v
vlog	../core/write_fifo.v
vlog	../sim/*.v
vlog	../src/*.v

#==============================================
# simulate the design file by optimization
vsim  -t ns -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver  work.SDRAM_TOP_tb
#==============================================
# add signal to wave window
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/S_CLK
add wave -noupdate /SDRAM_TOP_tb/RST_N
add wave -noupdate -divider SDRAM_CTRL_inst
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/w_fifo_usedw
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/r_fifo_usedw
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/addr
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/bank
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_ack
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/read_ack
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/read_en
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/STATE
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/addr_w
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/addr_r
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/w_bank_flag
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/r_bank_flag
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/pp_flag
add wave -noupdate -divider SDRAM_TOP_tb
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/read_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/STATE
add wave -noupdate -group SDRAM_CMD /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_CLK
add wave -noupdate -group SDRAM_CMD /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_CKE
add wave -noupdate -group SDRAM_CMD /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_CS
add wave -noupdate -group SDRAM_CMD /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_RAS
add wave -noupdate -group SDRAM_CMD /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_CAS
add wave -noupdate -group SDRAM_CMD /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WE
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_BANK
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_ADDR
add wave -noupdate -radix hexadecimal /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_DQ
add wave -noupdate -divider SDRAM_WTRITE
add wave -noupdate -expand -group SDRAM_WRITE /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_cmd
add wave -noupdate -expand -group SDRAM_WRITE -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_addr
add wave -noupdate -expand -group SDRAM_WRITE /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_ack
add wave -noupdate -expand -group SDRAM_WRITE /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_en
add wave -noupdate -expand -group SDRAM_WRITE /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/fifo_rd_req
add wave -noupdate -expand -group SDRAM_WRITE -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/burst_cnt
add wave -noupdate -expand -group SDRAM_WRITE -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/STATE
add wave -noupdate -divider SDRAM_READ
add wave -noupdate -expand -group SDRAM_READ /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_ack
add wave -noupdate -expand -group SDRAM_READ /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_en
add wave -noupdate -expand -group SDRAM_READ /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/fifo_wd_req
add wave -noupdate -expand -group SDRAM_READ -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_addr
add wave -noupdate -expand -group SDRAM_READ /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_cmd
add wave -noupdate -expand -group SDRAM_READ -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/STATE
add wave -noupdate -expand -group SDRAM_READ -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/burst_cnt
add wave -noupdate -expand -group SDRAM_READ -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/cas_cnt
add wave -noupdate -group write_fifo -radix unsigned /SDRAM_TOP_tb/write_fifo_inst/data
add wave -noupdate -group write_fifo /SDRAM_TOP_tb/write_fifo_inst/rdclk
add wave -noupdate -group write_fifo /SDRAM_TOP_tb/write_fifo_inst/rdreq
add wave -noupdate -group write_fifo /SDRAM_TOP_tb/write_fifo_inst/wrclk
add wave -noupdate -group write_fifo /SDRAM_TOP_tb/write_fifo_inst/wrreq
add wave -noupdate -group write_fifo -radix unsigned /SDRAM_TOP_tb/write_fifo_inst/q
add wave -noupdate -group write_fifo -radix unsigned /SDRAM_TOP_tb/write_fifo_inst/wrusedw
#==============================================
# run the simulation
run		220us
