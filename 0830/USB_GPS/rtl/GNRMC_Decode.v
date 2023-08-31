module GNRMC_Decode (
	input clk,
	input rst_n,
	input [7:0] op_data,
	input op_flag,
	output reg [15:0] hours,
	output reg [15:0] minutes,
	output reg [15:0] seconds
);

	reg [7:0] op_data_latch;	//用于寄存上一个op_data值

	reg [7:0] cnt;	//用于当前解码的位置

	reg gnrmc;		//筛选出需要解码的RMC

	reg location;	//筛选出位置是否有效

	reg [7:0] xor_detect;	//异或验证

	reg [15:0] hours_temp;	//获取GNRMC中的小时
	reg [15:0] minutes_temp;	//获取minutes
	reg [15:0] seconds_temp;	//获取seconds

	reg xor_correct;	//用于检测异或是否正确

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			op_data_latch <= 8'd0;
		end else if(!cnt && op_flag) begin
			op_data_latch <= op_data;
		end else begin
			op_data_latch <= op_data_latch;
		end
	end

	/*cnt计数用于提取关键信息*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else if(cnt == 8'd71 || (cnt == 8'd5 && !gnrmc) || (op_data == 8'h24 && op_flag)) begin
			cnt <= 8'd0;
		end else if(op_data_latch == 8'h24 && op_data == 8'h47 && op_flag) begin
			cnt <= 8'd1;
		end else if(!gnrmc) begin
			cnt <= 8'd0;	//通过降低优先级解决
		end else if(op_data_latch == 8'h47 && op_flag && gnrmc) begin
			cnt <= cnt + 8'd1;
		end else begin
			cnt <= cnt;
		end
	end

	/*筛选出GNRMC*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			gnrmc <= 1'd0;
		end else if(op_data == 8'h24 && op_flag) begin
			gnrmc <= 1'd0;
		end else if(op_data_latch == 8'h24 && op_data == 8'h47 && op_flag) begin
			gnrmc <= 1'd1;
		end else if(cnt == 8'd1 && op_flag && op_data != 8'h4E && gnrmc) begin
			gnrmc <= 1'd0;
		end else if(cnt == 8'd2 && op_flag && op_data != 8'h52 && gnrmc) begin
			gnrmc <= 1'd0;
		end else if(cnt == 8'd3 && op_flag && op_data != 8'h4D && gnrmc) begin
			gnrmc <= 1'd0;
		end else if(cnt == 8'd4 && op_flag && op_data != 8'h43 && gnrmc) begin
			gnrmc <= 1'd0;
		end else if(cnt == 8'd18 && op_flag && !location) begin
			gnrmc <= 1'd0;
		end else begin
			gnrmc <= gnrmc;
		end
	end

	/*筛选出位置有效GNRMC*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			location <= 1'd0;
		end else if((op_data == 8'h24 && op_flag) || !gnrmc) begin
			location <= 1'd0;
		end else if(cnt == 8'd18 && op_data == 8'h41) begin
			location <= 1'd1;
		end else begin
			location <= location;
		end
	end


	/*temp xor用于校验异或*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			xor_detect <= 8'd0;
		end else if(op_data == 8'h24 && op_flag) begin
			xor_detect <= 8'd0;
		end else if(op_data_latch == 8'h24 && op_flag && op_data == 8'h47) begin 	//由于cnt == 1时唯一时刻gnrmc尚未确定，所以需要单独判断
			xor_detect <= xor_detect ^ op_data;
		end else if(gnrmc && op_flag && cnt <= 8'd65) begin
			xor_detect <= xor_detect ^ op_data;
		end else begin
			xor_detect <= xor_detect;
		end
	end

	/*temp hours_temp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			hours_temp <= 16'd0;
		end else if(!gnrmc) begin
			hours_temp <= 16'd0;
		end else if((cnt == 8'd6 || cnt == 8'd7) && op_flag) begin
			hours_temp <= {hours_temp[7:0],op_data};
		end else begin
			hours_temp <= hours_temp;
		end
	end

	/*temp minutes_temp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			minutes_temp <= 16'd0;
		end else if(!gnrmc) begin
			minutes_temp <= 16'd0;
		end else if((cnt == 8'd8 || cnt == 8'd9) && op_flag) begin
			minutes_temp <= {minutes_temp[7:0],op_data};
		end else begin
			minutes_temp <= minutes_temp;
		end
	end

	/*temp seconds_temp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			seconds_temp <= 16'd0;
		end else if(!gnrmc) begin
			seconds_temp <= 16'd0;
		end else if((cnt == 8'd10 || cnt == 8'd11) && op_flag) begin
			seconds_temp <= {seconds_temp[7:0],op_data};
		end else begin
			seconds_temp <= seconds_temp;
		end
	end

	/*temp xor_correct
	如果校验ASCII为字母，需进行进制转换*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			xor_correct <= 1'd0;
		end else if(!gnrmc) begin
			xor_correct <= 1'd0;
		end else if(cnt == 8'd67 && op_flag) begin
			xor_correct <= (xor_detect[7:4] == op_data[3:0]) ? 1'd1 : 1'd0;
		end else if(cnt == 8'd68 && op_flag && xor_correct) begin
			if(op_data < 8'h41) begin
				xor_correct <= (xor_detect[3:0] == op_data[3:0]) ? 1'd1 : 1'd0;
			end else begin
				case(op_data) 
					8'h41 : xor_correct <= (xor_detect[3:0] == 4'b1010) ? 1'd1 : 1'd0;
					8'h42 : xor_correct <= (xor_detect[3:0] == 4'b1011) ? 1'd1 : 1'd0;
					8'h43 : xor_correct <= (xor_detect[3:0] == 4'b1100) ? 1'd1 : 1'd0;
					8'h44 : xor_correct <= (xor_detect[3:0] == 4'b1101) ? 1'd1 : 1'd0;
					8'h45 : xor_correct <= (xor_detect[3:0] == 4'b1110) ? 1'd1 : 1'd0;
					8'h46 : xor_correct <= (xor_detect[3:0] == 4'b1111) ? 1'd1 : 1'd0;
					default : xor_correct <= 1'd0;
				endcase // op_data
			end
			
		end else begin
			xor_correct <= xor_correct;
		end
	end

	// /*xor_correct*/
	// always @(posedge clk or negedge rst_n) begin
	// 	if(~rst_n) begin
	// 		xor_correct <= 1'd1;
	// 	end else begin
	// 		xor_correct <= 1'd1;
	// 	end
	// end

	/*output hours_temp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			hours <= 16'd0;
		end else if(cnt == 8'd69 && xor_correct && gnrmc && location) begin
			hours <= hours_temp;
		end else begin
			hours <= hours;
		end
	end

	/*output minutes_temp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			minutes <= 16'd0;
		end else if(cnt == 8'd69 && xor_correct && gnrmc && location) begin
			minutes <= minutes_temp;
		end else begin
			minutes <= minutes;
		end
	end

	/*output seconds_temp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			seconds <= 16'd0;
		end else if(cnt == 8'd69 && xor_correct && gnrmc && location) begin
			seconds <= seconds_temp;
		end else begin
			seconds <= seconds;
		end
	end

endmodule