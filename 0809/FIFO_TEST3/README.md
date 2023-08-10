## FIFO_TEST3



缓存FIFO通道：

rdreq：两种情况下置0

① 当rdusedw为0

② 检测到其他IP核到达输入数据阈值（注意可能出现倍数没有输出的情况）



轮询检测FIFO，超阈值输出

如果出现了正在读DCFIFO输出的数据，检测另一个IP核到达IN数据阈值，则更改数据输入IP核；

我们这里定义一个两位宽的输入用来标识上传的数据属于哪个缓存FIFO通道数据。

![1691654039001](C:\Users\Hasee\AppData\Roaming\Typora\typora-user-images\1691654039001.png)
