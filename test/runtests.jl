using EconomicChoice
using StatsBase
using Test

@testset "EconomicChoice.jl" begin
    @testset "Basics" begin
        t1 = TwoJuiceTrial(1, 2, true, true)
        t2 = TwoJuiceTrial(1, 2, true, false)
        t3 = TwoJuiceTrial(1, 2, false, true)
        t4 = TwoJuiceTrial(1, 2, false, false)
        @test offer_valueA(t1) == offer_valueA(t2) == offer_valueA(t3) == offer_valueA(t4) == 1
        @test offer_valueB(t1) == offer_valueB(t2) == offer_valueB(t3) == offer_valueB(t4) == 2
        @test chosen_value(t1) == chosen_value(t3) == 1
        @test chosen_value(t2) == chosen_value(t4) == 2
        @test chose_right(t1) == chose_right(t4) == true
        @test chose_right(t2) == chose_right(t3) == false
        @test isAright(t1) == isAright(t2) == true
        @test isAright(t3) == isAright(t4) == false

        s = choice_summary([t1, t2, t3, t4])
        @test s[TwoJuiceOffer(1, 2, true)] == s[TwoJuiceOffer(1, 2, false)] == MeanStd([true, false])
    end

    @testset "regress_behavior" begin
        offers = [TwoJuiceOffer(nA, nB, isAright) for nA in 0:3, nB in 0:3, isAright in (true, false)];
        trials = buildtrials(offers, 0, 1, 0);
        rr = regress_behavior(trials)
        ci = confint(rr; level=0.99)
        @test ci[1,1] < 0 < ci[1,2]
        @test ci[2,1] < 1 < ci[2,2]
        @test ci[3,1] < 0 < ci[3,2]

        trials = buildtrials(offers, 0.25, 2, 0);
        rr = regress_behavior(trials)
        ci = confint(rr; level=0.99)
        @test ci[1,1] < 0.25 < ci[1,2]
        @test ci[2,1] < 2 < ci[2,2]
        @test ci[3,1] < 0 < ci[3,2]

        trials = buildtrials(offers, -0.25, 0, 1);
        rr = regress_behavior(trials)
        ci = confint(rr; level=0.99)
        @test ci[1,1] < -0.25 < ci[1,2]
        @test ci[2,1] < 0 < ci[2,2]
        @test ci[3,1] < 1 < ci[3,2]
    end

    @testset "regress_variable" begin
        offers = [TwoJuiceOffer(nA, nB, isAright) for nA in 0:3, nB in 0:3, isAright in (true, false)];
        trials = buildtrials(offers, 0, 2, 0);

        rr = regress_variable(offer_valueA, trials, 2.5 * offer_valueA.(trials))
        @test only(coef(rr)) ≈ 2.5
        rr = regress_variable(offer_valueB, trials, 1.5 * offer_valueB.(trials))
        @test only(coef(rr)) ≈ 1.5
        rr = regress_variable(chosen_value, trials, 1.2 * chosen_value.(trials))
        @test only(coef(rr)) ≈ 1.2
        rr = regress_variable(isAright, trials, 0.8 * isAright.(trials))
        @test only(coef(rr)) ≈ 0.8
    end
end
