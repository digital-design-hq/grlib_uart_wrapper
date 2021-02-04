this module wraps grlib uart (dcom_uart) to make it compatible with verilog

the source: `hdl/src/uart.vhd`

check `ghdl.bash` for the list of grlib dependencies

to build: `bash synth.bash`

output file: `uart.v`

dependencies: ghdl, yosys, ghdl-yosys-plugin

module interface:

system interface:

    - rst - connect to system reset. polarity = active low. 0 on this signal resets the module

    - clk - connect to system clock. any clock frequency is acceptable


phy interface:

    - txd - connect to output pin

    - rxd - connect to output pin


status:

    - lock - baudrate lock. connect to a led or leave unconnected


rx data:

    - dready - you can read from this module when dready is high

    - rxdata - this signal is valid when dready is high

    - read - shift out data


    verilog read sequence:

```verilog
        assign read = can_read & dready; // can_read is your logic flag saying you are ready to accept data
        always@(posedge clk)
            if (can_read & dready)
                $fwrite("got byte %d", rxdata);
```

tx data:

    - txempty - you can write to this module if txempty is high

    - txdata - data to send

    - write - command to write data to uart core


    verilog write sequence:

```verilog
        assign write = txempty & can_send; // can_send is your logic flag saying you are ready to send data assigned to txdata
        assign txdata = mydata;
```


--------------------------------------------

to compare original vhdl simulations results to generated verilog simulation results:
1. build and run vhdl simulation `bash sim_ghdl` -> dumps wave.ghw
2. run yosys simulation `bash sim.bash` -> dumps test.vcd
