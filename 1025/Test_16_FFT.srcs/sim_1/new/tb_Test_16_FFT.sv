
`timescale 1ns/1ps
module tb_Test_16_FFT (); /* this is automatically generated */


	reg board_clk_100mhz;
	reg board_rst_n;

	reg signed [15:0] datain_real;
	reg signed [15:0] datain_imaginary;
	wire datain_valid;

	reg [7:0] work_cnt = 8'd0;

	initial begin
		board_clk_100mhz <= 1'd0;
		board_rst_n <= 1'd0;
		#13
		board_rst_n = 1'd1;
	end

	always #5 board_clk_100mhz <= !board_clk_100mhz;

	always@(posedge board_clk_100mhz or negedge board_rst_n) begin
		if(~board_rst_n) begin
			work_cnt <= 8'd0;
		end else if(work_cnt == 8'd255) begin
			work_cnt <= work_cnt;
		end begin
			work_cnt <= work_cnt + 8'd1;
		end
	end

	always@(posedge board_clk_100mhz or negedge board_rst_n) begin
		if(~board_rst_n) begin
			datain_real <= 16'd0;
			datain_imaginary <= 16'd0;
		end else begin
			case(work_cnt) 
				8'd11 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd12 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd13 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd14 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0; 
				end

				/////////////////////////
				8'd15 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd16 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd17 : begin
					datain_real <= 16'd0;
					datain_imaginary <= 16'd0;
				end
				8'd18 : begin
					datain_real <= 16'd0;
					datain_imaginary <= 16'd0;
				end

///////////////////////////////////////////////////

				8'd19 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd20 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd21 : begin
					datain_real <= 16'd0;
					datain_imaginary <= 16'd0;
				end
				8'd22 : begin
					datain_real <= 16'd0;
					datain_imaginary <= 16'd0; 
				end

				//////////////////////
				8'd23 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd24 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd25 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end
				8'd26 : begin
					datain_real <= 16'd1;
					datain_imaginary <= 16'd0;
				end

				default : begin
					datain_real <= 16'd0;
					datain_imaginary <= 16'd0;
				end

			endcase
		end
	end

	assign datain_valid = (work_cnt >= 8'd12 && work_cnt <= 8'd27) ? 1'd1 : 1'd0;

	// (*NOTE*) replace reset, clock, others
	Test_16_FFT inst_Test_16_FFT (.clk(board_clk_100mhz), .rst_n(board_rst_n),
		.datain_real(datain_real),
		.datain_imaginary(datain_imaginary),
		.datain_valid(datain_valid));



endmodule
