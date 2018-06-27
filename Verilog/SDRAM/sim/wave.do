onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider SDRAM_CTRL_inst
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_en
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
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/burst_cnt
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_aref
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_next_row
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/flag_rd_end
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/row_addr_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/col_addr_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/cas_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {215684 ns} 0}
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
WaveRestoreZoom {212043 ns} {219267 ns}
