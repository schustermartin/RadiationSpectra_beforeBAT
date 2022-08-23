# This file is a part of RadiationSpectra.jl, licensed under the MIT License (MIT).

__precompile__(true)

module RadiationSpectra_beforeBAT

using DelimitedFiles
using LinearAlgebra
using Serialization
using Statistics

using ArraysOfArrays
using Distributions
using ForwardDiff
using IntervalSets
using LinearAlgebra
using LsqFit
using NLSolversBase
using Optim
using RecipesBase
using Requires
using SpecialFunctions
using StatsBase
using Tables
using TypedTables
using ValueShapes
using Random123

import Base: print, println, show
import Statistics: mean
import StatsBase: std, mean_and_std

export FitFunction
export get_ndims, get_nparams
export set_fitranges!
export set_parameter_names!
export set_initial_parameters!
export set_parameter_bounds!
export get_fitted_parameters
export get_initial_parameters
export get_standard_deviations

export llhfit!, lsqfit!, linear_regression!

export peakfinder
export calibrate_spectrum

export mean, std, mean_and_std

export fit_single_peak_histogram
export fit_single_peak_histogram_refined

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

include("Fitting/predefined_fit_routines.jl")

include("AutoCalibration/AutoCalibration.jl")


function __init__()
    @require BAT="c0cd4b16-88b7-57fa-983b-ab80aecada7e" include("Fitting/BAT/BAT.jl")
end

end # module
