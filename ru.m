close all;
clc;
com={'ru1208'	'ru1209'	'ru1210'	'ru1211'	'ru1301'	'ru1303'	'ru1304'	'ru1305'	'ru1306'	'ru1307'}';
F0=[22780	22710	22535	22350	22365	22580	22730	22595	22605	22730]';
r=0.05;
sigma=[0.292802308	0.327389394	0.276860517	0.254882767	0.258752684	0.272639369	0.261165491	0.329491565	0.265900871	0.307523136]';
T=[16	47	79	108	169	228	260	289	322	351]'/365;
k=3;
nstep=500;
K=15000:500:40000;
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