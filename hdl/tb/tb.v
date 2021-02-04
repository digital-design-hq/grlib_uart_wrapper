module tb (
);

wire dready;
wire [7:0] rxdata;
wire read;

wire clk;
wire rst;
wire txd;
wire rxd;

task onebit;
    input b;
    begin
        #100
        @(negedge(clk));
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
        onebit(b[7]);
        onebit(b[6]);
        onebit(b[5]);
        onebit(b[4]);
        onebit(b[3]);
        onebit(b[2]);
        onebit(b[1]);
        onebit(b[0]);
        onebit(0);
        onebit(1);
        onebit(1);
        onebit(1);
    end
endtask

initial begin 
    clk = 0;
    rst = 0;
    #20
    rst = 1;
 end

always
    #10 clk = ~clk;

initial begin
    read = 0;
    onebyte(8'hAA);
    onebyte(8'hAA);
    onebyte(8'h55);
    onebyte(8'h55);
    #500
    $finish();
end

uart uart_inst (
    .clk(clk),
    .rst(rst),
    .txd(),
    .rxd(rxd),
    .lock(),
    .dready(dready),
    .rxdata(rxdata),
    .read(read),
    .txempty(),
    .txdata(),
    .write(1'b0)
);

echo uut (
    .clk(clk),
    .rst(rst),
    .txd(rxd),
    .rxd(txd)
);

endmodule;

