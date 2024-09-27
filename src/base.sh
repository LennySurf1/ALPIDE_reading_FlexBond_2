#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
RST='\033[0m'
DAQ_UTIL="tools/MB_daq_util"

check_fail(){
	if [[ $1 -ne 0 ]]; then
		echo -en "${RED}****Error: "
		echo -en "${2} ${RST}\n"
		exit 255
	fi;
}

################# check system #################
py_mver=$(python3 -c 'import sys; print(sys.version_info[0])')
if [[ $py_mver -lt 3 ]]; then
	echo -e "${RED}this script requires python version 3${RST}"
	exit 255
fi;

pydeps=("numpy" "matplotlib" "scipy")
for dep in "${pydeps[@]}"; do
	python3 -c "import ${dep}"
	check_fail $? "python deps check error"
done

################### PING FPGA ##################
OUTPUT=$(./$DAQ_UTIL -p 0xdeadbeef 0x1234abcd)
check_fail $? "Fail to ping fpga"

if [[ ${OUTPUT} != $'0xdeadbeef\n0x1234abcd' ]]; then
	echo -e "${RED}Unexpected answer from FPGA after ping:${RST}"
	echo -e "${OUTPUT}"
	echo "check if FPGA is connected and configured"
	exit 255
fi
