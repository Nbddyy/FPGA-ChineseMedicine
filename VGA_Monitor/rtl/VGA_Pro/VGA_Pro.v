module VGA_Pro (
	input clk,
	input rst_n,
	input key_flag,
	output hsync,
	output vsync,
	output [15:0] rgb
);

	/*定义显示屏显示模块的五种状态*/
	parameter WHITE = 5'b00001;
	parameter BLACK = 5'b00010;
	parameter RED = 5'b00100;
	parameter GREEN = 5'b01000;
	parameter MONITOR = 5'b10000;

	wire [9:0] pix_x;
	wire [9:0] pix_y;
	reg [4:0] VGA_state;
	wire [15:0] pix_data;

	/*state transfer logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			VGA_state <= WHITE;
		end else begin
			case(VGA_state)
				WHITE : VGA_state <= (key_flag) ? BLACK : WHITE;
				BLACK : VGA_state <= (key_flag) ? RED : BLACK;
				RED : VGA_state <= (key_flag) ? GREEN : RED;
				GREEN : VGA_state <= (key_flag) ? MONITOR : GREEN;
				MONITOR : VGA_state <= (key_flag) ? WHITE : MONITOR;
				default : VGA_state <= WHITE;
			endcase
		end
	end

	VGA_Time inst_VGA_Time (
		.clk(clk),
		.rst_n(rst_n),
		.pix_data(pix_data),
		.pix_x(pix_x),
		.pix_y(pix_y),
		.hsync(hsync),
		.vsync(vsync),
		.rgb(rgb) 
	);

	VGA_Data inst_VGA_Data (
		.clk(clk),
		.rst_n(rst_n),
		.pix_x(pix_x),
		.pix_y(pix_y),
		.VGA_state(VGA_state),
		.pix_data(pix_data)
	);

endmodule