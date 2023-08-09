module TEST8 (
	input clk,
	input rst_n,
	output reg bright
);

	//点亮LED灯观察何时最亮
	// assign bright = 1'd0;

	//观察50%占比周期50ms的灯的亮度
	reg [23:0] temp;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			temp <= 24'd0; 
		end else if(temp == 24'd2_499_999) begin
			temp <= 24'd0;
		end else begin
			temp <= temp + 24'd1;
		end
	end

	// always @(posedge clk or negedge rst_n) begin
	// 	if(~rst_n) begin
	// 		bright <= 1'd0;
	// 	end else if(temp >= 24'd1_249_999 && temp <= 24'd2_499_998) begin
	// 		bright <= 1'd1;
	// 	end else begin
	// 		bright <= 1'd0;
	// 	end
	// end

	// 高电平10ms，低电平40ms
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bright <= 1'd0;
		end else if(temp <= 24'd2_499_998 && temp >= 24'd499_999) begin
			bright <= 1'd0;
		end else begin
			bright <= 1'd1;
		end
	end

endmodule