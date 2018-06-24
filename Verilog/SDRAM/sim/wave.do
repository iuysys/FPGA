onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider SDRAM_CTRL_inst
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_en
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/image_cnt
add wave -noupdate -divider SDRAM_TOP_tb
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/STATE
add wave -noupdate -divider SDRAM_WTRITE
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {215700 ns} 0}
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
WaveRestoreZoom {0 ns} {231 us}
