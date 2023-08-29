module USB_Transmission_8_Bytes 
#(
	parameter cnt_1s_mmax = 32'd49_999_999
)
(
	input clk,
	input rst_n,
	output tx
);

	reg [63:0] ip_data;
	reg ip_flag;

	parameter Bytes = 64'h152360_abddcc_abfe;	//需要间隔1s发送的8字节数据

	reg [31:0] cnt_1s;	//用于数据包发包间隔计数

	/*cnt_1s计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1s <= 32'd0;
		end else if(cnt_1s == cnt_1s_mmax) begin
			cnt_1s <= 32'd0;
		end else begin
			cnt_1s <= cnt_1s + 32'd1;
		end
	end

	/*间隔1s向接收发送模块传递数据并拉高ip_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_data <= Bytes;
			ip_flag <= 1'd1;
		end else if(cnt_1s == cnt_1s_mmax) begin
			ip_data <= Bytes;
			ip_flag <= 1'd1;
		end else begin
			ip_data <= ip_data;
			ip_flag <= 1'd0;
		end
	end

	/*将64位有效位与起始位0和停止位1进行包装作为数据帧整体发送给串口助手*/
	UART_Tx inst_UART_Tx (
		.clk(clk),
		.rst_n(rst_n),
		.ip_data(ip_data),
		.ip_flag(ip_flag),
		.tx(tx)
	);

endmodule