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
vlog	-work   work ./*.v
vlog	-work   work ./../src/*.v

#==============================================
# simulate the design file by optimization
vsim -t ns -novopt +notimingchecks  work.SDRAM_TOP_tb

#==============================================
# add signal to wave window
add wave	-divider { SDRAM_top_tb }
add wave	-noupdate sim:/SDRAM_TOP_tb/SDRAM_TOP_inst/SDRAM_WRITE_inst/*


#==============================================
# run the simulation
run		220us
