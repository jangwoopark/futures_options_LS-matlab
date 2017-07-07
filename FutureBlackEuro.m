function [X] = FutureBlackEuro(CallPut, AssetP, Strike, RiskFree, Time, Volatility)

dt = Volatility * sqrt(Time);                                
%df = RiskFree + 0.5 * Volatility ^ 2;            % Computes the drift term
d1 = (log( AssetP / Strike ) + Volatility ^ 2 * Time/2 ) / dt;             % Calculates the d1 term used in Blacks
d2 = d1 - dt;                                                % Calculates the d2 term used in Blacks

% The cumulative normal distribution functions for use in computing calls
nd1 = normcdf(d1);
nd2 = normcdf(d2);
% The cumulative normal distribution functions for use in computing puts
nnd1 = normcdf(-d1);
nnd2 = normcdf(-d2);

if CallPut==1
    % Computes call price
    CallPrice = exp(-RiskFree * Time) * (AssetP * nd1 - Strike *  nd2);
    X = CallPrice;
end

if CallPut==-1
    % Computes put price
    PutPrice = exp(-RiskFree * Time) * (Strike *  nnd2 - AssetP * nnd1);
    X = PutPrice;
end