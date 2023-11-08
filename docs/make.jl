using EconomicChoice
using Documenter

DocMeta.setdocmeta!(EconomicChoice, :DocTestSetup, :(using EconomicChoice); recursive=true)

makedocs(;
    modules=[EconomicChoice],
    authors="Tim Holy <tim.holy@gmail.com> and contributors",
    repo="https://github.com/HolyLab/EconomicChoice.jl/blob/{commit}{path}#{line}",
    sitename="EconomicChoice.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://HolyLab.github.io/EconomicChoice.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/HolyLab/EconomicChoice.jl",
    devbranch="main",
)
