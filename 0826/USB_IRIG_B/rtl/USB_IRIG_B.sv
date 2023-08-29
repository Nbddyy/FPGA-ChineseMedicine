// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy	qq1877117587@outlook.com
// File   : USB_IRIG_B.v
// Create : 2023-08-28 11:50:34
// Revise : 2023-08-28 11:50:34
// Editor : sublime text4, tab size (4)
// Descri : UART_Tx模块我们使用8位传输，在顶层模块实现1s控制
// -----------------------------------------------------------------------------
module USB_IRIG_B (
	input clk,
	input rst_n,
	input rx,
	output tx
);

	wire [7:0] op_data;
	wire op_flag;

	wire [7:0] ex_sig_B_code;

	wire [7:0] output_array [24:0];

	reg [7:0] output_array_latch [24:0];	//用于锁存输出的时间数据

	wire output_flag;

	reg [7:0] ip_data;
	reg ip_flag;

	reg cnt_en;
	reg [15:0] cnt_60000;	//计数至60000，将输出依次发送给UART_Tx模块进行处理，60000是给Tx模块处理该数据的时间
	reg [7:0] cnt;				//用来标识2该传输哪一位置，当传输25个数据完毕后，模块计数停止

	integer i;

	/*将输出补全并进行寄存*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			for(i = 0; i < 25; i = i + 1) begin
				output_array_latch[i] <= output_array[i];
			end
		end else if(output_flag) begin
			output_array_latch[0] <= 8'h54;
			output_array_latch[1] <= 8'h49;
			output_array_latch[2] <= 8'h4D;
			output_array_latch[3] <= 8'h45;
			output_array_latch[4] <= 8'h3A;
			output_array_latch[9] <= 8'h2D;
			output_array_latch[13] <= 8'h64;
			output_array_latch[14] <= 8'h61;
			output_array_latch[15] <= 8'h79;
			output_array_latch[16] <= 8'h2D;
			output_array_latch[19] <= 8'h3A;
			output_array_latch[22] <= 8'h3A;

			output_array_latch[5] <= 8'h32;
			output_array_latch[6] <= 8'h30;
			output_array_latch[7] <= output_array[7];
			output_array_latch[8] <= output_array[8];
			output_array_latch[10] <= output_array[10];
			output_array_latch[11] <= output_array[11];
			output_array_latch[12] <= output_array[12];
			output_array_latch[17] <= output_array[17];
			output_array_latch[18] <= output_array[18];
			output_array_latch[20] <= output_array[20];
			output_array_latch[21] <= output_array[21];
			output_array_latch[23] <= output_array[23];
			output_array_latch[24] <= output_array[24];
		end else begin
			for(i = 0; i < 25; i = i + 1) begin
				output_array_latch[i] <= output_array_latch[i];
			end
		end
	end

	/***********************************************************/
	/*cnt_en*/	
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_en <= 1'd0;
		end else if(cnt == 8'd27) begin
			cnt_en <= 1'd0;
		end else if(output_flag) begin
			cnt_en <= 1'd1;
		end else begin
			cnt_en <= cnt_en;
		end
	end

	/*cnt_60000*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_60000 <= 16'd0;
		end else if(!cnt_en || cnt_60000 == 16'd59_999) begin
			cnt_60000 <= 16'd0;
		end else begin
			cnt_60000 <= cnt_60000 + 16'd1;
		end
	end

	/*将数据间隔60000分成25批次八位依次发送给UART_Tx*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else if(!cnt_en) begin
			cnt <= 8'd0;
		end else if(cnt_60000 == 16'd59_999) begin
			cnt <= cnt + 8'd1;
		end else begin
			cnt <= cnt;
		end
	end

	/***********************************************************/
	/*temp ip_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_data <= 8'd0;
		end else if(cnt_60000 == 16'd59_999 && cnt <= 24) begin
			if(cnt == 8'd7 || cnt == 8'd8 || cnt == 8'd10 || cnt == 8'd11 || cnt == 8'd12 || cnt == 8'd17 || cnt == 8'd18 || cnt == 8'd20 || cnt == 8'd21 || cnt == 8'd23 || cnt == 8'd24) begin
				case(output_array_latch[cnt]) 
					8'd2 : ip_data <= 8'h32;
					8'd0 : ip_data <= 8'h30;
					8'd1 : ip_data <= 8'h31;
					8'd5 : ip_data <= 8'h35;
					8'd4 : ip_data <= 8'h34;
					8'd8 : ip_data <= 8'h38;
					default : ip_data <= 8'd0;
				endcase
			end else begin
				ip_data <= output_array_latch[cnt];
			end
			
		end else begin
			ip_data <= ip_data;
		end
	end

	/*temp ip_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_flag <= 1'd0;
		end else if(cnt_60000 == 16'd59_999 && cnt <= 24) begin
			ip_flag <=1'd1;
		end else begin
			ip_flag <= 1'd0;
		end
	end

	/***********************************************************/

	UART_Rx inst_UART_Rx (
		.clk(clk),
		.rst_n(rst_n),
		.rx(rx),
		.op_data(op_data),
		.op_flag(op_flag)
	);

	Buffer_Module 
	#(
		.cnt_10ms_max(24'd499_999)
	)
	inst_Buffer_Module
	(
		.clk(clk),
		.rst_n(rst_n),
		.op_data(op_data),
		.op_flag(op_flag),
		.ex_sig_B_code(ex_sig_B_code)
	);

	IRIG_B_Pro inst_IRIG_B_Pro (
		.clk(clk),
		.rst_n(rst_n),
		.ex_sig_B_code(ex_sig_B_code),
		.output_array(output_array),
		.output_flag(output_flag)
	);

	UART_Tx inst_UART_Tx (
		.clk(clk),
		.rst_n(rst_n),
		.ip_data(ip_data),
		.ip_flag(ip_flag),
		.tx(tx) 
	);


endmodule