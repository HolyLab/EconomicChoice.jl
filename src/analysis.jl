"""
    regress_variable(f, trials, responses)

Fit a linear regression model to neural `responses`. `f` is a function that computes the independent variable
from the trials. `trials` is a vector of `TwoJuiceTrial` objects.
"""
function regress_variable(f, trials, responses)
    x = f.(trials)
    y = scalar_response.(responses)
    lm([ones(eachindex(x)) x], y)
end

"""
    regress_behavior(trials)
    regress_behavior(offerscalar, trials)

Fit a logistic regression model to the behavior of a subject.
`trials` is a vector of `TwoJuiceTrial` objects.

Optionally pass `offerscalar` to specify a function that computes the offer scalar (the independent variable)
from the number of juice drops; the default is to use `log(nB/nA)`.
"""
function regress_behavior(offerscalar, trials)
    # See Eq. 1 in Zhang et al 2024
    offer_scalar = [offerscalar(t.nA, t.nB) for t in trials]
    side = [2*isAright(t) - 1 for t in trials]
    choseA = [t.choseA for t in trials]
    keep = isfinite.(offer_scalar)
    df = DataFrame(offer_scalar=offer_scalar[keep], side=side[keep], choseA=choseA[keep])
    glm(@formula(choseA ~ offer_scalar + side), df, Binomial(), LogitLink())
end
regress_behavior(trials) = regress_behavior((a, b) -> log(b/a), trials)
