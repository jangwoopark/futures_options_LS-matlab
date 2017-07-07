close all;
clc;
com={'pb1208'	'pb1209'	'pb1210'	'pb1211'	'pb1212'	'pb1301'	'pb1302'	'pb1303'	'pb1304'	'pb1305'	'pb1306'	'pb1307'}';
F0=[14995	15005	14970	14905	14940	14965	14835	15065	14935	14770	14770	14770]';
r=0.05;
sigma=[0.210766043	0.198593754	0.205737372	0.172108206	0.156110941	0.161479127	0.200145337	0.208412219	0.220856416	0.228820995	0.247679376	0.122402407]';
T=[16	47	79	108	138	169	200	228	260	289	322	351]'/365;
k=3;
nstep=500;
K=12000:200:20000;
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