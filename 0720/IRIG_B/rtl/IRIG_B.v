module IRIG_B (
    input wire clk,
    input wire rst_n,
    input wire sign,
    output wire [3:0] seconds_g,
    output wire [2:0] seconds_s,
    output wire [3:0] minute_g ,
    output wire [2:0] minute_s ,
    output wire [3:0] hour_g   ,
    output wire [1:0] hour_s   ,
    output wire [3:0] day_g    ,
    output wire [3:0] day_s    ,
    output wire [1:0] day_b    ,
    output wire [3:0] year_g   ,
    output wire [3:0] year_s    
);
reg [31:0] cnt_10ms;
reg [31:0] cnt_flag;
reg [7:0]  cnt_100;
reg [99:0] data;
reg [31:0] state_flag;
parameter state_0 = 250_000;
parameter state_1 = 625_000;
parameter state_P = 1000_000;
assign seconds_g = {data[4:1]} + 4'b0001;  ////
assign seconds_s = {data[8:6]};
assign minute_g  = {data[13:10]};
assign minute_s  = {data[17:15]};
assign hour_g    = {data[23:20]};
assign hour_s    = {data[26:25]};
assign day_g     = {data[33:30]};
assign day_s     = {data[38:35]};
assign day_b     = {data[41:40]};
assign year_g    = {data[53:50]};
assign year_s    = {data[58:55]};

/*cnt_100ms计数存在漏洞，计数从0开始的时间应该是信号上升沿的时候，
之所以仿真中也能重合，应该是tb中在复位拉高的时候给了信号输出*/

/*双P计数开始判断*/

always@(posedge clk or negedge rst_n)  ///////定义10ms计数器
begin
     if(!rst_n)
        begin
              cnt_10ms <= 32'd0;
        end
      else if(cnt_10ms == 32'd124_9999)
         begin
              cnt_10ms <= 32'd0;              
         end
      else
         begin
              cnt_10ms <= cnt_10ms + 1'd1;
end
end

always@(posedge clk or negedge rst_n)   //////区分P，0,1三种波形，利用计数器在高电平时间的计数
begin
     if(!rst_n)
        begin
              cnt_flag <= 32'd0;
        end
      else if(cnt_10ms == 32'd124_9999)
         begin
              cnt_flag <= 32'd0;              
         end
      else if(sign == 1'd1)
         begin
              cnt_flag <= cnt_flag + 1'd1;
         end
      else
         begin
              cnt_flag <= cnt_flag;
         end
end

always@(posedge clk or negedge rst_n)      //////////让它在sign为低电平时将cnt_flag的值赋值给state_flag，用来区分P，0,1三种状态
begin
     if(!rst_n)
        begin
              state_flag <= 32'd0;
        end
      else if(cnt_10ms == 32'd124_9999)
         begin
              state_flag <= 32'd0;              
         end
      else if(sign == 1'd0)
         begin
              state_flag <= cnt_flag;
         end
      else
         begin
              state_flag <= state_flag;
         end
end

always@(posedge clk or negedge rst_n)      ////////记录100个码源，同时为后面数组提供存储地址
begin
     if(!rst_n)
        begin
              cnt_100 <= 8'd0;
        end
      else if(cnt_100 == 8'd99)
         begin
              cnt_100 <= 8'd0;              
         end
      else if(cnt_10ms == 32'd124_9999)
         begin
              cnt_100 <= cnt_100 + 1'd1;
         end
      else
         begin
              cnt_100 <= cnt_100;
         end
end
always@(posedge clk or negedge rst_n)
begin
      if(!rst_n)
         begin
              data <= 100'd0;            /////////数组初始化
         end
       else
         case(state_flag)
           state_0:   data [cnt_100] <= 1'd0;       /////////////根据时钟依次判断state_flag的值，判断是P，0,1三种状态，用cnt_100自动依次从低位到高位存储码源
           state_1:   data [cnt_100] <= 1'd1;
           state_P:   data [cnt_100] <= 1'd1;
         endcase
end
endmodule