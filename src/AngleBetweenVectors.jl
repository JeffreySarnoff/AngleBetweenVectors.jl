module AngleBetweenVectors

import Base: angle

import LinearAlgebra: norm

Floats = Union{AbstractFloat, Complex{T} where T<:AbstractFloat}

@inline unitize(p) = p ./ norm(p)

"""
    angle(point1::T, point2::T) where {T}

Accurately ascertains the undirected angle (0 <= radians < pi)
between two points given in N-dimensional Cartesian coordinates.

Prefer this to `acos` alternatives
- more reliably accurate
- more consistently stable

Suggested when any |coordinate| of either point may be outside 2^±20 or [1/1_000_000, 1_000_000].
Strongly recommended when any |coordinate| is outside 2^±24 or [1/16_000_000, 16_000_000].

If either of the points is at the origin, the result is `NaN` because angle is undefined in that case.

You *must* define a tuple constructor `Tuple(x::YourPointType) = ...` if one does not already exist.
"""
angle(tuple1::NTuple{N,T}, tuple2::NTuple{N,T}) where {N, T<:Floats} = angle(real(T), tuple1, tuple2)

# because of the broadcasts .- and .+ below, it is essential to check size compatibility
# for arrays, whereas for tuples the consistency ensured by the "N" in the type
function angle(a1::AbstractArray{T}, a2::AbstractArray{T}) where {T<:Floats}
	size(a1) == size(a2) || throw(DimensionMismatch())
    return angle(real(T), a1, a2)
end

function angle(::Type{T}, point1, point2) where {T<:AbstractFloat}
    unitpoint1 = unitize(point1)
    unitpoint2 = unitize(point2)

    y = unitpoint1 .- unitpoint2
    x = unitpoint1 .+ unitpoint2

    a = 2 * atan(norm(y) / norm(x))

    !(signbit(a) || signbit(T(pi) - a)) ? a : (signbit(a) ? zero(T) : T(pi))
end

# this method allows the arrays to have different types, even non-float types
function angle(a1::AbstractArray{T1}, a2::AbstractArray{T2}) where {T1 <: Number, T2 <: Number}
    T = float(promote_type(T1, T2)) # the "T" for T(pi) must be a float type
    return angle(convert(AbstractArray{T}, a1), convert(AbstractArray{T}, a2))
end

@inline angle(point1::T, point2::T) where {T} = angle(Tuple(point1), Tuple(point2))

end # AngleBetweenVectors
