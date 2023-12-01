module tt_um_zhuoxuan001_fft_man_top (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    /* verilator lint_off UNUSEDSIGNAL */
    input  wire [7:0] uio_in,   // IOs: Input path
    /* verilator lint_on UNUSEDSIGNAL */
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
); 

    reg [7:0] counter = 8'b0;
    reg new_clk = 1'b0;
    reg [7:0] uio_out_reg = 8'b0;
    reg [7:0] x0_re = 8'b0;
    reg [7:0] x1_re = 8'b0;
    reg [7:0] x2_re = 8'b0;
    reg [7:0] x3_re = 8'b0;
    reg [7:0] x4_re = 8'b0;
    reg [7:0] x5_re = 8'b0;
    reg [7:0] x6_re = 8'b0;
    reg [7:0] x7_re = 8'b0;
    /* verilator lint_off UNUSEDSIGNAL */
    wire signed [11:0] a0_re;
    wire signed [11:0] a0_im;
    wire signed [11:0] a1_re;
    wire signed [11:0] a1_im;
    wire signed [11:0] a2_re;
    wire signed [11:0] a2_im;
    wire signed [11:0] a3_re;
    wire signed [11:0] a3_im;
    wire signed [11:0] a4_re;
    wire signed [11:0] a4_im;
    wire signed [11:0] a5_re;
    wire signed [11:0] a5_im;
    wire signed [11:0] a6_re;
    wire signed [11:0] a6_im;
    wire signed [11:0] a7_re;
    wire signed [11:0] a7_im;
    wire [11:0] a0_re_abs;
    wire [11:0] a0_im_abs;
    wire [11:0] a1_re_abs;
    wire [11:0] a1_im_abs;
    wire [11:0] a2_re_abs;
    wire [11:0] a2_im_abs;
    wire [11:0] a3_re_abs;
    wire [11:0] a3_im_abs;
    wire [11:0] a4_re_abs;
    wire [11:0] a4_im_abs;
    wire [11:0] a5_re_abs;
    wire [11:0] a5_im_abs;
    wire [11:0] a6_re_abs;
    wire [11:0] a6_im_abs;
    wire [11:0] a7_re_abs;
    wire [11:0] a7_im_abs;
    wire [11:0] a0;
    wire [11:0] a1;
    wire [11:0] a2;
    wire [11:0] a3;
    wire [11:0] a4;
    wire [11:0] a5;
    wire [11:0] a6;
    wire [11:0] a7;
    /* verilator lint_on UNUSEDSIGNAL */

    always @(posedge clk) begin
    	if (~rst_n) begin
    	    uio_out_reg <= 8'b0;
    	    counter <= 8'b0;
    	end
        if (ena) begin
            if (counter == 8'b00000000) begin
                x0_re <= ui_in;
            end
            if (counter == 8'b00000100) begin
                x1_re <= ui_in;
            end
            if (counter == 8'b00001000) begin
                x2_re <= ui_in;
            end
            if (counter == 8'b00001100) begin
                x3_re <= ui_in;
            end
            if (counter == 8'b00010000) begin
                x4_re <= ui_in;
            end
            if (counter == 8'b00010100) begin
                x5_re <= ui_in;
            end
            if (counter == 8'b00011000) begin
                x6_re <= ui_in;
            end
            if (counter == 8'b00011100) begin
                x7_re <= ui_in;
            end
            if (counter == 8'b01100100) begin
                uio_out_reg <= 8'b00000001;
            end
            if (counter == 8'b01101000) begin
                uio_out_reg <= 8'b00000010;
            end
            if (counter == 8'b01101100) begin
                uio_out_reg <= 8'b00000100;
            end
            if (counter == 8'b01110000) begin
                uio_out_reg <= 8'b00001000;
            end
            if (counter == 8'b01110100) begin
                uio_out_reg <= 8'b00010000;
            end
            if (counter == 8'b01111000) begin
                uio_out_reg <= 8'b00100000;
            end
            if (counter == 8'b01111100) begin
                uio_out_reg <= 8'b01000000;
            end
            if (counter == 8'b10000000) begin
                uio_out_reg <= 8'b10000000;
            end
            if (counter == 8'b10000100) begin
                uio_out_reg <= 8'b0;
            end
            if (counter[3:0] == 4'b0000) begin
                new_clk <= ~new_clk;
            end
            counter <= counter + 8'b00000001;
        end
    end
    
    fft inst1 (
    	.clk(new_clk),
    	.rst(~rst_n),
    	.x0_re(x0_re),
    	.x1_re(x1_re),
    	.x2_re(x2_re),
    	.x3_re(x3_re),
    	.x4_re(x4_re),
    	.x5_re(x5_re),
    	.x6_re(x6_re),
    	.x7_re(x7_re),
    	.a0_re(a0_re),
    	.a0_im(a0_im),
    	.a1_re(a1_re),
    	.a1_im(a1_im),
    	.a2_re(a2_re),
    	.a2_im(a2_im),
    	.a3_re(a3_re),
    	.a3_im(a3_im),
    	.a4_re(a4_re),
    	.a4_im(a4_im),
    	.a5_re(a5_re),
    	.a5_im(a5_im),
    	.a6_re(a6_re),
    	.a6_im(a6_im),
    	.a7_re(a7_re),
    	.a7_im(a7_im)
    );
    
    assign a0_re_abs = (a0_re[11] == 1'b0) ? a0_re : -a0_re;
    assign a0_im_abs = (a0_im[11] == 1'b0) ? a0_im : -a0_im;
    assign a1_re_abs = (a1_re[11] == 1'b0) ? a1_re : -a1_re;
    assign a1_im_abs = (a1_im[11] == 1'b0) ? a1_im : -a1_im;
    assign a2_re_abs = (a2_re[11] == 1'b0) ? a2_re : -a2_re;
    assign a2_im_abs = (a2_im[11] == 1'b0) ? a2_im : -a2_im;
    assign a3_re_abs = (a3_re[11] == 1'b0) ? a3_re : -a3_re;
    assign a3_im_abs = (a3_im[11] == 1'b0) ? a3_im : -a3_im;
    assign a4_re_abs = (a4_re[11] == 1'b0) ? a4_re : -a4_re;
    assign a4_im_abs = (a4_im[11] == 1'b0) ? a4_im : -a4_im;
    assign a5_re_abs = (a5_re[11] == 1'b0) ? a5_re : -a5_re;
    assign a5_im_abs = (a5_im[11] == 1'b0) ? a5_im : -a5_im;
    assign a6_re_abs = (a6_re[11] == 1'b0) ? a6_re : -a6_re;
    assign a6_im_abs = (a6_im[11] == 1'b0) ? a6_im : -a6_im;
    assign a7_re_abs = (a7_re[11] == 1'b0) ? a7_re : -a7_re;
    assign a7_im_abs = (a7_im[11] == 1'b0) ? a7_im : -a7_im;
    assign a0 = a0_re_abs[10:5] * a0_re_abs[10:5] + a0_im_abs[10:5] * a0_im_abs[10:5];
    assign a1 = a1_re_abs[10:5] * a1_re_abs[10:5] + a1_im_abs[10:5] * a1_im_abs[10:5];
    assign a2 = a2_re_abs[10:5] * a2_re_abs[10:5] + a2_im_abs[10:5] * a2_im_abs[10:5];
    assign a3 = a3_re_abs[10:5] * a3_re_abs[10:5] + a3_im_abs[10:5] * a3_im_abs[10:5];
    assign a4 = a4_re_abs[10:5] * a4_re_abs[10:5] + a4_im_abs[10:5] * a4_im_abs[10:5];
    assign a5 = a5_re_abs[10:5] * a5_re_abs[10:5] + a5_im_abs[10:5] * a5_im_abs[10:5];
    assign a6 = a6_re_abs[10:5] * a6_re_abs[10:5] + a6_im_abs[10:5] * a6_im_abs[10:5];
    assign a7 = a7_re_abs[10:5] * a7_re_abs[10:5] + a7_im_abs[10:5] * a7_im_abs[10:5];
    assign uio_oe = {8{1'b1}};
    assign uio_out = uio_out_reg;
    assign uo_out = (uio_out_reg == 8'b00000001) ? a0[11:4] : 
                        (uio_out_reg == 8'b00000010) ? a1[11:4] : 
                        (uio_out_reg == 8'b00000100) ? a2[11:4] : 
                        (uio_out_reg == 8'b00001000) ? a3[11:4] : 
                        (uio_out_reg == 8'b00010000) ? a4[11:4] : 
                        (uio_out_reg == 8'b00100000) ? a5[11:4] : 
                        (uio_out_reg == 8'b01000000) ? a6[11:4] : 
                        (uio_out_reg == 8'b10000000) ? a7[11:4] : 
                        8'b0;
endmodule

