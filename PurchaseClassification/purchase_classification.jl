# Run in interactive mode. Use 'julia -i customer_clustering.jl'.
using CSV
using DataFrames
using DecisionTree
using Plots
using ScikitLearn.CrossValidation: cross_val_score
using Statistics


function load_data()
    dataset = CSV.read("Social_Network_Ads.csv", DataFrame)

    x = dataset[:, [3, 4]]
    rename!(x, "EstimatedSalary" => "Salary")
    ismale = []
    for i in 1:size(dataset, 1)
        if dataset[i, :Gender] == "Male"
            push!(ismale, 1)
        else
            push!(ismale, 0)
        end
    end
    x."IsMale" = Int64.(ismale)

    y = dataset.Purchased

    return Array(x), y
end

function train_classifier(x, y)
    classifier = DecisionTreeClassifier()
    fit!(classifier, x, y)
    return classifier
end

x, y = load_data()
classifier = train_classifier(x, y)
prediction = predict(classifier, [24, 66500, 0])
accuracy = mean(cross_val_score(DecisionTreeClassifier(), x, y, cv = 10))
