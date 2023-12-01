module fft (
    input clk,
    input rst,
    input [7:0] x0_re,
    input [7:0] x1_re,
    input [7:0] x2_re,
    input [7:0] x3_re,
    input [7:0] x4_re,
    input [7:0] x5_re,
    input [7:0] x6_re,
    input [7:0] x7_re,
    output reg signed [11:0] a0_re,
    output reg signed [11:0] a1_re,
    output reg signed [11:0] a1_im,
    output reg signed [11:0] a2_re,
    output reg signed [11:0] a2_im,
    output reg signed [11:0] a3_re,
    output reg signed [11:0] a3_im,
    output reg signed [11:0] a4_re,
    output reg signed [11:0] a5_re,
    output reg signed [11:0] a5_im,
    output reg signed [11:0] a6_re,
    output reg signed [11:0] a6_im,
    output reg signed [11:0] a7_re,
    output reg signed [11:0] a7_im
); 

    wire signed [10:0] y0_re;
    wire signed [10:0] y1_re;
    wire signed [10:0] y1_im;
    wire signed [10:0] y2_re;
    wire signed [10:0] y3_re;
    wire signed [10:0] y3_im;
    four_point_fft fft0 (
        .clk(clk),
        .rst(rst),
        .x0_re({1'b0,x0_re}),
        .x1_re({1'b0,x4_re}),
        .x2_re({1'b0,x2_re}),
        .x3_re({1'b0,x6_re}),
        .a0_re(y0_re),
        .a1_re(y1_re),
        .a1_im(y1_im),
        .a2_re(y2_re),
        .a3_re(y3_re),
        .a3_im(y3_im)
    );

    wire signed [10:0] y4_re;
    wire signed [10:0] y5_re;
    wire signed [10:0] y5_im;
    wire signed [10:0] y6_re;
    wire signed [10:0] y7_re;
    wire signed [10:0] y7_im;
    four_point_fft fft1 (
        .clk(clk),
        .rst(rst),
        .x0_re({1'b0,x1_re}),
        .x1_re({1'b0,x5_re}),
        .x2_re({1'b0,x3_re}),
        .x3_re({1'b0,x7_re}),
        .a0_re(y4_re),
        .a1_re(y5_re),
        .a1_im(y5_im),
        .a2_re(y6_re),
        .a3_re(y7_re),
        .a3_im(y7_im)
    );

    wire signed [10:0] z5_re;
    wire signed [10:0] z5_im;
    /*verilator lint_off UNUSEDSIGNAL*/
    wire signed [11:0] z5_re_add;
    wire signed [11:0] z5_im_add;
    wire signed [15:0] z5_re_mul;
    wire signed [15:0] z5_im_mul;
    /*verilator lint_on UNUSEDSIGNAL*/
    assign z5_re_add = y5_re + y5_im;
    assign z5_im_add = y5_im - y5_re;
    assign z5_re_mul = {{8{z5_re_add[11]}}, z5_re_add[10:3]} * 16'd181;
    assign z5_im_mul = {{8{z5_im_add[11]}}, z5_im_add[10:3]} * 16'd181;
    assign z5_re = z5_re_mul[15:5];
    assign z5_im = z5_im_mul[15:5];

    wire signed [10:0] z7_re;
    wire signed [10:0] z7_im;
    /*verilator lint_off UNUSEDSIGNAL*/
    wire signed [11:0] z7_re_add;
    wire signed [11:0] z7_im_add;
    wire signed [15:0] z7_re_mul;
    wire signed [15:0] z7_im_mul;
    /*verilator lint_on UNUSEDSIGNAL*/
    assign z7_re_add = y7_im - y7_re;
    assign z7_im_add = -(y7_re + y7_im);
    assign z7_re_mul = {{8{z7_re_add[11]}}, z7_re_add[10:3]} * 16'd181;
    assign z7_im_mul = {{8{z7_im_add[11]}}, z7_im_add[10:3]} * 16'd181;
    assign z7_re = z7_re_mul[15:5];
    assign z7_im = z7_im_mul[15:5];

    always @(posedge clk) begin
        if (rst) begin
            a0_re <= 0;
            a1_re <= 0;
            a1_im <= 0;
            a2_re <= 0;
            a2_im <= 0;
            a3_re <= 0;
            a3_im <= 0;
            a4_re <= 0;
            a5_re <= 0;
            a5_im <= 0;
            a6_re <= 0;
            a6_im <= 0;
            a7_re <= 0;
            a7_im <= 0;
        end else begin
            a0_re <= y0_re + y4_re;
            a1_re <= y1_re + z5_re;
            a1_im <= y1_im + z5_im;
            a2_re <= {y2_re[10], y2_re};
            a2_im <= -{y6_re[10], y6_re};
            a3_re <= y3_re + z7_re;
            a3_im <= y3_im + z7_im;
            a4_re <= y0_re - y4_re;
            a5_re <= y1_re - z5_re;
            a5_im <= y1_im - z5_im;
            a6_re <= {y2_re[10], y2_re};
            a6_im <= {y6_re[10], y6_re};
            a7_re <= y3_re - z7_re;
            a7_im <= y3_im - z7_im;
        end
    end
endmodule
