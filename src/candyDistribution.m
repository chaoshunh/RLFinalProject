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

Xi = zeros(line, 4);
Ind = zeros(c, n);

w = 0;
for c = 1:C	
	for n = 1:N
		w = w + 1;
		Ind(c,n) = w;
		Xi(w, 1) = HP(c,n, 1);
		Xi(w, 2) = HP(c,n, 2);
		if(HP(c,n,1)>0)
			Xi(w, 3) = length(find(HP(c, n:N,1))); % number of chidren behind
			Xi(w, 4) = length(find(HP(:, n,1))); % number of frontiers
		end
	end
end

for i = 1:size(Xi,2)
	Xi(:,i) = (Xi(:,i) - min(Xi(:,i)))/(max(Xi(:,i)) - min(Xi(:,i)));
end

% keyboard
display(Xi);

if(strcmp(link, 'kmeans'))
    [Cent, Xc] = kmeans(Xi, K, 'distance', dist, 'emptyaction', 'singleton');    
else
    Z = linkage(Xi, link, dist);
	% dendrogram(Z);
    Cent = cluster(Z, 'maxclust', K);
    % Xc = centroids(Xi, Cent, K);
end
% display(Cent);

for n = 1:N
	for c = 1:C
		w = Ind(c,n);
		if (w>=0)			
			X(c,n,1) = Cent(w);			
			r = Xi(w,1);
			t = Xi(w,2);
			pr = r + t;
			nr = -0.1*(r*t);
			X(c,n,2) = pr;
			X(c,n,3) = nr;
		else
			X(c,n,1) = -1;
			X(c,n,2) = 0;
			X(c,n,3) = 0;
		end
	end
end

% display(Cent);

function [r, t] = newChildren(C)
if(rand() < 0.5)
	r = 0;
	t = 0;
else
	r = randi(round(C/2))+randn();
	t = randi(C)+randn();	
end