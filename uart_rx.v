module uart_rx (
    input clk,
    input rst,
    input tick,
    input half_tick,
    input rx,
    output reg [7:0] data_out,
    output reg rx_done,
    output reg baud_sync
);

parameter IDLE  = 2'd0;
parameter START = 2'd1;
parameter DATA  = 2'd2;
parameter STOP  = 2'd3;

reg [1:0] state;
reg [2:0] bit_index;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        bit_index <= 0;
        data_out <= 0;
        rx_done <= 0;
        baud_sync <= 0;
    end 
    else begin
        rx_done <= 0;
        baud_sync <= 0;

        case (state)
            IDLE: begin
                if (rx==0) begin
                    baud_sync <= 1; 
                    state <= START;
                end
            end

            START: begin
                if (half_tick) begin
                    if (rx==0) begin
                        state <= DATA;
                        bit_index <= 0;
                    end 
                    else state <= IDLE;
                end
            end

            DATA: begin
                if (tick) begin
                    data_out[bit_index] <= rx;
                    if (bit_index == 7)
                        state <= STOP;
                    else
                        bit_index <= bit_index + 1;
                end
            end

            STOP: begin
                if (tick) begin
                    rx_done <= 1;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
