onerror {resume}
quietly WaveActivateNextPane {} 0
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {202098 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {200254 ns} {203870 ns}
