# Run in interactive mode. Use 'julia -i customer_clustering.jl'.
using CSV
using DataFrames
using Clustering
using Plots


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
    features = transpose(convert(Array, DataFrame(X = x.Income, Y = y)))
    return kmeans(features, 5).assignments
end

function plot_income(x, y, result)
    return scatter(
        x.Income,
        y,
        marker_z = result,
        title = "Customer Clustering",
        xlabel = "Income",
        ylabel = "Spending Score",
        legend = false
    )
end


x, y = load_data()
result = cluster_income(x, y)
plot = plot_income(x, y, result)
gui(plot)
