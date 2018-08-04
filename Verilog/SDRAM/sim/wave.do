onerror {resume}
quietly WaveActivateNextPane {} 0
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199920 ns} 0}
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
WaveRestoreZoom {199528 ns} {203138 ns}
