#!/bin/bash

bash ghdl.bash
yosys -m ghdl synth.ys
