vlog -sv +acc +cover +fcover -l simulation.log interface.sv package.sv top.sv ram.sv
vsim -vopt work.top -voptargs=+acc=npr -assertdebug -l simulation.log -coverage -c -do "coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"

