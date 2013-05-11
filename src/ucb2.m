function [R, AR, QR] = ucb2(alpha, X, K)
N = size(X,2);
C = size(X,1);

Q = zeros(1,K);
N_a = zeros(1,K);
r_a = zeros(1,K);
R = zeros(1,N);
AR = zeros(1,N);
QR = zeros(N,K); 
for t = 1:N
    A = X(:,t,1);
    % ran = rand();
    % if ran < epsilon
    %     a = randi(length(A),1);
    % else
    %     a = greedy(Q,A);
    % end    
    a = argmaxUCB2(Q, A, N_a, r_a, alpha);
    m = tau(r_a(A(a))+1, alpha) - tau(r_a(A(a)), alpha);
    for tm = 1:m
        t = t + 1;
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
        N_a(a) = N_a(a) + 1;
        Q(A(a)) = Q(A(a))*(1-alpha) + alpha*rew;
        AR(t) = A(a);
        R(t) = rew;
        QR(t,:) = Q;
    end
    r_a(a) = r_a(a) + 1;
end

function a = argmaxUCB2(Q, A, N_a, r_a, alpha)
obj = Q(A) + sqrt((1+alpha)/2*tau(r_a(A), alpha).^(-1).*log(exp(1)*sum(N_a)*tau(r_a(A), alpha).^(-1)));
[~, I] = max(obj);
i = randi(length(I), 1);
a = I(i);

function t = tau(x, alpha)
t = ceil((1 + alpha).^x);