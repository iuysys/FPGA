onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider SDRAM_CTRL_inst
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_en
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_image_pixel_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_image_pixel_cnt
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
add wave -noupdate -divider SDRAM_READ
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/S_CLK
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/RST_N
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_ack
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/aref_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/fifo_wd_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/sdram_addr
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_addr
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_cmd
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/STATE
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/burst_cnt
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_aref
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_next_row
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_rd_end
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/row_addr_cnt
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/col_addr_cnt
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/cas_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {207076 ns} 0}
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
WaveRestoreZoom {206717 ns} {207621 ns}
