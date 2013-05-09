function main()
close all
clear all

% epsilon_greedy(0.1, randomTest(5,1000,5),5);

softmax(10, randomTest(5,1000,5),5);

function R = softmax(tau, X, K)
Q = zeros(1,K);
N = size(X,2);
C = size(X,1);
R = zeros(1,N);
AR = zeros(1,N);
QR = zeros(N,K);

for t = 1:N
    A = X(:,t,1);
    keyboard
    pA = exp(1/tau*Q(A));
    pA = 1/sum(pA)*pA;
    
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

function R = epsilon_greedy(epsilon, X, K)
Q = zeros(1,K);
N = size(X,2);
C = size(X,1);
R = zeros(1,N);
AR = zeros(1,N);
QR = zeros(N,K);
alpha = 0.5;    
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


function a = greedy(Q,A)
[~,I] = max(Q(A));
i = randi(length(I),1);
a = I(i);