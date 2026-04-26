module uart_tx(
    input clk,
    input reset,
    input tick,           // baud tick
    input start,          // start transmission
    input [7:0] data,     // data to send

    output reg tx,        // serial output
    output reg done       // transmission complete
);

    // FSM states
    parameter IDLE  = 2'b00;
    parameter START = 2'b01;
    parameter DATA  = 2'b10;
    parameter STOP  = 2'b11;

    reg [1:0] state = IDLE;

    reg [7:0] shift_reg;   // holds data
    reg [2:0] bit_count;   // counts 0–7

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            state <= IDLE;
            tx <= 1;          // idle line is HIGH
            done <= 0;
            bit_count <= 0;
        end
        else
        begin
            case (state)

                IDLE:
                begin
                    tx <= 1;
                    done <= 0;

                    if (start)
                    begin
                        shift_reg <= data;
                        state <= START;
                    end
                end

                START:
                begin
                    if (tick)
                    begin
                        tx <= 0;     // start bit
                        state <= DATA;
                        bit_count <= 0;
                    end
                end

                DATA:
                begin
                    if (tick)
                    begin
                        tx <= shift_reg[0];   // send LSB
                        shift_reg <= shift_reg[bit_count];
                        bit_count <= bit_count + 1;

                        if (bit_count == 7)
                            state <= STOP;
                    end
                end

                STOP:
                begin
                    if (tick)
                    begin
                        tx <= 1;     // stop bit
                        state <= IDLE;
                        done <= 1;
                    end
                end

            endcase
        end
    end

endmodule
