module four_point_fft (
    input clk,
    input rst,
    input signed [8:0] x0_re,
    input signed [8:0] x1_re,
    input signed [8:0] x2_re,
    input signed [8:0] x3_re,
    output reg signed [10:0] a0_re,
    output reg signed [10:0] a1_re,
    output reg signed [10:0] a1_im,
    output reg signed [10:0] a2_re,
    output reg signed [10:0] a3_re,
    output reg signed [10:0] a3_im
); 

    wire signed [9:0] y0_re;
    wire signed [9:0] y1_re;
    wire signed [9:0] y2_re;
    wire signed [9:0] y3_re;
    assign y0_re = x0_re + x1_re;
    assign y1_re = x0_re - x1_re;
    assign y2_re = x2_re + x3_re;
    assign y3_re = x2_re - x3_re;

    always @(posedge clk) begin
        if (rst) begin
            a0_re <= 0;
            a1_re <= 0;
            a1_im <= 0;
            a2_re <= 0;
            a3_re <= 0;
            a3_im <= 0;
        end else begin
            a0_re <= y0_re + y2_re;
            a1_re <= {y1_re[9], y1_re};
            a1_im <= -{y3_re[9], y3_re};
            a2_re <= y0_re - y2_re;
            a3_re <= {y1_re[9], y1_re};
            a3_im <= {y3_re[9], y3_re};
        end
    end
endmodule
