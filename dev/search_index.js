var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = EconomicChoice","category":"page"},{"location":"#EconomicChoice","page":"Home","title":"EconomicChoice","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for EconomicChoice.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [EconomicChoice]","category":"page"},{"location":"#EconomicChoice.choice_summary-Tuple{AbstractVector{<:TwoJuiceTrial}}","page":"Home","title":"EconomicChoice.choice_summary","text":"choice_summary(trials)\n\nReturn a dictionary mapping each offer type to a MeanStd object containing the mean and standard deviation of the fraction of A choices for that offer.\n\n\n\n\n\n","category":"method"},{"location":"#EconomicChoice.regress_behavior-Tuple{Any, Any}","page":"Home","title":"EconomicChoice.regress_behavior","text":"regress_behavior(trials)\nregress_behavior(offerscalar, trials)\n\nFit a logistic regression model to the behavior of a subject. trials is a vector of TwoJuiceTrial objects.\n\nOptionally pass offerscalar to specify a function that computes the offer scalar (the independent variable) from the number of juice drops; the default is to use log(nB/nA).\n\n\n\n\n\n","category":"method"},{"location":"#EconomicChoice.regress_variable-Tuple{Any, Any, Any}","page":"Home","title":"EconomicChoice.regress_variable","text":"regress_variable(f, trials, responses)\n\nFit a linear regression model to neural responses. f is a function that computes the independent variable from the trials. trials is a vector of TwoJuiceTrial objects.\n\n\n\n\n\n","category":"method"}]
}
