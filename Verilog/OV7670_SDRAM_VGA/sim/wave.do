onerror {resume}
quietly WaveActivateNextPane {} 0
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {285227273 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {200750 ns} {515750 ns}
