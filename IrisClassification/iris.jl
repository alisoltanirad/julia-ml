using RDatasets
using MLJ
using StatsBase
using Random


iris = dataset("datasets", "iris")
y, x = unpack(iris, ==(:Species), colname -> true)
x = Array(x)
labels = unique(y)
n_samples, n_features = size(x)

split_size = 0.1
k = floor(Int, split_size * n_samples)
indexes = randperm(n_samples)
train = indexes[k:end]
test = indexes[1:k]

classifier = GaussianNB(labels, n_features)
fit(classifier, x[train, :], y[train])
