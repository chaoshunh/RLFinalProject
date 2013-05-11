function main()
close all
clear all

K = 5;
% X = randomTest(5,200,5);
X = candyDistribution(25,100,K, 'single', 'euclidean');

% epsilon_greedy(0.5, 0.1, X,5);
% softmax(0.1, randomTest(5,1000,5),5);
% reinforcementComparison(0.5, 10, randomTest(5,100,5),5);
% pursuit(-1, 0.5, X, K);
[R1, AR1, QR1] = ucb1(-1, X, K);
[R2, AR2, QR2] = ucb2(-1, X, K);
[R3, AR3, QR3] = epsilon_n_greedy(-1, 5, 0.5, X, 5);
[R4, AR4, QR4] = ucb1_normal(-1, X, K);
figure
plot(R1);
hold on
plot(R2,'k');
plot(R3,'g');
plot(R4,'r');

figure
plot(AR1);
hold on
plot(AR2,'k');
plot(AR3,'g');
plot(AR4,'r');

figure
plot(QR1);
hold on
plot(QR2);
plot(QR3);
plot(QR4);