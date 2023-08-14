## FIFO_v2



如果1个大模块中有多个小模块，且小模块之间有相互连线，这些连线没有从大模块出去或者进来，则需要声明小模块之间的连接线。

本次为FIFO核（Git）的版本练习

总共发布8个版本，依次如下:

4FIFO-不带帧头-不用generate

4FIFO-不带帧头-用generate

4FIFO-带帧头-不用generate

4FIFO-带帧头-用generate



30FIFO-不带帧头-不用generate

30FIFO-不带帧头-用generate

30FIFO-带帧头-不用generate

30FIFO-带帧头-用generate



### 版图设计：

![1691717337260](C:\Users\Hasee\AppData\Roaming\Typora\typora-user-images\1691717337260.png)

### Poll_Detect:

```
使用独热码表示以下五种状态
IDLE:00_001
CH1:00_010
CH2:00_100
CH3:01_000
CH4:10_000
```

```
如果检测到对应通道的rdusedw到达128，则状态转移至对应通道，且如果没有检测到其他通道rdusedw到达阈值，
则保持不变，当该状态通道的rdusedw为0时认为没有数据可读，状态变为IDLE，若在变为0的过程中检测到其他通道
到达128，则状态转移至对应通道状态。
```

![1691717396011](C:\Users\Hasee\AppData\Roaming\Typora\typora-user-images\1691717396011.png)