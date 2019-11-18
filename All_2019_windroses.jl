# Load input files
# .data file with space as delimiter, repeated (sometime many spaces between elements), no header

Input_fn = readdir("Input\\Raw data")
# Load file which contain columns names
using CSV
data2 = CSV.read("Input\\Oct_2019.csv");
col_name = names(data2)
# Save columns names
using DataFrames
Default_name = Symbol.(:Column, 1:24)

for j = 1:length(Input_fn)
    cd("C:\\Users\\arenchon\\Box Sync\\Heterogeneity project\\Julia language\\Met data 484\\Windroses\\Input\\Raw data")
    data = CSV.read(Input_fn[j], delim=' ',header=0,ignorerepeated=true)
    cd("C:\\Users\\arenchon\\Box Sync\\Heterogeneity project\\Julia language\\Met data 484\\Windroses")

    # Delete the last two rows (to fix a problem in raw input files)
    n = size(data,1)
    data = data[setdiff(1:end, [n-1,n]), :]
    n = size(data,1)

    # Rename the columns
    rename!(data, f => t for (f, t) = zip(Default_name, col_name))

    # Plot the windrose

    # How many bar in the figure?
    nbar = 8
    # Freq will contain occurence (% of the time) of WD within a bin (ex. between 0 and 45)
    Freq = Array{Float64}(undef, nbar)
    # Create an array of nbar elements
    WD_bins = Vector(1:nbar)

    # Create an array of bins in degrees
    WD_bins_d = Vector(360/nbar/2:360/nbar:360-360/nbar/2)

    # Calculate freq for each wind direction bin
    Freq[1] = length(findall(x -> x < WD_bins_d[1] || x > WD_bins_d[nbar], data.WD10))/n*100;
    for i = 2:nbar
        Freq[i] = length(findall(x -> WD_bins_d[i-1] < x < WD_bins_d[i], data.WD10))/n*100;
    end

    # Plotting the windrose
    using PyPlot
    ioff() # Interactive plotting OFF, necessary for inline plotting in IJulia
    theta = collect(0:2pi/nbar:2pi-2pi/nbar)
    r = Freq;
    width = 2pi/length(theta); # Desired width of each bar in the bar plot
    fig = figure("pyplot_windrose_barplot",figsize=(10,10)) # Create a new figure
    ax = PyPlot.axes(polar="true") # Create a polar axis
    PyPlot.title("Wind Rose - Bar")
    b = bar(theta,r,width=width) # Bar plot
    dtheta = 10
    ax.set_thetagrids(collect(0:dtheta:360-dtheta)) # Show grid lines from 0 to 360 in increments of dtheta
    ax.set_theta_zero_location("N") # Set 0 degrees to the top of the plot
    ax.set_theta_direction(-1) # Switch to clockwise
    fig.canvas.draw() # Update the figure
    gcf() # Needed for IJulia to plot inline

    # Save plot in Output directory
    cd("C:\\Users\\arenchon\\Box Sync\\Heterogeneity project\\Julia language\\Met data 484\\Windroses\\Output")
    Output_n = ["Apr19","Aug19","Feb19","Jan19","Jul19","Jun19","Mar19","May19","Oct19","Sep19"]
    savefig(Output_n[j])
    cd("C:\\Users\\arenchon\\Box Sync\\Heterogeneity project\\Julia language\\Met data 484\\Windroses")
    data = nothing
    fig.clear()
end
