@echo off
set xv_path=D:\\xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto a7fe511d7fde4e2dbe5570af212e2ecb -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot sim_behav xil_defaultlib.sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
