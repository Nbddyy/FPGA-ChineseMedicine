`timescale 1ns/1ns
module tb_key_filter();

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//

//parameter define
//为了缩短仿真时间，我们将参数化的时间值改小
//但位宽依然定义和参数名的值保持一致
//也可以将这些参数值改成和参数名的值一致
parameter CNT_1MS = 20'd19 ,
CNT_11MS = 21'd69 ,
CNT_41MS = 22'd149 ,
CNT_51MS = 22'd199 ,
CNT_60MS = 22'd249 ;

//wire define
wire double_key_flag ; //消抖后按键信号

//reg define
reg clk ; //仿真时钟信号
reg rst_n ; //仿真复位信号
reg key1 ; //模拟按键输入
reg [21:0] tb_cnt ; //模拟按键抖动计数器

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//初始化输入信号
initial begin
clk = 1'b1;
rst_n <= 1'b0;
key1 <= 1'b0;
#20 
rst_n <= 1'b1;
end

//clk:模拟系统时钟，每 10ns 电平翻转一次，周期为 20ns，频率为 50MHz
always #10 clk = ~clk;


//tb_cnt:按键过程计数器，通过该计数器的计数时间来模拟按键的抖动过程
always@(posedge clk or negedge rst_n)
if(rst_n == 1'b0)
tb_cnt <= 22'b0;
else if(tb_cnt == CNT_60MS)
//计数器计数到 CNT_60MS 完成一次按键从按下到释放的整个过程
tb_cnt <= 22'b0;
else 
tb_cnt <= tb_cnt + 1'b1;

//key1:产生输入随机数，模拟按键的输入情况
always@(posedge clk or negedge rst_n)
if(rst_n == 1'b0)
key1 <= 1'b1; //按键未按下时的状态为为高电平
else if((tb_cnt >= CNT_1MS && tb_cnt <= CNT_11MS)
|| (tb_cnt >= CNT_41MS && tb_cnt <= CNT_51MS))
//在该计数区间内产生非负随机数 0、1 来模拟 10ms 的前抖动和 10ms 的后抖动
key1 <= {$random} % 2; 
else if(tb_cnt >= CNT_11MS && tb_cnt <= CNT_41MS)
key1 <= 1'b0;
//按键经过 10ms 的前抖动后稳定在低电平，持续时间需大于 CNT_MAX
else
key1 <= 1'b1;

//********************************************************************//
//*************************** Instantiation **************************//
//********************************************************************//

//------------------------key_filter_inst------------------------
key_double
#(
.CNT_MAX (20'd24 )
//修改的 CNT_MAX 值一定要小于(CNT_41MS - CNT_11MS)
//否则就会表现为按键一直处于“抖动状态”而没有“稳定状态”
//无法模拟出按键消抖的效果
)
key_filter_inst
(
.clk (clk ), //input clk
.rst_n (rst_n ), //input rst_n
.key1 (key1 ), //input key1

.double_key_flag (double_key_flag ) //output double_key_flag
);

endmodule