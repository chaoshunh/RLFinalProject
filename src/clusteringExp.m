function clusteringExp()
links = {'single', 'complete', 'average', 'weighted'};
dists = {'euclidean', 'cityblock', 'chebychev', 'cosine', 'correlation', 'jaccard'};
K = 10;

figure
for l = 1:length(links)	
	X = candyDistribution(25,200,K, links{1,l}, 'euclidean');
	subplot(2,2,l);
	hist(X(:,:,1));
	title(links{1,l});
end

figure
for d = 1:length(dists)	
	X = candyDistribution(25,200,K, 'single', dists{1,d});
	subplot(2,3,d);
	hist(X(:,:,1));
	title(dists{1,d});
end

figure
kdists = {'sqEuclidean', 'cityblock', 'cosine', 'correlation'};
for d = 1:length(kdists)	
	X = candyDistribution(25,200,K, 'kmeans', kdists{1,d});
	subplot(2,2,d);
	hist(X(:,:,1));
	title(kdists{1,d});
end