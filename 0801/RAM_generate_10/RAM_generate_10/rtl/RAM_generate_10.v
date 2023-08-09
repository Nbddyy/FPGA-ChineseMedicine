module  RAM_generate_10 
(
    input   wire             sys_clk,
    input   wire             sys_rst_n,
    input   wire    [7:0]    data_0,
    input   wire    [7:0]    data_1,
    input   wire    [7:0]    data_2,
    input   wire    [7:0]    data_3,
    
    
    output  wire[7:0]    generate_10_0  //转接输出，端口列表里面不支持数组

);

wire [7:0]  data [0:9];
reg [7:0]  rdaddress [0:9];
reg    rden[0:9];
reg [7:0]  wraddress [0:9];
reg    wren[0:9];
wire[7:0]   ram_out [0:9];


assign generate_10_0 = ram_out[0] ;

assign data[0] = data_0;
assign data[1] = data_1;
assign data[2] = data_2;
assign data[3] = data_3;



/////////////////使用数组来区分不同的RAM端口///////////////////////////
genvar  i;

generate  
for(i=0;i<=9;i=i+1)  
begin:ram

jiandan_ram	jiandan_ram_inst (      //8bit*256
	.clock ( sys_clk ),
	.data ( data[i] ),
	.rdaddress ( rdaddress[i] ),
	.rden ( rden[i] ),
	.wraddress ( wraddress[i] ),
	.wren ( wren[i] ),
	.q ( ram_out[i] )
	);
end
endgenerate

///////////////RAM[0]用于找最大值//////////////////////////////////////

reg [8:0] cnt_find_max;
always@(posedge sys_clk , negedge sys_rst_n)
begin
    if(~sys_rst_n)
        cnt_find_max <= 9'd0;
    else    if(cnt_find_max == 9'd511)
        cnt_find_max <= 9'd0;
    else
        cnt_find_max <= cnt_find_max + 1'b1;
end

always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(~sys_rst_n)
        begin
            wren[0] <= 1'b0;
            wraddress[0] <= 8'd0;
        end
    else    if(cnt_find_max <= 9'd255)
        begin
            wren[0] <= 1'b1;
            wraddress[0] <= cnt_find_max;
        end
    else
        begin
            wren[0] <= 1'b0;
            wraddress[0] <= 8'd0;
        end
end

always@(posedge sys_clk or negedge sys_rst_n)
begin
    if(~sys_rst_n)
        begin
            rden[0] <= 1'b0;
            rdaddress[0] <= 8'd0;
        end
    else    if(cnt_find_max >= 9'd256)
        begin
            rden[0] <= 1'b1;
            rdaddress[0] <= cnt_find_max - 9'd256;
        end
    else
        begin
            rden[0] <= 1'b0;
            rdaddress[0] <= 8'd0;
        end
end

reg [15:0]  max_valid;
    reg [9:0]   max_valid_address;
    reg [9:0]   rdaddress_latch;
    
    /////////////////保存上一个地址的值，因为有一个潜伏期/////////////////////////////////////////
    always@(posedge sys_clk or negedge sys_rst_n)
    begin
        if(~sys_rst_n)
            rdaddress_latch <= 10'd0;
        else
            rdaddress_latch <= rdaddress[0];
    end
    
    /////////////////找最大值以及最大值的地址//////////////////////////////////////
    always@(posedge sys_clk or negedge sys_rst_n)
    begin
        if(~sys_rst_n)
            begin
                max_valid <= 16'd0;
                max_valid_address <= 10'd0;
            end
        else    if(ram_out[0] >= max_valid)
            begin
                max_valid <= ram_out[0];
                max_valid_address <= rdaddress_latch;  //一个潜伏期
            end
        else
            begin
                max_valid <= max_valid;
                max_valid_address <= max_valid_address;
            end  
    end
    
    ///////////////RAM[1]用于倒着读//////////////////////////////////////

endmodule