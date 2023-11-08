abstract type AbstractOffer end
abstract type AbstractTrial end

struct TwoJuiceOffer <: AbstractOffer
    nA::Int
    nB::Int
    isAright::Bool
end

struct TwoJuiceTrial <: AbstractTrial
    offer::TwoJuiceOffer
    choseA::Bool
end
TwoJuiceTrial(nA, nB, isAright, choseA) = TwoJuiceTrial(TwoJuiceOffer(nA, nB, isAright), choseA)

struct MeanStd
    mean::Float64
    std::Float64
end
MeanStd(x::AbstractVector) = MeanStd(mean(x), std(x))

# "Forward" the fields of TwoJuiceOffer to TwoJuiceTrial
Base.getproperty(t::TwoJuiceTrial, name::Symbol) =
    name === :choseA ? getfield(t, name) :
    name === :offer ? getfield(t, name) : getproperty(t.offer, name)

offer_value(t::Union{TwoJuiceTrial,TwoJuiceOffer}, isA::Bool) = isA ? t.nA : t.nB
chosen_value(t::TwoJuiceTrial) = t.choseA ? t.nA : t.nB
chose_right(t::TwoJuiceTrial) = t.isAright ⊻ !t.choseA
isAright(t::Union{TwoJuiceTrial,TwoJuiceOffer}) = t.isAright

offer_valueA(t::Union{TwoJuiceTrial,TwoJuiceOffer}) = offer_value(t, true)
offer_valueB(t::Union{TwoJuiceTrial,TwoJuiceOffer}) = offer_value(t, false)

scalar_response(response::AbstractVector) = maximum(abs, response)
scalar_response(r::Real) = r


function choiceB(offer, a₀, a₁, a₂)
    # Eq 1 of Zhang et al 2024
    X = a₀ + a₁ * log(offer.nB / offer.nA) + a₂ * (2*isAright(offer) - 1)
    return 1 / (1 + exp(-X))
end

function buildtrials(f::Base.Callable, offers, params...; n=100)
    trials = TwoJuiceTrial[]
    for offer in offers
        for _ in 1:n
            choseA = rand() < f(offer, params...)
            push!(trials, TwoJuiceTrial(offer, choseA))
        end
    end
    return trials
end
buildtrials(offers, params...; kwargs...) = buildtrials(choiceB, offers, params...; kwargs...)

"""
    choice_summary(trials)

Return a dictionary mapping each offer type to a `MeanStd` object containing the mean and standard deviation
of the fraction of A choices for that offer.
"""
function choice_summary(trials::AbstractVector{<:TwoJuiceTrial})
    offer_choice = Dict{TwoJuiceOffer, Vector{Bool}}()
    for t in trials
        l = get!(Vector{Bool}, offer_choice, t.offer)
        push!(l, t.choseA)
    end
    return Dict(o => MeanStd(l) for (o, l) in offer_choice)
end
