function main()
close all
clear all

% epsilon_greedy(0.1, randomTest(5,1000,5),5);
softmax(0.1, randomTest(5,1000,5),5);
% reinforcementComparison(0.5, 10, randomTest(5,100,5),5);

function R = reinforcementComparison(alpha, beta, X, K)
Q = zeros(1,K);
N = size(X,2);
C = size(X,1);
R = zeros(1,N);
AR = zeros(1,N);
QR = zeros(N,K);
for t = 1:N
    A = X(:,t,1);
    
    pA = exp(1/tau*Q(A));
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
    Q(A(a)) = Q(A(a))*(1-alpha) + alpha*rew;
    AR(t) = A(a);
    R(t) = rew;
    QR(t,:) = Q;
end

an = 10;
ba = zeros(1,an);
dn = round(N/an);
for i = 1:an
    ba(i) = length(find(A((i-1)*dn+1:i*dn)==5))/dn;
end

figure
plot(ba)

figure
plot(R)

figure
plot(AR)

figure
plot(QR)

function R = softmax(tau, X, K)
Q = zeros(1,K);
N = size(X,2);
C = size(X,1);
R = zeros(1,N);
AR = zeros(1,N);
QR = zeros(N,K);
alpha = 0.1;
for t = 1:N
    A = X(:,t,1);
    
    pA = exp(1/tau*Q(A));
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

plotA(AR)
keyboard 

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

function plotA(A)

an = 20;
ba = zeros(1,an);
dn = floor(length(A)/an);
for i = 1:an
    ba(i) = length(find(A(((i-1)*dn+1):(i*dn))==5))/dn;
end


figure
plot(ba)
