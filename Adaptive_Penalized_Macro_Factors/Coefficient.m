clc
clear all
data=xlsread('data.xlsx','Sheet1','A2:J751');
y_1     = data(:,1);
rX_2    = data(:,2);
rX_3    = data(:,3);
rX_4    = data(:,4);
rX_5    = data(:,5);
f_t_2   = data(:,6);
f_t_3   = data(:,7);
f_t_4   = data(:,8);
f_t_5   = data(:,9);
AER     = data(:,10);
for i=1:750;
    c(i)=1;
end
k=239;% rolling for 20 years
for j=240:750;
    X=[c(j-k:j)',y_1(j-k:j),f_t_2(j-k:j),f_t_3(j-k:j),f_t_4(j-k:j),f_t_5(j-k:j)];
    Y_1=rX_2(j-k:j);
    Y_2=AER(j-k:j);
    belta(:,j)=inv(X'*X)*(X'*Y_1);%%%%estimation for the 2-years excess return
    theta(:,j)=inv(X'*X)*(X'*Y_2);%%%%estimation for the CP factors
end
b_1     = belta(1,240:750);
b_2     = belta(2,240:750);
b_3     = belta(3,240:750);
b_4     = belta(4,240:750);
b_5     = belta(5,240:750);
b_6     = belta(6,240:750);
t_1     = theta(1,240:750);
t_2     = theta(2,240:750);
t_3     = theta(3,240:750);
t_4     = theta(4,240:750);
t_5     = theta(5,240:750);
t_6     = theta(6,240:750);
Time    = [1:1:511];


subplot(2,3,1)
plot(Time,b_1,'r');
hold on;
plot(Time,t_1,'k');
title('intercept')
legend('2-years excess return','Rolling CP factors','location','SouthEast')

subplot(2,3,2)
plot(Time,b_2,'r');
hold on;
plot(Time,t_2,'k');
title('Coefficient_2')

subplot(2,3,3)
plot(Time,b_3,'r');
hold on;
plot(Time,t_3,'k');
title('Coefficient_3')

subplot(2,3,4)
plot(Time,b_4,'r');
hold on;
plot(Time,t_4,'k');
title('Coefficient_4')

subplot(2,3,5)
plot(Time,b_5,'r');
hold on;
plot(Time,t_5,'k');
title('Coefficient_5')

subplot(2,3,6)
plot(Time,b_6,'r');
hold on;
plot(Time,t_6,'k');
title('Coefficient_6')



    
    
