#!/bin/bash

source base.sh

case $1 in
	"ON"|"on")
		./tools/MB_daq_util --fpga-write 0x2 0xf
		check_fail $?
		echo "clock enabled on all ports"
		;;
	"OFF"|"off")
		./tools/MB_daq_util --fpga-write 0x2 0x0
		check_fail $?
		echo "clock disabled on all ports"
		;;
	*)
		echo "syntax: bash ${0} on|off"
esac
