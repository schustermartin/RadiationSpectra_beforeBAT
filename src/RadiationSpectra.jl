# This file is a part of RadiationSpectra.jl, licensed under the MIT License (MIT).

__precompile__(true)

module RadiationSpectra

using DelimitedFiles
using LinearAlgebra
using Statistics

using Distributions
using IntervalSets
using Optim
using RecipesBase
using Requires
using StatsBase

import Base: print, println, show
import Statistics: mean
import StatsBase: std, mean_and_std

export FitFunction
export get_ndims, get_nparams
export set_fitranges!
export set_parameter_names!
export set_initial_parameters!
export get_fitted_parameters
export get_initial_parameters

export llhfit!, lsqfit!

export peakfinder
export calibrate_spectrum

export mean, std, mean_and_std


"""
    get_example_spectrum()::Histogram

Returns an uncalibrated radiation spectrum for testing and demonstrating purpose.
"""
function get_example_spectrum()::Histogram
    weights::Array{Int, 1} = readdlm(joinpath(@__DIR__, "..", "examples", "data", "hpge-spectrum.txt"))[:]
    h = Histogram(0:100:100 * length(weights), :left)
    h.weights = weights
    return h
end

include("Statistics/Statistics.jl")

include("PeakFinder/PeakFinder.jl")

include("Fitting/FitFunction.jl")
include("Fitting/general_model_functions.jl")

include("Fitting/llhfit.jl")

include("Fitting/lsqfit.jl")

include("AutoCalibration/AutoCalibration.jl")

using BAT
include("Fitting/BAT/BAT.jl")
function __init__()
    # @require BAT="c0cd4b16-88b7-57fa-983b-ab80aecada7e" include("Fitting/BAT/BAT.jl")
    println("RadiationSpectra.jl: Hello $(ENV["USERNAME"])")
end

end # module
