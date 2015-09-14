vlog -reportprogress 300 -work work hw1.v
vsim -voptargs="+acc" hw1test
run 100
