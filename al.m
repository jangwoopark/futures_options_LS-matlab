close all;
clc;
com={ 'al1208'	'al1209'	'al1210'	'al1211'	'al1212'	'al1301'	'al1302'	'al1303'	'al1304'	'al1305'	'al1306'	'al1307'}';
F0=[15490	15470	15445	15410	15405	15405	15450	15460	15555	15520	15570	15580]';
r=0.05;
sigma=[0.112004813	0.114927025	0.11151775	0.095815306	0.085298863	0.084103165	0.084290859	0.101246153	0.095118474	0.119464568	0.124297773	0.116951945]';
T=[16	47	79	108	138	169	200	228	260	289	322	351]'/365;
k=3;
nstep=500;
K=13000:100:18000;
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
for j=9:12
    subplot(2,2,j-8); plot(K,[PriceFBA(:,j) PriceFBE(:,j) PriceLS(:,j)]);
    h = legend('Binomial','BlackEurope','LeastSquareMC');
    set(h, 'Location', 'NorthWest');
    title(com(j));
    xlabel('Strike Price');
    ylabel('Put Option Price');
end;