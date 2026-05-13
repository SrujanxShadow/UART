module echo(
    input clk,
    input rst,

    input [7:0] rx_data,
    input rx_done,

    input tx_done,

    output reg [7:0] tx_data,
    output reg tx_start
);

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        tx_start <= 0;
        tx_data <= 0;
    end
    else
    begin
        tx_start <= 0; 

        if (rx_done)
        begin
            tx_data <= rx_data;  
            tx_start <= 1;       
        end
    end
end

endmodule
