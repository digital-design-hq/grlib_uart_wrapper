#!/bin/bash
ghdl -a --work=grlib grlib/lib/grlib/stdlib/config_types.vhd 
ghdl -a --work=grlib grlib/lib/grlib/stdlib/version.vhd 
ghdl -a --work=grlib grlib/lib/grlib/stdlib/config.vhd 
ghdl -a --work=grlib grlib/lib/grlib/stdlib/stdlib.vhd 
ghdl -a --work=grlib grlib/lib/grlib/amba/amba.vhd 
ghdl -a --work=grlib grlib/lib/grlib/amba/devices.vhd 
ghdl -a --work=techmap grlib/lib/techmap/gencomp/gencomp.vhd 
ghdl -a --work=gaisler grlib/lib/gaisler/uart/uart.vhd 
ghdl -a --work=gaisler grlib/lib/gaisler/misc/misc.vhd 
ghdl -a --work=gaisler grlib/lib/gaisler/uart/libdcom.vhd 
ghdl -a grlib/lib/gaisler/uart/dcom_uart.vhd 
ghdl -a hdl/src/uart.vhd 
