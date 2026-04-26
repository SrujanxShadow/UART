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

