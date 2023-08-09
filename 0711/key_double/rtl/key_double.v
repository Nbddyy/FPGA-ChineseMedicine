module key_double 
#(
    parameter CNT_MAX = 32'd999_999
)
(
    input wire clk,
    input wire rst_n,
    input wire key1,
    output reg double_key_flag
);

reg [31:0] cnt1;
reg key_flag;

always @ (posedge clk or negedge rst_n)
begin
    if(~rst_n)
        begin
            cnt1 <= 1'b0;
        end 
    else if(key1 == 1'b1)
        begin
            cnt1 <= 1'b0;
        end
    else if(cnt1 == CNT_MAX)    //old:cnt <= 32'd999_999
        begin
            cnt1 <= cnt1;
        end
    else
        begin
            cnt1 <= cnt1 + 1'b1;
        end
end

always @ (posedge clk or negedge rst_n)
begin
    if(~rst_n)
        begin
            key_flag <= 1'b0;
        end
    else if(cnt1 == CNT_MAX - 32'd1)
        begin
            key_flag <= 1'b1;
        end
    else
        begin
        key_flag <= 1'd0;
        end
end

reg [31:0] cnt2;


always @(posedge clk or negedge rst_n)
begin
    if(~rst_n)
        begin
            cnt2 <= 32'd100_000_000;
        end
    else if(key_flag == 1'd1)
        begin
            cnt2 <= 32'd0;
        end
    else if(cnt2 > 32'd49_999_999) 
        begin
            cnt2 <= 32'd100_000_000;
        end
    else
        begin
            cnt2 <= cnt2 + 32'd1;    
        end
end


always @ (posedge clk or negedge rst_n)
begin
    if(~rst_n)
        begin
            double_key_flag <= 1'b0;
        end
    else if(key_flag == 1'b1 && cnt2 < 32'd49_999_998)  //old:31'd24_999_998
        begin
            double_key_flag <= ~double_key_flag;
        end
    else
        begin
            double_key_flag <= double_key_flag;
        end
end
   
  
endmodule