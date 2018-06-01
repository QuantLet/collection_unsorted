clc
clear all
data  = xlsread('figure.xls','Sheet1','A2:J751');
AE    = data(:,1);
OE    = data(:,2);
OD    = data(:,3);
Time  = data(:,4);

plot(Time,AE,'r');
hold on;
plot(Time,OE,'g');
hold on;
plot(Time,OD,'b');

set(gca,'XTickLabel',{'1972','1981','1990','1998','2006','2014','2021'})  


