module top_module(
    input clk,            // 100 MHz clock
    input reset,          // reset button
    input rx,             // UART RX from PC

    output tx,            // UART TX to PC
    output [7:0] led      // LEDs
);

    wire tick;
    wire [7:0] rx_data;
    wire rx_done;

    // Baud Generator
    baud_generator baud_inst(
        .clk(clk),
        .reset(reset),
        .tick(tick)
    );

    // UART Receiver
    uart_rx rx_inst(
        .clk(clk),
        .reset(reset),
        .tick(tick),
        .rx(rx),
        .data_out(rx_data),
        .done(rx_done)
    );

    // UART Transmitter (optional here)
    uart_tx tx_inst(
        .clk(clk),
        .reset(reset),
        .tick(tick),
        .start(rx_done),     // echo back received data
        .data(rx_data),
        .tx(tx),
        .done()
    );

    // LED Display
    reg [7:0] led_reg;

    always @(posedge clk or posedge reset)
begin
    if (reset)
        led_reg <= 8'b00000000;
    else
    begin
        if (rx_done == 1)
            led_reg <= rx_data;
    end
end

    assign led = led_reg;

endmodule