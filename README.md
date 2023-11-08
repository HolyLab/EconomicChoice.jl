# EconomicChoice

[![Build Status](https://github.com/HolyLab/EconomicChoice.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/HolyLab/EconomicChoice.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/HolyLab/EconomicChoice.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/HolyLab/EconomicChoice.jl)

This package provides routines for analyzing experiments in [behavioral neuroeconomics](https://www.nature.com/articles/nature04676). Below are some demos of what you can do with a standard two-juice offer structure:

```julia
# Make offers that vary in the number nA of drops of juice A, nB for juice B, and the side on which A is presented
julia> offers = [TwoJuiceOffer(nA, nB, isAright) for nA in 0:3, nB in 0:3, isAright in (true, false)];

# Simulate choice experiments: 8 trials per offer type, animal exhibits logistic choice with no offset but a side bias of 0.1
julia> trials = buildtrials(offers, 0, 2, 0.1; n=8);

# Run a logistic regression
julia> rr = regress_behavior(trials)
StatsModels.TableRegressionModel{GLM.GeneralizedLinearModel{GLM.GlmResp{Vector{Float64}, Distributions.Binomial{Float64}, GLM.LogitLink}, GLM.DensePredChol{Float64, LinearAlgebra.CholeskyPivoted{Float64, Matrix{Float64}, Vector{Int64}}}}, Matrix{Float64}}

choseA ~ 1 + offer_scalar + side

Coefficients:
─────────────────────────────────────────────────────────────────────────
                 Coef.  Std. Error     z  Pr(>|z|)   Lower 95%  Upper 95%
─────────────────────────────────────────────────────────────────────────
(Intercept)   0.112168    0.193592  0.58    0.5623  -0.267265    0.4916
offer_scalar  1.91566     0.369486  5.18    <1e-06   1.19148     2.63984
side          0.4062      0.196021  2.07    0.0382   0.0220064   0.790393
─────────────────────────────────────────────────────────────────────────
```

You can see that the model input parameters are within the confidence intervals of the regression.

The package offers more features as well, e.g., for regressing neuronal responses against trial variables.
See the package code and tests for details.
