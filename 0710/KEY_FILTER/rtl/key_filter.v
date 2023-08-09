module key_filter
	#(
		parameter CNT_MAX = 24'd999_999
	)
	(
		input wire sys_clk , 
		input wire sys_rst_n ,
		input wire key_in , 

		output reg key_flag 
	);


	reg [23:0] cnt_20ms ; 

	always@(posedge sys_clk or negedge sys_rst_n)
		if(!sys_rst_n)
			cnt_20ms <= 24'd0;
		else if(key_in == 1'd1)
			cnt_20ms <= 24'd0;
		else if(cnt_20ms == CNT_MAX && key_in == 1'd0)
			cnt_20ms <= cnt_20ms;
		else
			cnt_20ms <= cnt_20ms + 1'd1;


	always@(posedge sys_clk or negedge sys_rst_n)
		if(!sys_rst_n)
			key_flag <= 1'd0;
		else if(cnt_20ms == CNT_MAX - 24'd1)
			key_flag <= 1'd1;
		else
			key_flag <= 1'd0;

endmodule