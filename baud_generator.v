module baud_generator(
    input clk,          // 100 MHz clock from Basys 3
    input reset,        // reset signal
    output reg tick     // baud rate tick output
);

    parameter BAUD_COUNT = 10416;  // for 9600 baud

    reg [13:0] count = 0;   // enough to count up to 10416

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            count <= 0;
            tick <= 0;
        end
        else
        begin
            if (count == BAUD_COUNT - 1)
            begin
                count <= 0;
                tick <= 1;   // generate 1-cycle pulse
            end
            else
            begin
                count <= count + 1;
                tick <= 0;
            end
        end
    end

endmodule