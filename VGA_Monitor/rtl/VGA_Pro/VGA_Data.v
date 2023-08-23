module VGA_Data (
	input clk,
	input rst_n,
	input [9:0] pix_x,
	input [9:0] pix_y,
	input [4:0] VGA_state,
	output reg [15:0] pix_data
);

	parameter WHITE = 5'b00001;
	parameter BLACK = 5'b00010;
	parameter RED = 5'b00100;
	parameter GREEN = 5'b01000;
	parameter MONITOR = 5'b10000;

    /*根据VGA_state判断该模块输出哪个pix_data
    由于在VGA_Time模块仅仅处理了clap一次的情况，所以这里使用组合逻辑输出*/
    always@(*) begin
    	if(!rst_n) begin
    		pix_data = pix_data_white;
    	end else begin
    		case(VGA_state)
    			WHITE : pix_data = pix_data_white;
    			BLACK : pix_data = pix_data_black;
    			RED : pix_data = pix_data_red;
    			GREEN : pix_data = pix_data_green;
    			MONITOR : pix_data = pix_data_monitor;
    			default : pix_data = pix_data_white;
    		endcase
    	end
    end

	wire [15:0] pix_data_white;
	wire [15:0] pix_data_black;
	wire [15:0] pix_data_red;
	wire [15:0] pix_data_green;
	wire [15:0] pix_data_monitor;

	VGA_White_Data inst_VGA_White_Data (
		.clk(clk),
		.rst_n(rst_n),
		.pix_x(pix_x),
		.pix_y(pix_y),
		.pix_data(pix_data_white)
	);

	VGA_Black_Data inst_VGA_Black_Data (
		.clk(clk),
		.rst_n(rst_n),
		.pix_x(pix_x),
		.pix_y(pix_y),
		.pix_data(pix_data_black)
	);

	VGA_Red_Data inst_VGA_Red_Data (
		.clk(clk),
		.rst_n(rst_n),
		.pix_x(pix_x),
		.pix_y(pix_y),
		.pix_data(pix_data_red)
	);

	VGA_Green_Data inst_VGA_Green_Data (
		.clk(clk),
		.rst_n(rst_n),
		.pix_x(pix_x),
		.pix_y(pix_y),
		.pix_data(pix_data_green)
	);

	VGA_Monitor_Data inst_VGA_Monitor_Data (
		.clk(clk),
		.rst_n(rst_n),
		.pix_x(pix_x),
		.pix_y(pix_y),
		.pix_data(pix_data_monitor)
	);

endmodule