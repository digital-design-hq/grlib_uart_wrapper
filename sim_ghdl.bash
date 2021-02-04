#!/bin/bash

rm *.o
rm *.cf
rm tb
rm ghdl.ghw

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

ghdl -a hdl/src/uart_wrap.vhd hdl/src/echo.vhd hdl/tb/tb.vhd
ghdl -e tb
if [ "$?" == "0" ]; then
    echo "starting sim"
    ./tb --wave=ghdl.ghw
fi
