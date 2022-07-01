module AngleBetweenVectors

import Base: angle

@inline norm2(p::P) where {P<:Union{NTuple{N,T}, AbstractVector{T}}} where {N,T} =
    sqrt(foldl(+, abs2.(p)))

@inline unitize(p::P) where {P<:Union{NTuple{N,T}, AbstractVector{T}}} where {N,T} = 
    p ./ norm2(p)

"""
    angle(point1::T, point2::T) where {T}

Accurately ascertains the undirected angle (0 <= radians < pi)
between two points given in N-dimensional Cartesian coordinates.

Prefer this to `acos` alternatives
- more reliably accurate
- more consistently stable

Suggested when any |coordinate| of either point may be outside 2^±20 or [1/1_000_000, 1_000_000].
Strongly recommended when any |coordinate| is outside 2^±24 or [1/16_000_000, 16_000_000].

If one of the points is at the origin, the result is zero.

You *must* define a tuple constructor `Tuple(x::YourPointType) = ...` if one does not already exist.
"""
function angle(point1::P, point2::P) where {P<:Union{NTuple{N,T}, AbstractVector{T}}} where {N,T}
    unitpoint1 = unitize(point1)
    unitpoint2 = unitize(point2)

    y = unitpoint1 .- unitpoint2
    x = unitpoint1 .+ unitpoint2

    a = 2 * atan(norm2(y), norm2(x))

    !(signbit(a) || signbit(float(T)(pi) - a)) ? a : (signbit(a) ? zero(T) : float(T)(pi))
end

angle(point1::T, point2::T) where {T} = angle(Tuple(point1), Tuple(point2))

end # AngleBetweenVectors
