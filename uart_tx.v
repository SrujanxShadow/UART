module uart_tx (
    input clk,
    input rst,
    input tick,
    input start,
    input [7:0] data,
    output reg tx,
    output reg tx_done
);

parameter IDLE  = 2'd0;
parameter START = 2'd1;
parameter DATA  = 2'd2;
parameter STOP  = 2'd3;

reg [1:0] state;
reg [2:0] bit_index;
reg [7:0] shift_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        tx <= 1;
        tx_done <= 0;
        bit_index <= 0;
        shift_reg <= 0;
    end 
    else begin
        tx_done <= 0;

        case (state)
            IDLE: begin
                tx <= 1;
                if (start) begin
                    shift_reg <= data;
                    tx <= 0;  
                    bit_index <= 0;
                    state <= START;
                end
            end

            START: begin
                if (tick) begin
                    tx <= shift_reg[0];
                    state <= DATA;
                    bit_index <= 1;
                end
            end

            DATA: begin
                if (tick) begin
                    if (bit_index == 7) begin
                        tx <= shift_reg[7];
                        state <= STOP;
                    end 
                    else begin
                        tx <= shift_reg[bit_index];
                        bit_index <= bit_index + 1;
                    end
                end
            end

            STOP: begin
                if (tick) begin
                    tx <= 1;
                    tx_done <= 1;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
