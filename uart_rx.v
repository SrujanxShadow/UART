module uart_rx(
    input clk,
    input reset,
    input tick,          // baud tick
    input rx,            // serial input

    output reg [7:0] data_out,
    output reg done
);

    // FSM states
    parameter IDLE  = 3'b000;
    parameter START = 3'b001;
    parameter DATA  = 3'b010;
    parameter STOP  = 3'b011;
    parameter DONE  = 3'b100;

    reg [2:0] state = IDLE;

    reg [7:0] shift_reg;
    reg [2:0] bit_count;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            state <= IDLE;
            bit_count <= 0;
            done <= 0;
        end
        else
        begin
            case(state)

                IDLE:
                begin
                    done <= 0;
                    if (rx == 0)   // detect start bit
                        state <= START;
                end

                START:
                begin
                    if (tick)
                    begin
                        // move to data sampling
                        state <= DATA;
                        bit_count <= 0;
                    end
                end

                DATA:
                begin
                    if (tick)
                    begin
                        shift_reg <= rx, shift_reg[bit_count]; // shift in
                        bit_count <= bit_count + 1;

                        if (bit_count == 7)
                            state <= STOP;
                    end
                end

                STOP:
                begin
                    if (tick)
                    begin
                        state <= DONE;
                    end
                end

                DONE:
                begin
                    data_out <= shift_reg;
                    done <= 1;
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule
