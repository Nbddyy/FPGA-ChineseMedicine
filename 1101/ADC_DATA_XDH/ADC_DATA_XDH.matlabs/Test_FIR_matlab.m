 clc;
 clear all;

 N = 4096;				%数据样点长度
 f1 = 1000000;			%信号1频率（信号的频率是1MHz）变量声明的单位是hz
 f2 = 3000000;			%信号2频率（信号的频率是3MHz）变量声明的单位是hz
 Fs = 50000000;			%采样频率，（信号的采样频率是50MHz）单位是hz

 t=0:1/Fs:1/Fs*(N-1);	%产生时间序列

 s1 = sin(2*pi*f1*t);	%产生一个正弦信号，它的频率是1MHz
 s2 = sin(2*pi*f2*t);	%产生一个正弦信号，它的频率是3MHz

 s3 = s1 + s2;

 %%%画出这2个信号的时域波形
 	figure(1);
 	subplot(311); plot(t,s1);
 	xlabel('时间'); ylabel('幅度'); title('信号1的时域波形，频率是（1MHz）');

 	subplot(312); plot(t,s2);
 	xlabel('时间'); ylabel('幅度'); title('信号2的属于波形 频率是（3MHz）');

 	subplot(313); plot(t,s3);
 	xlabel('时间'); ylabel('幅度'); title('信号3的时域波形 为s1和s2信号叠加');


 %%%设计1个低通滤波器，为512阶，截止频率为1.2MHz

 	%滤波器的系数生成
 	b = fir1(512, 1200000/(Fs/2));
 	Filter = filter(b,1,s3);
 	Filter_1 = Filter/max(Filter);

 	figure(2);

 	subplot(311); plot(t,s3);
 	xlabel('时间'); ylabel('幅度'); title('信号3的时域波形 为s1和s2信号叠加');

 	subplot(312); plot(t,s1);
 	xlabel('时间'); ylabel('幅度'); title('信号1的时域波形 频率是（1MHz）');

 	subplot(313); plot(t,Filter_1);
 	xlabel('时间'); ylabel('幅度'); title('s1和s2信号叠加经过低通滤波器');


 %%%去直流
	Filter_mean = Filter - mean(Filter);

	figure(3);
	plot(t,Filter_mean); grid on;
	xlabel('时间'); ylabel('幅度'); title('s1和s2信号叠加经过低通滤波器,去直流后的'); 

%%%将产生的滤波器系数写入.coe文件中
%%%%%%%%%%%可用于%%%%%%%%%%%%%
	fid = fopen('LPF_1_2_MHz.coe','W');
	fprintf(fid, 'radix = 10;\r\n');
	fprintf(fid, 'coefdata = \r\n');
	fprintf(fid, '%10.28f\r\n',b);
	fprintf(fid,';')
	fclose(fid);
%%%%可用于产生coe文件%%%%%%%%%