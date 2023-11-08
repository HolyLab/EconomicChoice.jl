module EconomicChoice

using GLM
using StatsBase
using DataFrames

export TwoJuiceOffer, TwoJuiceTrial, offer_value, chosen_value, chose_right, isAright, offer_valueA, offer_valueB
export choiceB, buildtrials
export MeanStd, choice_summary
export regress_variable, regress_behavior

include("trials.jl")
include("analysis.jl")

end
