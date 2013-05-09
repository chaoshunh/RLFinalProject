function main()
close all
clear all

X = randomTest(5,100,5);
K = 5;
% epsilon_greedy(0.5, 0.1, X,5);
% softmax(0.1, randomTest(5,1000,5),5);
% reinforcementComparison(0.5, 10, randomTest(5,100,5),5);
% pursuit(-1, 0.5, X, K);
ucb1(-1, X, K);