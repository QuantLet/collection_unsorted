clc
clear all
data    =xlsread('data.xlsx','Sheet1','A2:J751');
y_1     = data(:,1);
rX_2    = data(:,2);
rX_3    = data(:,3);
rX_4    = data(:,4);
rX_5    = data(:,5);
f_t_2   = data(:,6);
f_t_3   = data(:,7);
f_t_4   = data(:,8);
f_t_5   = data(:,9);
N_0     = 240;
k       = 12;

for i=1:750;
    c(i)=1;
end
    P=[c(1:N_0)',y_1(1:N_0),f_t_2(1:N_0),f_t_3(1:N_0),f_t_4(1:N_0),f_t_5(1:N_0)];
    S(:,:,N_0)=P'*P;
    beta_hat(:,N_0)=(P'*P)\(P')*rX_5(1:N_0);  
for N=N_0:750-k-1
    S(:,:,N+1)=S(:,:,N)+[1,y_1(N+1),f_t_2(N+1),f_t_3(N+1),f_t_4(N+1),f_t_5(N+1)]'*[1,y_1(N+1),f_t_2(N+1),f_t_3(N+1),f_t_4(N+1),f_t_5(N+1)];
    r(:,N+1)=S(:,:,N+1)\[1,y_1(N+1),f_t_2(N+1),f_t_3(N+1),f_t_4(N+1),f_t_5(N+1)]';
    e=rX_5(N+1+k)-[1,y_1(N+1),f_t_2(N+1),f_t_3(N+1),f_t_4(N+1),f_t_5(N+1)]*beta_hat(:,N);
    beta_hat(:,N+1)=beta_hat(:,N)+r(:,N+1)*e;
end
    rX_5_hat=[c(1:N+1)',y_1(1:N+1),f_t_2(1:N+1),f_t_3(1:N+1),f_t_4(1:N+1),f_t_5(1:N+1)]*beta_hat(:,N+1);
RMSE_0=sqrt(sum((rX_5(N_0:N+1)-rX_5_hat(N_0:N+1)).^2)/(N+1-N_0));
MAE_0=sum(abs(rX_5(N_0:N+1)-rX_5_hat(N_0:N+1))/(N+1-N_0));
     
