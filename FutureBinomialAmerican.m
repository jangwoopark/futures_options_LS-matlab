function FutureBinomial = FutureBinomialAmerican(CallOrPut, Future, Strike, RiskFree, Expiration, Volatility, nSteps)
dt = Expiration / nSteps;
% selecting call or put
if CallOrPut == 1;
    sign =1;
end
if CallOrPut == -1;
    sign=-1;
end
% setting up variables
u = exp(Volatility*sqrt(dt));
d = 1/u;
p = (1-d)/(u-d);
% binomial tree movements
for i = 0:nSteps
    State = i + 1;
    Ft = Future*u^i*d^(nSteps - i);
    FutureValue(State) = max(0, sign*(Ft - Strike));
end
% backward recursively to get the price of the option
for Step = (nSteps - 1):-1:0
    for i = 0:Step
        State = i + 1;
        FutureValue(State) = max((sign*(Future*u^i*d^(abs(i-Step)) - Strike)),(p*FutureValue(State + 1) + (1-p)*FutureValue(State))*exp(-RiskFree*dt));
    end
end
FutureBinomial = FutureValue(1);