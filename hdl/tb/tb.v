module tb (
);

wire dready;
wire [7:0] rxdata;
reg read;

reg clk;
reg rst;
reg txd;
wire rxd;

task onebit;
    input b;
    begin
        #1000
        txd = b;
    end
endtask

task onebyte;
    input [7:0] b;
    begin
        onebit(1);
        onebit(1);
        onebit(1);
        onebit(0);
        onebit(b[0]);
        onebit(b[1]);
        onebit(b[2]);
        onebit(b[3]);
        onebit(b[4]);
        onebit(b[5]);
        onebit(b[6]);
        onebit(b[7]);
        onebit(1);
        onebit(1);
        onebit(1);
        onebit(1);
    end
endtask

initial begin 
`ifdef IVERILOG
    $dumpfile("iverilog.vcd");
    $dumpvars(0, tb);
`endif
    txd = 1'b1;
    clk = 0;
    rst = 0;
    #40
    rst = 1;
 end

always
    #10 clk = ~clk;

initial begin
    read = 0;
    #5
    onebyte(8'h55);
    onebyte(8'h55);
    onebyte(8'h55);
    onebyte(8'h55);
`ifdef IVERILOG
    #500
    $finish();
`endif
end

uart_wrap uart_inst (
    .clk(clk),
    .rst(rst),
    .txd(),
    .rxd(rxd),
    .lock(),
    .dready(dready),
    .rxdata(rxdata),
    .read(read),
    .txempty(),
    .txdata(8'h00),
    .write(1'b0)
);

echo uut (
    .clk(clk),
    .rst(rst),
    .txd(rxd),
    .rxd(txd)
);

endmodule

