function ucb1_normal(alpha, X, K)
N = size(X,2);
C = size(X,1);

Q = zeros(1,K);
N_a = zeros(1,K);
q_a = zeros(1,K);
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
    tmp = find(N_a(A) < ceil(8*log(t)));
    if(length(tmp) > 0)
        a = tmp(1);
    else
        a = argmaxUCB1Normal(Q, A, N_a, q_a);
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
    N_a(a) = N_a(a) + 1;
    q_a(A(a)) = q_a(A(a)) + rew^2;
    Q(A(a)) = Q(A(a))*(1-alpha) + alpha*rew;
    AR(t) = A(a);
    R(t) = rew;
    QR(t,:) = Q;
end
figure
plot(R)

figure
plot(AR)

figure
plot(QR)

function a = argmaxUCB1Normal(Q, A, N_a, q_a)
up = q_a(A) - N_a(A).*(Q(A).^2);
bottom = (N_a(A) - 1).*N_a(A);
obj = Q(A) + sqrt(16*log(sum(N_a)-1)*up.*(bottom.^(-1)));
[~, I] = max(obj);
i = randi(length(I), 1);
a = I(i);