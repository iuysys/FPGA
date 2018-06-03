onerror {quit -f}
vlib work
vlog -work work CLK_DIV_EVEN.vo
vlog -work work CLK_DIV_EVEN.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.CLK_DIV_EVEN_vlg_vec_tst
vcd file -direction CLK_DIV_EVEN.msim.vcd
vcd add -internal CLK_DIV_EVEN_vlg_vec_tst/*
vcd add -internal CLK_DIV_EVEN_vlg_vec_tst/i1/*
add wave /*
run -all
