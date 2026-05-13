module baud_generator (
    input clk,
    input rst,
    input sync_rst, 
    output reg tick,
    output reg half_tick
);

parameter BAUD_DIV = 10416;  // 100 MHz / 9600
parameter HALF_DIV = 5208;

reg [13:0] counter;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter <= 0;
        tick <= 0;
        half_tick <= 0;
    end 
    else begin
        tick <= 0;
        half_tick <= 0;

        if (sync_rst) begin
            counter <= 0;
        end 
        else if (counter == BAUD_DIV - 1) begin
            counter <= 0;
            tick <= 1;
        end 
        else begin
            if (counter == HALF_DIV - 1)
                half_tick <= 1;
                counter <= counter + 1;
        end
    end
end

endmodule
