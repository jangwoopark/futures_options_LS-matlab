function put = imfamcall(Fmax, dF, T, dT, X, R, SIG)
M = ceil(Fmax/dF); df = Fmax/M;
N = ceil(T/dT); dt = T/N;

J = 1:M-1;
a = - .5*SIG^2*dt*J.^2;
b = 1 + SIG^2*dt*J.^2 + R*dt;
c = - .5*SIG^2*dt*J.^2;

A = diag(b) + diag(a(2:M-1), -1) + diag(c(1:M-2), 1);

call = zeros(N+1, M+1);
call(N+1, :) = max([0:df:Fmax] - X, 0);
call(:, 1) = X; call(:, M+1) = 0;

for i = N:-1:1
    y = call(i+1, 2:M)'; y(1) = y(1) -a(1)*X;
    call(i, 2:M) = [A \ y]';
    call(i, :) = max([0:df:Fmax] - X, call(i,:));
end