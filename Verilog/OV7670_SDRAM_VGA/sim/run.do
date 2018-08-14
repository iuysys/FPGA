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
vlog	../core/*.v
vlog	../sim/*.v
vlog	../src/*.v
vlog	../src/OV7670/*.v
vlog	../src/sdram_v2/*.v
vlog	../src/vga/*.v

#==============================================
# simulate the design file by optimization
vsim  -t ps -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver work.OV7670_SDRAM_VGA_tb
#==============================================
# add signal to wave window
add wave -noupdate /OV7670_SDRAM_VGA_tb/sys_clk
add wave -noupdate /OV7670_SDRAM_VGA_tb/rst_n
add wave -noupdate -divider OV7670
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV_vsync
add wave -noupdate -radix unsigned /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/OV7670_top_inst/OV7670_Capture_inst/state
add wave -noupdate -divider sdram_cmd
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/clk
add wave -noupdate /OV7670_SDRAM_VGA_tb/SDRAM_CLK
add wave -noupdate -radix unsigned /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/ctrl_cmd
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/do_aref
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/do_write
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/do_read
add wave -noupdate -radix unsigned /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/step_cnt
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/m_cmd
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/m_bank
add wave -noupdate -radix unsigned /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_cmd_inst/m_addr
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/VGA_CTRL_inst/vga_r_en
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/VGA_CTRL_inst/vga_r_req
add wave -noupdate /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/VGA_CTRL_inst/vga_display_en
add wave -noupdate -radix unsigned /OV7670_SDRAM_VGA_tb/OV7670_SDRAM_VGA_inst/sdram_2port_top_inst/sdram_fifo_read/wrusedw
#==============================================
# run the simulation
run 300us
