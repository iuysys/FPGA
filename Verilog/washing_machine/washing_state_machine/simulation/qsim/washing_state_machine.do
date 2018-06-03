onerror {quit -f}
vlib work
vlog -work work washing_state_machine.vo
vlog -work work washing_state_machine.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.washing_state_machine_vlg_vec_tst
vcd file -direction washing_state_machine.msim.vcd
vcd add -internal washing_state_machine_vlg_vec_tst/*
vcd add -internal washing_state_machine_vlg_vec_tst/i1/*
add wave /*
run -all
