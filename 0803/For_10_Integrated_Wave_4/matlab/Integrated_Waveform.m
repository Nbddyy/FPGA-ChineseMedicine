% Description : 绘制正弦波、方波、三角波、锯齿波

clc;
clear all;

file = fopen("C:\Users\Hasee\Desktop\Integrated_Waveform.mif","wt");
fprintf(file,"%s\n","WIDTH=8;");				%定义宽度
fprintf(file,"%s\n\n","DEPTH=16384;");			%定义深度
fprintf(file,"%s\n","ADDRESS_RADIX=UNS;");	%定义地址格式
fprintf(file,"%s\n\n","DATA_RADIX=UNS;");		%定义数据格式
fprintf(file,"%s\t%s\n","CONTENT","BEGIN");


%绘制正弦波-----------------------------------------------------
F1 = 1;			%信号频率
Fs1 = 2^12;		%采样频率
N1 = 2^12;		%采样个数
t1 = [0:1 / Fs1:(N1-1) / Fs1];	%每一个采样点对应的采样时刻
phi = 0;		%信号初始相位
ADC = 2^7;		%直流分量
A = 2^7 - 1;	%信号幅度

s1 = A * sin(2 * pi * F1 * t1 + phi) + ADC;

for i1 = 1 : N1
	s_data1(i1) = round(s1(i1));
	fprintf(file,"\t%g\t%s\t%d%s\n",i1-1,':',s_data1(i1),';');
end

subplot(2,2,1);
plot(s1);
% hold on;



%绘制方波-----------------------------------------------------
F2 = 1;			%信号频率
Fs2 = 2^12;		%采样频率
N2 = 2^12;		%采样个数
t2 = [0:1 / Fs2:(N2-1) / Fs2];	%每一个采样点对应的采样时刻
P2 = 0;		%信号初始相位
ADC2 = 2^7;		%直流分量
A2 = 2^7 - 1;	%信号幅度
s2 = A2 * square(2 * pi * F2 * t2 + pi * P2 / 180) + ADC2;

for i2 = 1 : N2
	s_data2(i2) = round(s2(i2));
	fprintf(file,"\t%g\t%s\t%d%s\n",i2-1+N2,':',s_data2(i2),';');
end

subplot(2,2,2);
plot(s2);
% hold on;


%绘制三角波-----------------------------------------------------
F3 = 1;			%信号频率
Fs3 = 2^12;		%采样频率
N3 = 2^12;		%采样个数
t3 = [0:1 / Fs3:(N3-1) / Fs3];	%每一个采样点对应的采样时刻
P3 = 0;		%信号初始相位
ADC3 = 2^7;		%直流分量
A3 = 2^7 - 1;	%信号幅度
s3 = A3 * sawtooth(2 * pi * F3 * t3 + pi * P3 / 180,0.5) + ADC3;

for i3 = 1 : N3
	s_data3(i3) = round(s3(i3));
	fprintf(file,"\t%g\t%s\t%d%s\n",i3-1+N2+N3,':',s_data3(i3),';');
end

subplot(2,2,3);
plot(s3);
% hold on;

%绘制锯齿波-----------------------------------------------------
F4 = 1;			%信号频率
Fs4 = 2^12;		%采样频率
N4 = 2^12;		%采样个数
t4 = [0:1 / Fs4:(N4-1) / Fs4];	%每一个采样点对应的采样时刻
P4 = 0;		%信号初始相位
ADC4 = 2^7;		%直流分量
A4 = 2^7 - 1;	%信号幅度
s4 = A4 * sawtooth(2 * pi * F4 * t4 + pi * P4 / 180) + ADC4;

for i4 = 1 : N4
	s_data4(i4) = round(s4(i4));
	fprintf(file,"\t%g\t%s\t%d%s\n",i4-1+N2+N3+N4,':',s_data4(i4),';');
end

subplot(2,2,4);
plot(s4);
% hold on;



fprintf(file,"%s","END;");
fclose(file);	%关闭文件资源