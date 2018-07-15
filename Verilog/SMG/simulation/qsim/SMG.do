onerror {quit -f}
vlib work
vlog -work work SMG.vo
vlog -work work SMG.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.SMG_vlg_vec_tst
vcd file -direction SMG.msim.vcd
vcd add -internal SMG_vlg_vec_tst/*
vcd add -internal SMG_vlg_vec_tst/i1/*
add wave /*
run -all
