module XH_LED_2 (
    input wire clk,
    input wire rst_n,   
    output reg [3:0] led_out 
);
    reg [31:0] cnt_1;
    reg [31:0] cnt_2;
    reg key_flag; 
parameter M =32'd25_000_000 - 1'd1;
parameter N =32'd99_999_999 - 1'd1;
always@(posedge clk or negedge rst_n)  
begin
       if(!rst_n)
          begin
              cnt_1 <= 32'd0;
          end
        else if(cnt_1 == M)
          begin
               cnt_1 <= 32'd0;
          end
        else
           begin
               cnt_1 <= cnt_1 + 1'd1;
           end
end
always@(posedge clk or negedge rst_n)
begin
       if(!rst_n)
         begin
             cnt_2 <= 32'd0;
         end
        else if(cnt_2 == N)
          begin
               cnt_2 <= 32'd0;
          end
        else
          begin
               cnt_2 <= cnt_2 + 1'd1;              
          end
end
always@(posedge clk or negedge rst_n)
begin
       if(!rst_n)
          begin
              key_flag <= 1'd0;
          end
        else if(cnt_2 == N-1'd1)
           begin
              key_flag <= !key_flag;
           end
        else
          begin
              key_flag <= key_flag;               
          end
end
always@(posedge clk or negedge rst_n)
begin
       if(!rst_n)
          begin
              led_out <= 4'b1110;
          end
        else if(key_flag == 1'd0 && cnt_1 == M )
           begin
                led_out <= {led_out[2:0],led_out[3]};
           end
        else if(key_flag == 1'd1 && cnt_1 == M)
           begin
                led_out <= {led_out[0],led_out[3:1]};             
           end
end
endmodule