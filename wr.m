close all;
clc;
com={'wr1208'	'wr1209'	'wr1210'	'wr1211'	'wr1212'	'wr1301'	'wr1302'	'wr1303'	'wr1304'	'wr1305'	'wr1306'	'wr1307'}';
F0=[4140	3885	3817	3796	3619	3791	3815	3869	3869	3751	3751	3751]';
r=0.05;
sigma=[0.170099691	0.218390008	0.196678923	0.120992012	0.179043632	0.122552152	0.128495779	0.199558472	0.228299358	0.224117141	0.193590285	0.223333415]';
T=[16	47	79	108	138	169	200	228	260	289	322	351]'/365;
k=3;
nstep=500;
K=2500:100:5500;
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