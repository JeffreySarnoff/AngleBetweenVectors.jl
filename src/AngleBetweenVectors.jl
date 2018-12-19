module AngleBetweenVectors

import Base: angle

import LinearAlgebra: norm


@inline unitvec(p) = p ./ norm(p)

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

You *must* define a tuple constructor `Tuple(x::T) = ...` if one does not already exist.
"""
function angle(point1::NT, point2::NT) where {N,T,NT<:NTuple{N,T}}
    unitvec1 = unitvec(point1)
    unitvec2 = unitvec(point2)

    y = unitvec1 .- unitvec2
    x = unitvec1 .+ unitvec2

    a = 2 * atan(norm(y) / norm(x))

    !(signbit(a) || signbit(T(pi) - a)) ? a : (signbit(a) ? zero(T) : T(pi))
end

@inline angle(point1::V, point2::V) where {T, V<:Vector{T}} = angle(Tuple(point1), Tuple(point2))
@inline angle(point1::T, point2::T) where {T} = angle(Tuple(point1), Tuple(point2))

end # AngleBetweenVectors
