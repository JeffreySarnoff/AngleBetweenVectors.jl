module AngleBetweenVectors

export angle, fastangle

import Base: angle

import LinearAlgebra: norm, dot

const PI = Float64(pi)


"""
    angle(point1::T, point2::T) where {T}

Accurately ascertains the undirected angle (0 <= radians < pi)
between two points given in N-dimensional Cartesian coordinates.

Prefer this to `fastangle` for highest accuracy.  Suggested
when |coordinates| may be outside 2^±20 or [1/1_000_000,1_000_000].
Strongly recommended when any |coordinates| are outside 2^±24 or
[1/16_000_000,16_000_000].

If one of the points is at the origin, the result is zero.

You *must* define a tuple constructor `Tuple(x::T) = ...`.
"""
function angle(point1::NT, point2::NT) where {N,T,NT<:NTuple{N,T}}
    unitvec1 = unitvec(point1)
    unitvec2 = unitvec(point2)
    
    y = unitvec1 .- unitvec2
    x = unitvec1 .+ unitvec2
          
    a = 2 * atan(norm(y) / norm(x))
   
    !signbit(a) && !(signbit(PI - a)) ? a : (signbit(a) ? zero(F) : PI)
end


"""
    fastangle(point1::T, point2::T) where {T}

Accurately ascertains the undirected angle (0 <= radians < pi)
between two points given in N-dimensional Cartesian coordinates.

Prefer this to `angle` for highest performance. Works best
where all |coordinates| are in 2^±12 or [1/4_000,4_000].
Use `angle` where |coordinates| may be outside 2^±20 or
[1/1_000_000,1_000_000]. 

If one of the points is at the origin, the result is zero.

You *must* define a tuple constructor `Tuple(x::T) = ...`.
"""
function fastangle(point1::NT, point2::NT) where {N,T,NT<:NTuple{N,T}}
    point1a = point1 .* norm(point2)
    point2a = point2 .* norm(point1)
    
    subpoints = point1a .- point2a
    subpoints = dot(subpoints, subpoints)
    addpoints = point1a .+ point2a
    addpoints = dot(addpoints, addpoints)
    
    2 * atan(sqrt(subpoints ./ addpoints))
end

@inline angle(point1::T, point2::T) where {T} = angle(Tuple(point1), Tuple(point2))
@inline fastangle(point1::T, point2::T) where {T} = fastangle(Tuple(point1), Tuple(point2))

@inline unitvec(p) = p ./ norm(p)

end # AngleBetweenVectors
