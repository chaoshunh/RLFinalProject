function main()

epsilon_greedy(randomTest(2,10,5),5);

function R = epsilon_greedy(X, K)
Q = zeros(1,K);
for t = 1:size(X,2)
    A = X(:,t,1);
    a = greedy(Q,A);
end

function a = greedy(Q,A)
a = A(max(Q(A)));