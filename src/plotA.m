function plotA(A)

an = 20;
ba = zeros(1,an);
dn = floor(length(A)/an);
for i = 1:an
    ba(i) = length(find(A(((i-1)*dn+1):(i*dn))==5))/dn;
end


figure
plot(ba)
