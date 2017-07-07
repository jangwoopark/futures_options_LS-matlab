close all;
num=xlsread('puts.xlsx');
F0=27.55;
r=0.05;
sigma=0.45069;
T=30/366;
k=3;
nstep=500;
K=[1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	16.25	16.5	16.75	17	17.25	17.5	17.75	18	18.25	18.5	18.75	19	19.25	19.5	19.75	20	20.25	20.5	20.75	21	21.25	21.5	21.75	22	22.25	22.5	22.75	23	23.25	23.5	23.75	24	24.25	24.5	24.75	25	25.25	25.5	25.75	26	26.25	26.5	26.75	27	27.25	27.5	27.75	27.9	28.1	28.2	28.25	28.3	28.4	28.5	28.6	28.7	28.75	28.8	28.9	29	29.1	29.2	29.25	29.3	29.4	29.5	29.6	29.7	29.75	29.8	29.9	30	30.1	30.2	30.25	30.3	30.4	30.5	30.6	30.7	30.75	30.8	30.9	31	31.1	31.2	31.25	31.3	31.4	31.5	31.6	31.7	31.75	31.8	31.9	32	32.1	32.2	32.25	32.3	32.4	32.5	32.6	32.7	32.75	32.8	32.9	33	33.1	33.2	33.25	33.3	33.4	33.5	33.6	33.7	33.75	33.8	33.9	34	34.1	34.2	34.25	34.3	34.4	34.5	34.6	34.7	34.75	34.8	34.9	35	35.1	35.2	35.25	35.3	35.4	35.5	35.6	35.7	35.75	35.8	35.9	36	36.1	36.2	36.25	36.3	36.4	36.5	36.6	36.7	36.75	36.8	36.9	37	37.1	37.2	37.25	37.3	37.4	37.5	37.6	37.7	37.75	37.8	37.9	38	38.1	38.2	38.25	38.3	38.4	38.5	38.6	38.7	38.75	38.8	38.9	39	39.1	39.2	39.25	39.3	39.4	39.5	39.6	39.7	39.75	39.8	39.9	40	40.1	40.2	40.25	40.3	40.4	40.5	40.6	40.7	40.75	40.8	40.9	41	41.1	41.2	41.25	41.3	41.4	41.5	41.6	41.7	41.75	41.8	41.9	42	42.1	42.2	42.25	42.3	42.4	42.5	42.6	42.7	42.75	42.8	42.9	43	43.1	43.2	43.25	43.3	43.4	43.5	43.6	43.7	43.75	43.8	43.9	44	44.1	44.2	44.25	44.3	44.4	44.5	44.6	44.7	44.75	44.8	44.9	45	45.25	45.5	45.75	46	46.25	46.5	46.75	47	47.25	47.5	48	49	50	51	52	53	54	55	56	57	58	59	60	61	62	63	64	65	66	67	68	69	70	71	72	73	74	75	76	77	78	79	80	81	82	83	84	85	86	87];
PriceFBA=zeros(length(K),1);
PriceFBE=zeros(length(K),1);
PriceLS=zeros(length(K),1);
for i=1:length(K)
    PriceFBE(i)=FutureBlackEuro(-1,F0,K(i),r,T,sigma);
    PriceFBA(i)=FutureBinomialAmerican(-1, F0, K(i), r, T, sigma, nstep);
    PriceLS(i)=longstaffschwartz(0,0,1,k,T,F0,K(i),r,sigma);
end;
siu2put=num(1:length(K),3);
plot(K, [siu2put PriceFBA PriceFBE PriceLS]);
h = legend('Bloomberg','Binomial','Blackseuro','LeastSquareMC');
set(h, 'Location', 'NorthWest');
title('Silver-Comex');
xlabel('Strike Price');
ylabel('Put Option Price');