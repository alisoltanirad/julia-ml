using CSV
using DataFrames
using Clustering


function load_data()
    dataset = CSV.read("Mall_Customers.csv", DataFrame)

    x = dataset[:, [3, 4]]
    rename!(x, "Annual Income (k\$)" => "Income")
    ismale = []
    for i in 1:size(dataset, 1)
        if dataset[i, :Genre] == "Male"
            push!(ismale, true)
        else
            push!(ismale, false)
        end
    end
    x."Is_Male" = ismale

    y = dataset."Spending Score (1-100)"

    return x, y
end

function cluster_income(x, y)
    features = convert(Array, DataFrame(X = x.Income, Y = y))
    result = kmeans(features, 2)

x, y = load_data()
