`timescale  1ns/1ps
module  RAM_generate_10_tb ();

reg    sys_clk  ;
reg    sys_rst_n;
reg [7:0] data [0:3];

wire    [7:0]    data_0;
wire    [7:0]    data_1;
wire    [7:0]    data_2;
wire    [7:0]    data_3;

assign  data_0 = data[0];
assign  data_1 = data[1];
assign  data_2 = data[2];
assign  data_3 = data[3];

initial
    begin
        sys_clk <= 1'b0;
        sys_rst_n <= 1'b0;
        #32
        sys_rst_n <= 1'b1;
    end
    
    always #10 sys_clk <= ~sys_clk;
    
    genvar  j;
    generate    for(j=0;j<4;j=j+1) 
        begin:  TB
            always@(posedge sys_clk or negedge sys_rst_n)
                begin
                    if(~sys_rst_n)
                        data[j] <= 8'd0;
                    else
                        data[j] <= {$random} % 256;
                end   
        end
    endgenerate

RAM_generate_10 RAM_generate_10
    (
        .sys_clk    (sys_clk),
        .sys_rst_n  (sys_rst_n),
        .data_0     (data_0),
        .data_1     (data_1),
        .data_2     (data_2),
        .data_3     (data_3),
        
        .generate_10_0()  //转接输出，端口列表里面不支持数组  
    );

endmodule