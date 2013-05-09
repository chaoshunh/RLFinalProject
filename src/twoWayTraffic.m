function X = twoWayTraffic(N, K)

% 2 ways, by N steps, by a tuple with 3 entries
% the tuple = (cluster index, pr, nr), where pr is the reward returned if
% it is chosen, otherwise nr is returned

X = zeros(2,N,3); 

