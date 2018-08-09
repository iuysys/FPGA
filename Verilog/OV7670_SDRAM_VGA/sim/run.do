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
vlog	../core/*.v
vlog	../sim/*.v
vlog	../src/*.v
vlog	../src/OV7670/*.v
vlog	../src/sdram_v2/*.v
vlog	../src/vga/*.v

#==============================================
# simulate the design file by optimization
vsim  -t ps -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver work.OV7670_SDRAM_VGA_tb
#==============================================
# add signal to wave window

#==============================================
# run the simulation
run 220us
