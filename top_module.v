module top_module (
    input clk,
    input rst,
    input rx,
    output tx,
    output [7:0] led
);

wire tick, half_tick;
wire baud_sync;  
wire [7:0] rx_data;
wire rx_done;
wire tx_done;
wire tx_start;
wire [7:0] tx_data;

baud_generator baud (
    .clk(clk),
    .rst(rst),
    .sync_rst(baud_sync),
    .tick(tick),
    .half_tick(half_tick)
);

uart_rx rxuut (
    .clk(clk),
    .rst(rst),
    .tick(tick),
    .half_tick(half_tick),
    .rx(rx),
    .data_out(rx_data),
    .rx_done(rx_done),
    .baud_sync(baud_sync)
);

  echo uut (
      .clk(clk),
      .rst(rst),
      .rx_data(rx_data),
      .rx_done(rx_done),
      .tx_done(tx_done),
      .tx_data(tx_data),
      .tx_start(tx_start)
  );

uart_tx txuut (
    .clk(clk),
    .rst(rst),
    .tick(tick),
    .start(tx_start),
    .data(tx_data),
    .tx(tx),
    .tx_done(tx_done)
);

data dat (
    .clk(clk),
    .reset(rst),
    .rx_data(rx_data),
    .rx_done(rx_done),
    .led(led)
);

endmodule
