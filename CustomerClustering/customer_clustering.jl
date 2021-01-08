# Run in interactive mode. Use 'julia -i customer_clustering.jl'.
using CSV
using DataFrames
using Clustering
using Plots


function load_data()
    dataset = CSV.read("Mall_Customers.csv", DataFrame)

    features = dataset[:, [4, 5]]
    rename!(features, "Annual Income (k\$)" => "Income")
    rename!(features, "Spending Score (1-100)" => "SpendingScore")

    return features
end

function elbow_method(data)
    features = transpose(convert(Array, data))
    scores = []
    for k in 1:10
        model = kmeans(features, k)
end

function cluster(data, k)
    features = transpose(convert(Array, data))
    result = kmeans(features, k).assignments
    return result
end

function plot_income(data, result)
    return scatter(
        data.Income,
        data.SpendingScore,
        marker_z = result,
        title = "Customer Clustering",
        xlabel = "Income",
        ylabel = "Spending Score",
        legend = false
    )
end


data = load_data()
result = cluster(data, 5)
plot = plot_income(data, result)
gui(plot)
