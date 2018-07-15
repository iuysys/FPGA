onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider SDRAM_CTRL_inst
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_en
add wave -noupdate /SDRAM_TOP_tb/SDRAM_CTRL_inst/read_en
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/write_image_pixel_cnt
add wave -noupdate -radix unsigned /SDRAM_TOP_tb/SDRAM_CTRL_inst/read_image_pixel_cnt
add wave -noupdate -divider SDRAM_TOP_tb
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_req
add wave -noupdate /SDRAM_TOP_tb/SDRAM_TOP_inst/write_en
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
add wave -noupdate -group SDRAM_WRITE /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_cmd
add wave -noupdate -group SDRAM_WRITE -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_addr
add wave -noupdate -group SDRAM_WRITE /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_ack
add wave -noupdate -group SDRAM_WRITE /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/write_en
add wave -noupdate -group SDRAM_WRITE /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/fifo_rd_req
add wave -noupdate -group SDRAM_WRITE -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/burst_cnt
add wave -noupdate -group SDRAM_WRITE -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/STATE
add wave -noupdate -divider SDRAM_READ
add wave -noupdate -expand -group SDRAM_READ /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_ack
add wave -noupdate -expand -group SDRAM_READ /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_en
add wave -noupdate -expand -group SDRAM_READ /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/fifo_wd_req
add wave -noupdate -expand -group SDRAM_READ -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_addr
add wave -noupdate -expand -group SDRAM_READ /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/read_cmd
add wave -noupdate -expand -group SDRAM_READ -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/STATE
add wave -noupdate -expand -group SDRAM_READ -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/burst_cnt
add wave -noupdate -expand -group SDRAM_READ -radix unsigned /SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_READ_inst/cas_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {226134 ns} 0}
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
WaveRestoreZoom {155550 ns} {283550 ns}
