module GNRMC_Decode (
	input clk,
	input rst_n,
	input op_flag,
	input [7:0] op_data,
	output reg [15:0] hours,
	output reg [15:0] minutes,
	output reg [15:0] seconds
);

	reg [15:0] hours_temp;
	reg [15:0] minutes_temp;
	reg [15:0] seconds_temp;

	//定义处理数据下的几种状态，本次状态过多，不再使用独热码
	parameter IDLE = 4'd0;
	parameter RMC = 4'd1;
	parameter UTC = 4'd2;
	parameter STA = 4'd3;
	parameter LAT = 4'd4;
	parameter ULAT = 4'd5;
	parameter LON = 4'd6;
	parameter ULON = 4'd7;
	parameter SPD = 4'd8;
	parameter COG = 4'd9;
	parameter DATE = 4'd10;
	parameter MV = 4'd11;
	parameter MVE = 4'd12;
	parameter MODE = 4'd13;
	parameter NAVS = 4'd14;
	parameter CS = 4'd15;

	reg [3:0] state;

	reg gnrmc;		//用于判断该消息是否属于GNRMC
	reg [1:0] gnrmc_cnt;	//用于配合检查消息类型

	reg [7:0] xor_detect;	//用来寄存逐位异或
	reg [1:0] xor_cnt;			//用来配合异或校验
	reg xor_correct;		//用来判断异或校验是否正确

	reg [1:0] hours_cnt;
	reg [1:0] minutes_cnt;
	reg [1:0] seconds_cnt;

	/*temp gnrmc*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			gnrmc <= 1'd0;
			gnrmc_cnt <= 2'd0;
		end else if(op_data == 8'h24 && op_flag) begin
			gnrmc <= 1'd0;
			gnrmc_cnt <= 2'd0;
		end else if(!gnrmc && op_data == 8'h47 && op_flag) begin
			gnrmc <= 1'd1;
			gnrmc_cnt <= 2'd0;
		end else if(gnrmc && op_data == 8'h4E && op_flag) begin
			gnrmc <= 1'd1;
			gnrmc_cnt <= 2'd1;
		end else if(gnrmc && gnrmc_cnt == 2'd1 && op_data == 8'h52 && op_flag) begin
			gnrmc <= 1'd1;
			gnrmc_cnt <= 2'd2;
		end else if(gnrmc && gnrmc_cnt == 2'd2 && op_data == 8'h4D && op_flag) begin
			gnrmc <= 1'd1;
			gnrmc_cnt <= 2'd3;
		end else if(gnrmc && gnrmc_cnt == 2'd3 && op_data == 8'h43 && op_flag) begin
			gnrmc <= 1'd1;
			gnrmc_cnt <= 2'd3;
		end  else begin
			gnrmc <= gnrmc;
			gnrmc_cnt <= gnrmc_cnt;
		end
	end

	/*state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE : state <= (gnrmc && gnrmc_cnt == 2'd3 && op_data == 8'h43 && op_flag) ? RMC : IDLE;
				RMC : state <= (op_flag && op_data == 8'h2C) ? UTC : RMC;
				UTC : state <= (op_flag && op_data == 8'h2C) ? STA : UTC;
				STA : state <= (op_flag && op_data == 8'h56) ? IDLE : (op_flag && op_data == 8'h2C) ? LAT : STA;
				LAT : state <= (op_flag && op_data == 8'h2C) ? ULAT : LAT;
				ULAT : state <= (op_flag && op_data == 8'h2C) ? LON : ULAT;
				LON : state <= (op_flag && op_data == 8'h2C) ? ULON : LON;
				ULON : state <= (op_flag && op_data == 8'h2C) ? SPD : ULON;
				SPD : state <= (op_flag && op_data == 8'h2C) ? COG : SPD;
				COG : state <= (op_flag && op_data == 8'h2C) ? DATE : COG;
				DATE : state <= (op_flag && op_data == 8'h2C) ? MV : DATE;
				MV : state <= (op_flag && op_data == 8'h2C) ? MVE : MV;
				MVE : state <= (op_flag && op_data == 8'h2C) ? MODE : MVE;
				MODE : state <= (op_flag && op_data == 8'h2A) ? NAVS : MODE;
				NAVS : state <= (op_flag) ? CS : NAVS;
				CS : state <= ((op_flag && op_data == 8'h24) || !xor_correct) ? IDLE : CS;
				default : state <= IDLE;
			endcase
		end
	end


	/*UTC提取时间*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			hours_temp <= 16'd0;
			minutes_temp <= 16'd0;
			seconds_temp <= 16'd0;
			hours_cnt <= 2'd0;
			minutes_cnt <= 2'd0;
			seconds_cnt <= 16'd0;
		end else begin
			case(state)
				IDLE : begin
					hours_cnt <= 2'd0;
					minutes_cnt <= 2'd0;
					seconds_cnt <= 16'd0;
				end

				UTC : begin
					if(hours_cnt != 2'd2 && op_flag) begin
						hours_temp <= {hours_temp[7:0],op_data};
						hours_cnt <= hours_cnt + 2'd1;
					end else if(minutes_cnt != 2'd2 && op_flag) begin
						minutes_temp <= {minutes_temp[7:0],op_data};
						minutes_cnt <= minutes_cnt + 2'd1;
					end else if(seconds_cnt != 2'd2 && op_flag) begin
						seconds_temp <= {seconds_temp[7:0],op_data};
						seconds_cnt <= seconds_cnt + 2'd1;
					end else begin
						hours_temp <= hours_temp;
						minutes_temp <= minutes_temp;
						seconds_temp <= seconds_temp;
					end
				end

				default : begin
					hours_temp <= hours_temp;
					minutes_temp <= minutes_temp;
					seconds_temp <= seconds_temp;
				end
			endcase
		end
	end

	/*逐位异或校验*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			xor_detect <= 8'd0;
		end else begin
			case(state) 
				IDLE : xor_detect <= 8'd0;
				RMC : xor_detect <= 8'h79;
				UTC : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				STA : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				LAT : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				ULAT : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				LON : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				ULON : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				SPD : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				COG : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				DATE : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				MV : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				MVE : xor_detect <= (op_flag) ? (xor_detect ^ op_data) : xor_detect;
				MODE : xor_detect <= (op_flag && op_data != 8'h2A) ? (xor_detect ^ op_data) : xor_detect;
				NAVS : xor_detect <= xor_detect;
				CS : xor_detect <= xor_detect;
				default : xor_detect <= xor_detect;
			endcase
		end
	end

	/*CS判断异或校验是否正确*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			xor_correct <= 1'd0;
			xor_cnt <= 2'd0;
		end else begin
			case(state) 
				IDLE : begin
					xor_correct <= 1'd0;
					xor_cnt <= 2'd0;
				end 
				NAVS : begin
					if(op_flag && op_data < 8'h41) begin
						xor_correct <= (op_data[3:0] == xor_detect[7:4]) ? 1'd1 : 1'd0;
						xor_cnt <= 2'd1;
					end else if(op_flag) begin
						case(op_data) 
							8'h41 : xor_correct <= (op_flag && xor_detect[7:4] == 4'b1010) ? 1'd1 : 1'd0;
							8'h42 : xor_correct <= (op_flag && xor_detect[7:4] == 4'b1011) ? 1'd1 : 1'd0;
							8'h43 : xor_correct <= (op_flag && xor_detect[7:4] == 4'b1100) ? 1'd1 : 1'd0;
							8'h44 : xor_correct <= (op_flag && xor_detect[7:4] == 4'b1101) ? 1'd1 : 1'd0;
							8'h45 : xor_correct <= (op_flag && xor_detect[7:4] == 4'b1110) ? 1'd1 : 1'd0;
							8'h46 : xor_correct <= (op_flag && xor_detect[7:4] == 4'b1111) ? 1'd1 : 1'd0;
							default : xor_correct <= 1'd0;
						endcase // op_data

						xor_cnt <= 2'd1;
					end else begin
						xor_correct <= xor_correct;
						xor_cnt <= xor_cnt;
					end
				end

				CS : begin
					if(op_flag && op_data < 8'h41 && xor_cnt == 2'd1) begin
						xor_correct <= (op_data[3:0] == xor_detect[3:0]) ? 1'd1 : 1'd0;
						xor_cnt <= xor_cnt + 2'd1;
					end else if(op_flag && xor_cnt == 2'd1) begin
						case(op_data) 
							8'h41 : xor_correct <= (op_flag && xor_detect[3:0] == 4'b1010) ? 1'd1 : 1'd0;
							8'h42 : xor_correct <= (op_flag && xor_detect[3:0] == 4'b1011) ? 1'd1 : 1'd0;
							8'h43 : xor_correct <= (op_flag && xor_detect[3:0] == 4'b1100) ? 1'd1 : 1'd0;
							8'h44 : xor_correct <= (op_flag && xor_detect[3:0] == 4'b1101) ? 1'd1 : 1'd0;
							8'h45 : xor_correct <= (op_flag && xor_detect[3:0] == 4'b1110) ? 1'd1 : 1'd0;
							8'h46 : xor_correct <= (op_flag && xor_detect[3:0] == 4'b1111) ? 1'd1 : 1'd0;
							default : xor_correct <= 1'd0;
						endcase // op_data

						xor_cnt <= xor_cnt + 2'd1;
					end else begin
						xor_cnt <= xor_cnt;
						xor_correct <= xor_correct;
					end
				end

			endcase
		end
	end


	/*output hours*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			hours <= 16'd0;
		end else begin
			case(state) 
				CS : hours <= (xor_cnt == 2'd2 && xor_correct) ? hours_temp : hours;
				default : hours <= hours;
			endcase
		end
	end

	/*output minutes*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			minutes <= 16'd0;
		end else begin
			case(state) 
				CS : minutes <= (xor_cnt == 2'd2 && xor_correct) ? minutes_temp : minutes;
				default : minutes <= minutes;
			endcase
		end
	end

	/*output seconds*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			seconds <= 16'd0;
		end else begin
			case(state) 
				CS : seconds <= (xor_cnt == 2'd2 && xor_correct) ? seconds_temp : seconds;
				default : seconds <= seconds;
			endcase
		end
	end

endmodule
