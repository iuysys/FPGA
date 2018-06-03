onerror {quit -f}
vlib work
vlog -work work key_mod.vo
vlog -work work key_mod.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.key_mod_vlg_vec_tst
vcd file -direction key_mod.msim.vcd
vcd add -internal key_mod_vlg_vec_tst/*
vcd add -internal key_mod_vlg_vec_tst/i1/*
add wave /*
run -all
