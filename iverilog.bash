#!/bin/bash

if [ ! -e uart_wrap.v ]; then
    echo "run 'bash synth.bash' to generate uart_wrap.v netlist"
    exit 1
fi

iverilog hdl/tb/tb.v hdl/src/echo.v -DIVERILOG uart_wrap.v -o test
if [ "$?" == "0" ]; then
    ./test
fi
