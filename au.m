close all;
clc;
com={'au1208'	'au1209'	'au1210'	'au1211'	'au1212'	'au1301'	'au1302'	'au1303'	'au1304'	'au1305'	'au1306'	'au1307'}';
F0=[331.7	331.26	333.93	334.07	334.45	335.36	335.98	332.81	333.54	336.02	335.19	332.56]';
r=0.05;
sigma=[0.207960973	0.226884879	0.196761831	0.198753204	0.170037928	0.168811092	0.16632659	0.179874009	0.183509191	0.147350328	0.117361925	0.06542934]';
T=[16	47	79	108	138	169	200	228	260	289	322	351]'/365;
k=3;
nstep=500;
K=250:5:450;
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