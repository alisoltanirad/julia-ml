# Run in interactive mode. Use 'julia -i customer_clustering.jl'.
using CSV
using DataFrames
using Plots


function load_data()
    dataset = CSV.read("Social_Network_Ads.csv", DataFrame)

    x = dataset[:, [3, 4]]
    rename!(x, "EstimatedSalary" => "Salary")
    ismale = []
    for i in 1:size(dataset, 1)
        if dataset[i, :Gender] == "Male"
            push!(ismale, true)
        else
            push!(ismale, false)
        end
    end
    x."Is_Male" = ismale

    y = dataset.Purchased

    return x, y
end


x, y = load_data()
