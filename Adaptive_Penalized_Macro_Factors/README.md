[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **AdaptivePenalizedMacroFactor2** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet:  AdaptivePenalizedMacroFactor2

Published in:     'Unpublished - Theoretical description 
                   of why we are going to use the adaptive methods'

Description:      'Builds a classification model to predict
                   by combining the shrinking methods with the adaptive methods.
                   model can automatically detect the homogenous interval 
                   and the active macro-factor set'

Keywords:          regression, forcast, simulation, financial, price, likelihood

Author [New]:      Xinjue Li

Submitted:         Tue, February 2 2016 by Xinjue Li

Example:           There are two examples, one is about coefficients varying, the other is forecasting 

```

### MATLAB Code
```matlab

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



```

automatically created on 2018-09-04