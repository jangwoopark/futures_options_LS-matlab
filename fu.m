close all;
clc;
com={'fu1208'	'fu1209'	'fu1210'	'fu1211'	'fu1212'	'fu1301' 'fu1303'	'fu1304'	'fu1305'	'fu1306'	'fu1307'}';
F0=[4525	4786	4709	4825	4823	4901	4785	4930	4802	4693	4693]';
r=0.05;
sigma=[0.212258889	0.20614235	0.216364028	0.224900902	0.267210326	0.234858685	0.091174862	0.309916662	0.2730254	0.291873922	0.327752271]';
T=[2 32	71	93	123	188	213	248	275	305	336]'/365;
k=3;
nstep=500;
K=3000:100:7000;
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
