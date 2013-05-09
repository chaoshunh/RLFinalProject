function a = greedy(Q,A)
[~,I] = max(Q(A));
i = randi(length(I),1);
a = I(i);
