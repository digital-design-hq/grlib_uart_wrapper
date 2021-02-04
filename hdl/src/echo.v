module echo (
    input clk,
    input rst,
    input rxd,
    output txd
);

wire dready;
wire [7:0] rxdata;
wire read;
wire txempty;
wire [7:0] txdata;
wire write;

wire pump;

assign txdata = rxdata;
assign write = pump;
assign read = pump;

assign pump = dready & txempty;

uart_wrap uart_inst (
    .clk(clk),
    .rst(rst),
    .txd(txd),
    .rxd(rxd),
    .lock(),
    .dready(dready),
    .rxdata(rxdata),
    .read(read),
    .txempty(txempty),
    .txdata(txdata),
    .write(write)
);

endmodule

