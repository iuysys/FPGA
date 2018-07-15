vlog -work work F:/FPGA/Verilog/SMG/simulation/modelsim/SMG.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.SMG_vlg_vec_tst
onerror {resume}
add wave {SMG_vlg_vec_tst/i1/CLK}
add wave {SMG_vlg_vec_tst/i1/DATA}
add wave {SMG_vlg_vec_tst/i1/DATA[15]}
add wave {SMG_vlg_vec_tst/i1/DATA[14]}
add wave {SMG_vlg_vec_tst/i1/DATA[13]}
add wave {SMG_vlg_vec_tst/i1/DATA[12]}
add wave {SMG_vlg_vec_tst/i1/DATA[11]}
add wave {SMG_vlg_vec_tst/i1/DATA[10]}
add wave {SMG_vlg_vec_tst/i1/DATA[9]}
add wave {SMG_vlg_vec_tst/i1/DATA[8]}
add wave {SMG_vlg_vec_tst/i1/DATA[7]}
add wave {SMG_vlg_vec_tst/i1/DATA[6]}
add wave {SMG_vlg_vec_tst/i1/DATA[5]}
add wave {SMG_vlg_vec_tst/i1/DATA[4]}
add wave {SMG_vlg_vec_tst/i1/DATA[3]}
add wave {SMG_vlg_vec_tst/i1/DATA[2]}
add wave {SMG_vlg_vec_tst/i1/DATA[1]}
add wave {SMG_vlg_vec_tst/i1/DATA[0]}
add wave {SMG_vlg_vec_tst/i1/DUAN}
add wave {SMG_vlg_vec_tst/i1/DUAN[7]}
add wave {SMG_vlg_vec_tst/i1/DUAN[6]}
add wave {SMG_vlg_vec_tst/i1/DUAN[5]}
add wave {SMG_vlg_vec_tst/i1/DUAN[4]}
add wave {SMG_vlg_vec_tst/i1/DUAN[3]}
add wave {SMG_vlg_vec_tst/i1/DUAN[2]}
add wave {SMG_vlg_vec_tst/i1/DUAN[1]}
add wave {SMG_vlg_vec_tst/i1/DUAN[0]}
add wave {SMG_vlg_vec_tst/i1/RST_N}
add wave {SMG_vlg_vec_tst/i1/SEL}
add wave {SMG_vlg_vec_tst/i1/SEL[2]}
add wave {SMG_vlg_vec_tst/i1/SEL[1]}
add wave {SMG_vlg_vec_tst/i1/SEL[0]}
run -all
