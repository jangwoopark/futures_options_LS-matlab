close all;
clc;
com={'ag1209'	'ag1210'	'ag1211'	'ag1212'	'ag1301'	'ag1302'	'ag1303'	'ag1304'	'ag1305'	'ag1306'	'ag1307'}';
F0=[5864	5887	5910	5893	5912	5935	5931	5954	5962	5988	5988]';
r=0.05;
sigma=[0.22918456	0.220942359	0.21496047	0.233302779	0.225183409	0.21863433	0.218420744	0.249742751	0.191554864	0.174202022	0.093673115]';
T=[47	79	108	138	169	200	228	260	289	322	351]'/365;
k=3;
nstep=500;
K=4500:100:7000;
PriceFBA=zeros(length(K),length(F0));
PriceFBE=zeros(length(K),length(F0));
PriceLS=zeros(length(K),length(F0));
for j=1:length(F0)
    for i=1:length(K)
        PriceFBE(i,j)=FutureBlackEuro(-1,F0(j),K(i),r,T(j),sigma(j));
        PriceFBA(i,j)=FutureBinomialAmerican(-1, F0(j), K(i), r, T(j), sigma(j), nstep);
        PriceLS(i,j)=longstaffschwartz(0,0,1,k,T(j),F0(j),K(i),r,sigma(j));
    end;
end;
%use each loop separately to get four graphs at a time
for j=1:4
    subplot(2,2,j); plot(K,[PriceFBA(:,j) PriceFBE(:,j) PriceLS(:,j)]);
    h = legend('Binomial','BlackEurope','LeastSquareMC');
    set(h, 'Location', 'NorthWest');
    title(com(j));
    xlabel('Strike Price');
    ylabel('Put Option Price');
end;
for j=5:8
    subplot(2,2,j-4); plot(K,[PriceFBA(:,j) PriceFBE(:,j) PriceLS(:,j)]);
    h = legend('Binomial','BlackEurope','LeastSquareMC');
    set(h, 'Location', 'NorthWest');
    title(com(j));
    xlabel('Strike Price');
    ylabel('Put Option Price');
end;
for j=9:10
    subplot(2,2,j-8); plot(K,[PriceFBA(:,j) PriceFBE(:,j) PriceLS(:,j)]);
    h = legend('Binomial','BlackEurope','LeastSquareMC');
    set(h, 'Location', 'NorthWest');
    title(com(j));
    xlabel('Strike Price');
    ylabel('Put Option Price');
end;