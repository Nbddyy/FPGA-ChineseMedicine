file = fopen("C:\Users\Hasee\Desktop\Integrated_Wave.mif","wt")	

fprintf(file, '%s\n', "WIDTH=8;");		%数据宽度为8
fprintf(file,'%s\n\n',"DEPTH=16384;");	%数据深度为16384

fprintf(file, '%s\n',"ADDRESS_RADIX=UNS;");	%地址格式为无符号数
fprintf(file,'%s\n\n',"DATA_RADIX=UNS;");	%数据格式为无符号数

fprintf(file,"%s\t%s\n","CONTENT","BEGIN");

F = 1;		%信号频率
Fs = 2^12;	%采样频率
N = 2^12;	%采样个数
T = [0:1 / Fs:(N-1) / Fs];	%每个采样点对应的时刻
phi = 0;	%信号初始相位
A = 2^7 - 1;	%信号幅度
ADC = 2^7;	%直流分量

%绘制正弦波

s1 = A * sin(2 * pi * F * T + phi * pi / 180) + ADC;

for i = 1 : N
	s_1(i) = round(s1(i));
	fprintf(file, '\t%g\t%s\t%d%s\n',i-1,':',s_1(i),';');
end

subplot(2,2,1);
plot(s1);


%绘制方波

s2 = A * square(2 * pi * F * T + phi * pi / 180) + ADC;

for i = 1 : N
	s_2(i) = round(s2(i));
	fprintf(file, '\t%g\t%s\t%d%s\n',i-1+N,':',s_2(i),';');
end

subplot(2,2,2);
plot(s2);


%绘制三角波

s3 = A * sawtooth(2 * pi * F * T + phi * pi / 180,0.5) + ADC;

for i = 1 : N
	s_3(i) = round(s3(i));
	fprintf(file, '\t%g\t%s\t%d%s\n',i-1+2 * N,':',s_3(i),';');
end

subplot(2,2,3);
plot(s3);



%绘制锯齿波

s4 = A * sawtooth(2 * pi * F * T + phi * pi / 180) + ADC;

for i = 1 : N
	s_4(i) = round(s4(i));
	fprintf(file, '\t%g\t%s\t%d%s\n',i-1+3 * N,':',s_4(i),';');
end

subplot(2,2,4);
plot(s4);

fprintf(file,'%s\n',"END;")
fclose(file);