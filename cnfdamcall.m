function put = cnfdamcall(Fmax, dF, T, dT, X, R, SIG)
M = ceil(Fmax/dF); df = Fmax/M;
N = ceil(T/dT); dt = T/N;

J = 1:M-1;
a = (- .5*SIG^2*dt*J.^2) / (1+R*dt);
b = (1 + SIG^2*dt*J.^2 + R*dt) / (1+R*dt);
c = (- .5*SIG^2*dt*J.^2) / (1+R*dt);

A = diag(1-b) + diag(-a(2:M-1), -1) + diag(-c(1:M-2), 1);

aa = - .5*SIG^2*dt*J.^2;
bb = 1 + SIG^2*dt*J.^2 + R*dt;
cc = - .5*SIG^2*dt*J.^2;

B = diag(bb-1) + diag(aa(2:M-1), -1) + diag(cc(1:M-2), 1);

g = zeros(1, M-1);
call = zeros(N+1, M+1);
call(N+1, :) = max([0:df:Fmax] - X, 0);
call(:, 1) = X; call(:, M+1) = 0;

for i = N:-1:1
    g = call(i+1, 2:M) * A'; g(1) = g(1) - a(1)*X - aa(1)*X;
    call(i, 2:M) = [B \ g']';
    call(i, :) = max([0:df:Fmax] - X, call(i,:));
end