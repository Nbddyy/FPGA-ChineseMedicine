%绘制正弦波

F1 = 1;		%信号频率
Fs = 2^12;	%采样频率
N = 2^12;	%采样数量
t = [0:1 / 2^12:N / 2^12];	%采样时间
P1 = 0;		%信号初始相位
ADC = 2^7;	%直流分量
A = 2^7 - 1;%信号幅度

y = A * sin(2 * pi * F1 * t + pi * P1 / 180) + ADC;

plot(y);	%绘制正弦波

%打开或者创建文件，以文本形式覆盖现有的
file = fopen("C:\Users\Hasee\Desktop\sine_wave.mif","wt");	

fprintf(file, '%s\n', "WIDTH=8;");			%cell单元格宽度为8
fprintf(file, '%s\n\n', "DEPTH=4096;");		%cell单元格可存储地址个数为4096

fprintf(file,'%s\n',"ADDRESS_RADIX=UNS;")	%address格式为无符号整数
fprintf(file,'%s\n\n',"DATA_RADIX=UNS;")	%数据格式为无符号整数

fprintf(file,'%s\t%s\n',"CONTENT","BEGIN")	%\t制表符对齐

for i = 1:N

	s0 = i / 2^12;
	y = A * sin(2 * pi * F1 * s0 + pi * P1 / 180) + ADC;
	y_out = round(y);

	fprintf(file,'\t%g',i - 1);
	fprintf(file,'\t%s\t',":");
	fprintf(file,'%d%s\n',y_out,";");

end

fprintf(file,'%s',"END;");

fclose(file);