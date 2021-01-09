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

function elbow_method(data, range)
    features = transpose(convert(Array, data))
    scores = []
    for k in range
        model = kmeans(features, k)
    end
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

function plot_elbow_method_result(eb_range, result)
    return plot(
        eb_range,
        eb_result,
        title = "Elbow Method",
        xlabel = "K",
        legend = false
    )


data = load_data()
eb_range = [i for i in 1:10]
eb_result = elbow_method(data, eb_range)
result = cluster(data, 5)
income_plot = plot_income(data, result)
eb_plot = plot_elbow_method_result(eb_range, eb_result)
gui(eb_plot)
