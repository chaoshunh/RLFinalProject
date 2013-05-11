function X = candyDistribution(C, N, K, link, dist)
% 2 ways, by N steps, by a tuple with 3 entries
% the tuple = (cluster index, pr, nr), where pr is the reward returned if
% it is chosen, otherwise nr is returned


HP = zeros(C,N,2);
TP = zeros(C,N,2);
PP = zeros(C,N,3);

% Constraint-r: number of candies a children want
% Constraint-t: timestep the children is willing to wait
% Objective: Minimize number of children waiting

line = 0;
for n = 1:N
	for c = 1:C
		[r, t] = newChildren(C);
		if(r>0)
			line = line + 1;
		end
		c = randi(C); % the child came in at a random channel
		HP(c, n, 1) = r;
		HP(c, n, 2) = t;
	end		
end

Xi = zeros(line, 2);
Ind = zeros(line, 2);

w = 0;
for n = 1:N
	for c = 1:C
		w = w + 1;
		Ind(w,:) = [n, c];
		Xi(w, 1) = HP(c,n, 1);
		Xi(w, 2) = HP(c,n, 2);
	end
end

% keyboard
display(Xi);

if(strcmp(link, 'kmeans'))
    [Cent, Xc] = kmeans(Xi, K, 'distance', dist, 'emptyaction', 'singleton');    
else
    Z = linkage(Xi, link, dist);
	% dendrogram(Z);
    Cent = cluster(Z, 'maxclust', 10);
    % Xc = centroids(Xi, Cent, K);
end
% display(Cent);

for n = 1:N
	for c = 1:C
		X(c,n,1) = cluster;
		X(c,n,2) = pr;
		X(c,n,3) = nr;

	end
end
scatter(Xi(:,1), Xi(:,2))

% X = PP; 

function [r, t] = newChildren(C)
if(rand() < 0.5)
	r = 0;
	t = 0;
else
	r = randi(round(C/2));
	t = randi(C);	
end