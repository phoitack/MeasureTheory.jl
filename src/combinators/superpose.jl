export SuperpositionMeasure

"""
    struct SuperpositionMeasure{X,NT} <: AbstractMeasure
        components :: NT
    end

Superposition of measures is analogous to mixture distributions, but (because
measures need not be normalized) requires no scaling.

The superposition of two measures μ and ν can be more concisely written as μ + ν.
"""
struct SuperpositionMeasure{X,NT} <: AbstractMeasure
    components :: NT   
end

SuperpositionMeasure(ms :: AbstractMeasure...) where {X} = SuperpositionMeasure{X,length(ms)}(ms)

# SuperpositionMeasure(m::NTuple{N, Measure{X}}) where {N,X} = SuperpositionMeasure(m...)

# Base.length(::SuperpositionMeasure{X,N}) where {X,N} = N

function Base.:+(μ::SuperpositionMeasure{X,N1}, ν::SuperpositionMeasure{X,N2}) where {X,N1,N2}
    components = (μ.components..., ν.components...)
    SuperpositionMeasure{X, N1+N2}(components)
end

function Base.:+(μ::AbstractMeasure, ν::SuperpositionMeasure{X,N}) where {X,N}
    components = (μ, ν.components...)
    SuperpositionMeasure{X,N+1}(components)
end

function Base.:+(μ::SuperpositionMeasure{X,N}, ν::AbstractMeasure) where {X,N}
    components = (μ.components..., ν)
    SuperpositionMeasure{X,N+1}(components)
end

function Base.:+(μ::AbstractMeasure, ν::AbstractMeasure) where {X}
    components = (μ, ν)
    SuperpositionMeasure{X,2}(components)
end

# TODO: Fix `rand` method (this one is wrong)
# function Base.rand(μ::SuperpositionMeasure{X,N}) where {X,N}
#     return rand(rand(μ.components))
# end
