close all;
clc;
com={'zn1208'	'zn1209'	'zn1210'	'zn1211'	'zn1212'	'zn1301'	'zn1302'	'zn1303'	'zn1304'	'zn1305'	'zn1306'	'zn1307'}';
F0=[14595	14640	14620	14630	14665	14710	14730	14780	14800	14850	14865	14925]';
r=0.05;
sigma=[0.226097128	0.214332913	0.195240931	0.162450406	0.138213762	0.142552147	0.134678553	0.137778676	0.140836883	0.148912621	0.159374896	0.128321051]';
T=[16	47	79	108	138	169	200	228	260	289	322	351]'/365;
k=3;
nstep=500;
K=12000:400:20000;
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