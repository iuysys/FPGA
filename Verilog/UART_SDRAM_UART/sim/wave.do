onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/UART_Rxd_inst/rx_data
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/UART_Rxd_CTRL_inst/rx_data_out
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_write/wrreq
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_write/data
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_write/q
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_write/rdreq
add wave -noupdate /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/clk
add wave -noupdate /UART_SDRAM_UART_tb/SDRAM_CLK
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/SDRAM_DQ
add wave -noupdate /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_read/wrclk
add wave -noupdate /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_read/wrreq
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_read/data
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_read/wrusedw
add wave -noupdate /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/UART_Txd_CTRL_inst/data_in
add wave -noupdate /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/UART_Txd_CTRL_inst/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {632729 ns} 0}
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
WaveRestoreZoom {632722 ns} {632841 ns}
