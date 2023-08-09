`timescale 1ns/1ns

module XH_LED_2_tb ();
          reg        clk;
          reg        rst_n;
          wire [3:0] led_out;
initial begin
               clk <= 1'd0;
               rst_n <= 1'd0;
               #3000
               rst_n <= 1'd1;
end
always #10 clk <= !clk;
XH_LED_2 XH_LED_2  (
    .clk    (clk    ),
    .rst_n  (rst_n  ),   
    .led_out(led_out) 
);
endmodule