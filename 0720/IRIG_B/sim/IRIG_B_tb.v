`timescale 1ns/1ps

module IRIG_B_tb ();
     reg  clk;
     reg  rst_n;
     reg  sign;
     wire [3:0] seconds_g;
     wire [2:0] seconds_s;
     wire [3:0] minute_g ;
     wire [2:0] minute_s ;
     wire [3:0] hour_g   ;
     wire [1:0] hour_s   ;
     wire [3:0] day_g    ;
     wire [3:0] day_s    ;
     wire [1:0] day_b    ;
     wire [3:0] year_g   ;
     wire [3:0] year_s   ;
initial begin
     clk <= 1'd0;
     rst_n <= 1'd0;
     #34
     rst_n <= 1'd1;     
end
initial begin
     sign <= 1'd0;
     #34
     
     sign <= 1'd1;  // pr
     #8000000
     sign <= 1'd0;
     #2000000

     sign <= 1'd1;             
     #2000000        //1
     sign <= 1'd0;
     #8000000

     sign <= 1'd1;  //2
     #5000000
     sign <= 1'd0;
     #5000000

     sign <= 1'd1;  //4
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1;  // 8
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1;  //8_
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1;  //10
     #5000000
     sign <= 1'd0;
     #5000000

     sign <= 1'd1;//20
     #5000000
     sign <= 1'd0;
     #5000000

     sign <= 1'd1; //40
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1;  //p1
     #8000000
     sign <= 1'd0;
     #2000000

     sign <= 1'd1; //1
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //2
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //4
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //8
     #5000000
     sign <= 1'd0; 
     #5000000

     sign <= 1'd1;   //suo
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1;   //10            
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //20
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //40
     #2000000
     sign <= 1'd0;
     #8000000  
     
     sign <= 1'd1; //40_
     #2000000
     sign <= 1'd0;
     #8000000         

     sign <= 1'd1; //p2
     #8000000
     sign <= 1'd0;
     #2000000 

     sign <= 1'd1; //1
     #2000000
     sign <= 1'd0;
     #8000000 

     sign <= 1'd1; //2
     #2000000
     sign <= 1'd0;
     #8000000 

     sign <= 1'd1; //4
     #5000000
     sign <= 1'd0;
     #5000000 

     sign <= 1'd1; //8
     #2000000
     sign <= 1'd0;
     #8000000 

     sign <= 1'd1; //8_
     #2000000
     sign <= 1'd0;
     #8000000 

     sign <= 1'd1; //10
     #5000000
     sign <= 1'd0;
     #5000000 

     sign <= 1'd1;  //20
     #2000000
     sign <= 1'd0;
     #8000000 

     sign <= 1'd1; //20_
     #2000000
     sign <= 1'd0;
     #8000000 

     sign <= 1'd1; //20__
     #2000000
     sign <= 1'd0;
     #8000000 

     sign <= 1'd1; //p3
     #8000000
     sign <= 1'd0;
     #2000000 

     sign <= 1'd1; //1
     #5000000
     sign <= 1'd0;
     #5000000

     sign <= 1'd1; //2
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //4
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //8
     #2000000
     sign <= 1'd0;
     #8000000
     
     sign <= 1'd1; //8_
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //10
     #5000000
     sign <= 1'd0;
     #5000000

     sign <= 1'd1; //20
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //40
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //80
     #5000000
     sign <= 1'd0;
     #5000000

     sign <= 1'd1; //p4
     #8000000
     sign <= 1'd0;
     #2000000

     sign <= 1'd1; //100
     #5000000
     sign <= 1'd0;
     #5000000

     sign <= 1'd1; //200
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //200_1
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //200_2
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //200_3
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //200_4
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //200_5
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //200_6
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //200_7
     #2000000
     sign <= 1'd0;
     #8000000
     
     sign <= 1'd1; //p5
     #8000000
     sign <= 1'd0;
     #2000000

     sign <= 1'd1; //p5_1
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //p5_2
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //p5_3
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //p5_4
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //p5_5
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //p5_6
     #2000000
     sign <= 1'd0;
     #8000000     

     sign <= 1'd1; //p5_7
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //p5_8
     #2000000
     sign <= 1'd0;
     #8000000

     sign <= 1'd1; //p5_9
     #2000000
     sign <= 1'd0; 
end 
always #4 clk <= !clk;
IRIG_B IRIG_B (
    .clk      (clk      ),
    .rst_n    (rst_n    ),
    .sign     (sign     ),
    .seconds_g(seconds_g),
    .seconds_s(seconds_s),
    .minute_g (minute_g ),
    .minute_s (minute_s ),
    .hour_g   (hour_g   ),
    .hour_s   (hour_s   ),
    .day_g    (day_g    ),
    .day_s    (day_s    ),
    .day_b    (day_b    ),
    .year_g   (year_g   ),
    .year_s   (year_s   ) 
);
endmodule