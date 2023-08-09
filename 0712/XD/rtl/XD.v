module XD 
#(
   parameter CNT_MAX = 24'd999_999
)
(
    input  wire sys_clk,
    input  wire sys_rst_n,
    input  wire key_in,
    output wire xd
);
reg key_flag;
reg [24:0] cnt_1;
reg [32:0] cnt_2;
always@(posedge sys_clk or negedge sys_rst_n)
begin
      if(!sys_rst_n)
         begin
              cnt_1 <= 24'd0;
         end
      else if(key_in == 1'd1)
         begin
              cnt_1 <= 24'd0;              
         end
      else if(cnt_1 == CNT_MAX)
         begin
              cnt_1 <= cnt_1;
         end
      else
         begin
              cnt_1 <= cnt_1 + 1'd1;
         end
end
always@(posedge sys_clk or negedge sys_rst_n)
begin
       if(!sys_rst_n)
          begin
              key_flag <= 1'd0;
          end
        else if(cnt_1 == CNT_MAX - 24'd1 )
           begin
               key_flag <= 1'd1;
           end
        else
           begin
               key_flag <= 1'd0;               
           end
end
always@(posedge sys_clk or negedge sys_rst_n)
begin
      if(!sys_rst_n)
         begin
               cnt_2 = 32'd49_999_999;
         end
      else if(key_flag == 1'd1)
         begin
               cnt_2 <= 32'd0;
         end
      else if(cnt_2 == 32'd49_999_999)
         begin
               cnt_2 <= 32'd49_999_999;
         end
      else 
         begin
               cnt_2 <= cnt_2 + 1'd1;
         end
end

       assign xd = (key_flag == 1'd1 && cnt_2 <= 32'd29_999_999) ?  1 : 0;

endmodule