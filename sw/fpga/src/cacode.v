module CACODE (
    input       rst,
    input       clk,
    input [3:0] T0, T1,
    input       rd,

    output            chip,
    output reg [10:1] g1, g2
);
    always @ (posedge clk)
        if (rst) begin
            g1 <= 10'b1111111111;
            g2 <= 10'b1111111111;
        end else
            if (rd) begin
                g1[10:1] <= {g1[9:1], g1[3] ^ g1[10]};
                g2[10:1] <= {g2[9:1], g2[2] ^ g2[3] ^ g2[6] ^ g2[8] ^ g2[9] ^ g2[10]};
            end

    assign chip = g1[10] ^ g2[T0] ^ g2[T1];

endmodule