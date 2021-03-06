close all;
clc;
com={'cu1208'	'cu1209'	'cu1210'	'cu1211'	'cu1212'	'cu1301'	'cu1302'	'cu1303'	'cu1304'	'cu1305'	'cu1306'	'cu1307'}';
F0=[55150	55020	55000	54830	54750	54770	54720	54830	54920	54810	54850	54840]';
r=0.05;
sigma=[0.275137419	0.282269565	0.245282911	0.207902448	0.188426009	0.191503337	0.187415421	0.180240332	0.193933423	0.197961404	0.181618983	0.243647288]';
T=[16	47	79	108	138	169	200	228	260	289	322	351]'/365;
k=3;
nstep=500;
K=48000:500:70000;
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

for j=1:length(F0)
    subplot(3,4,j); plot(K,[PriceFBA(:,j) PriceFBE(:,j) PriceLS(:,j)]);
    h = legend('Binomial','BlackEurope','LeastSquareMC');
    set(h, 'Location', 'NorthWest');
    title(com(j));
    xlabel('Strike Price');
    ylabel('Put Option Price');
end;
