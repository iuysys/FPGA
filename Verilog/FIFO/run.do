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
vlog	S:/altera/13.0sp1/quartus/eda/sim_lib/220model.v
vlog	S:/altera/13.0sp1/quartus/eda/sim_lib/altera_mf.v
vlog	*.v




#==============================================
# simulate the design file by optimization
vsim -t ns -novopt +notimingchecks  work.FIFO_T_vlg_tst
#==============================================
# add signal to wave window

#==============================================
# run the simulation
run		220us
