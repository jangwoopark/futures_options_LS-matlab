function put = exfdamput(Fmax, dF, T, dT, X, R, SIG)
M = ceil(Fmax/dF); df = Fmax/M;
N = ceil(T/dT); dt = T/N;

J = 1:M-1;
a = (- .5*SIG^2*dt*J.^2) / (1+R*dt);
b = (1 + SIG^2*dt*J.^2 + R*dt) / (1+R*dt);
c = (- .5*SIG^2*dt*J.^2) / (1+R*dt);

A = diag(b) + diag(a(2:M-1), -1) + diag(c(1:M-2), 1);

put = zeros(N+1, M+1);
put(N+1, :) = max(X - [0:df:Fmax], 0);
put(:, 1) = X; put(:, M+1) = 0;

for i = N:-1:1
    y = zeros(1, M-1);
    y(1) = a(1)*put(i+1, 1); y(M-1) = c(M-1)*put(i+1,M+1);
    put(i, 2:M) = put(i+1, 2:M) * A' + y;
    put(i, :) = max(X - [0:df:Fmax], put(i,:));
end