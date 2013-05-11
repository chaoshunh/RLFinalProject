function X = randomTest(C, N, K)

% 2 ways, by N steps, by a tuple with 3 entries
% the tuple = (cluster index, pr, nr), where pr is the reward returned if
% it is chosen, otherwise nr is returned

X = zeros(C,N,3); 

for n = 1:N    
    for c = 1:C
        i = ceil(K*rand());
        pr = i + 0.01*randn();
        nr = -pr/C;
        X(c,n,1) = i;
        X(c,n,2) = pr;
        X(c,n,3) = nr;
    end
end