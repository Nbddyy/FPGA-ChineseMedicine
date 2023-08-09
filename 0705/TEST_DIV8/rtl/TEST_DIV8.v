module TEST_DIV8 (
	input wire CLK,
	input wire RST_N,
	output wire DIV8
);

	reg [2:0] temp;
	always @(posedge CLK or negedge RST_N) begin
		if(~RST_N) begin
			temp <= 3'd0;
		end else begin
			temp <= temp + 3'd1;
		end
	end

	//方法零
	assign DIV8 = (temp >= 3'd4 && temp <= 3'd7) ? 1'd1 : 1'd0;

	//方法一
	reg div8_1;
	always @(posedge CLK or negedge RST_N) begin
		if(~RST_N) begin
			div8_1 <= 1'd0;
		end else if(temp >= 3'd3 && temp <= 3'd6) begin
			div8_1 <= 1'd1;
		end else begin
			div8_1 <= 1'd0;
		end
	end

	//方法二
	reg div8_2;
	always @(posedge CLK or negedge RST_N) begin
		if(~RST_N) begin
			div8_2 <= 1'd0;
		end else begin
			case(temp)
				3'd3,3'd4,3'd5,3'd6: div8_2 <= 1'd1;
				default: div8_2 <= 1'd0;
			endcase
		end
	end

	//方法三
	reg div8_3;
	always @(posedge CLK or negedge RST_N) begin
		if(~RST_N) begin
			div8_3 <= 1'd0;
		end else begin
			div8_3 <= (temp >= 3'd3 && temp <= 3'd6) ? 1'd1 : 1'd0;
		end
	end

	// //方法四
	reg div8_4;
	always@(*) begin
		if(temp >= 3'd4 && temp <= 3'd7) begin
			div8_4 <= 1'd1;
		end else begin
			div8_4 <= 1'd0;
		end
	end


	// //方法五
	reg div8_5;
	always@(*) begin
		case(temp >= 3'd4 && temp <= 3'd7)
			1'd0: div8_5 = 1'd0;
			default: div8_5 = 1'd1;
		endcase
	end

	//方法六
	reg div8_6;
	always@(*) begin
		div8_6 <= (temp >= 4 && temp <= 7) ? 1'd1 : 1'd0;
	end


endmodule