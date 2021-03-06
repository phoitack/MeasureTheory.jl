
# Laplace distribution

import StatsFuns
export Laplace

@measure Laplace(μ,σ) ≃ (1/2) * Lebesgue(ℝ)

function logdensity(d::Laplace{()} , x)
    return -abs(x)
end
 
sampletype(::Laplace) = Real

Base.rand(rng::AbstractRNG, μ::Laplace{()}) = rand(rng, Dists.Laplace())

≪(::Laplace, ::Lebesgue{X}) where X <: Real = true
representative(::Laplace) = Lebesgue(ℝ)

@μσ_methods Laplace()
