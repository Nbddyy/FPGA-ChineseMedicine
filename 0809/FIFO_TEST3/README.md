## FIFO_TEST3



缓存FIFO通道：

rdreq：两种情况下置0

① 当rdusedw为0

② 检测到其他IP核到达输入数据阈值（注意可能出现倍数没有输出的情况）



轮询检测FIFO，超阈值输出

如果出现了正在读DCFIFO输出的数据，检测另一个IP核到达IN数据阈值，则更改数据输入IP核；

我们这里定义一个两位宽的输入用来标识上传的数据属于哪个缓存FIFO通道数据。

![image](https://github.com/Nbddyy/FPGA-ChineseMedicine/assets/95341178/bd3ea217-3464-4fd9-9389-a6c5e26f3781)

