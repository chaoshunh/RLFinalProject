function [R, AR, QR] = epsilon_greedy(alpha, epsilon, X, K)
Q = zeros(1,K);
N = size(X,2);
C = size(X,1);
R = zeros(1,N);
AR = zeros(1,N);
QR = zeros(N,K); 
for t = 1:N
    A = X(:,t,1);
    ran = rand();
    if ran < epsilon
        a = randi(length(A),1);
    else
        a = greedy(Q,A);
    end    
    rew = 0;
    for c = 1:C
        if c==a
            rew = rew + X(c,t,2);
        else
            rew = rew + X(c,t,3);
        end
    end
    if(alpha < 0)
        alpha = 1/(t+1);
    end
    Q(A(a)) = Q(A(a))*(1-alpha) + alpha*rew;
    AR(t) = A(a);
    R(t) = rew;
    QR(t,:) = Q;
end