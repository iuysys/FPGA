onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SDRAM_tb/clk
add wave -noupdate /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/rdreq
add wave -noupdate /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/rdclk
add wave -noupdate /SDRAM_tb/sdram_2port_top_inst/sdram_cmd_inst/do_write
add wave -noupdate -radix unsigned /SDRAM_tb/sdram_2port_top_inst/sdram_fifo_write/q
add wave -noupdate -radix unsigned /SDRAM_tb/sdram_2port_top_inst/SDRAM_DQ
add wave -noupdate /SDRAM_tb/SDRAM_CLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200879 ns} 0}
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
WaveRestoreZoom {200680 ns} {200906 ns}
