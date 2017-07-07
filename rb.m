close all;
clc;
com={'rb1208'	'rb1209'	'rb1210'	'rb1211'	'rb1212'	'rb1301'	'rb1302'	'rb1303'	'rb1304'	'rb1305'	'rb1306'	'rb1307'}';
F0=[3746	3828	3845	3784	3778	3757	3776	3768	3796	3779	3797	3816]';
r=0.05;
sigma=[0.134518593	0.138021027	0.124859899	0.102831342	0.108751589	0.102600102	0.091926227	0.08551941	0.107026232	0.109002226	0.096618356	0.08980093]';
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