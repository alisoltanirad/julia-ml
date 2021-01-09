using RDatasets
using MLJ
using DecisionTree
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

classifier = DecisionTreeClassifier()
DecisionTree.fit!(classifier, x[train, :], y[train])
pred = DecisionTree.predict(classifier, x[test, :])
accuracy = sum(pred .== y[test]) / k
