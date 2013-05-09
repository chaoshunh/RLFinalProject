function R = reinforcementComparison(alpha, beta, X, K)
p = zeros(1,K);
N = size(X,2);
C = size(X,1);
R = zeros(1,N);
AR = zeros(1,N);
QR = zeros(N,K);
rr = 0.0;
for t = 1:N
    A = X(:,t,1);
    
    pA = exp(p(A));
    pA = 1/sum(pA)*pA;
    i = find(rand(1) < cumsum(pA));
    a = i(1);
    rew = 0;
    for c = 1:C
        if c==a
            rew = rew + X(c,t,2);
        else
            rew = rew + X(c,t,3);
        end
    end
    
    p(A(a)) = p(A(a)) + beta*(rew - rr);
    rr = rr + alpha*(rew - rr);
    AR(t) = A(a);
    R(t) = rew;
    QR(t,:) = p;
    
end

figure
plot(R)

figure
plot(AR)

figure
plot(QR)

figure
plotA(AR)