module AngleBetweenVectors

export angle

import Base: angle

import LinearAlgebra: norm, dot

"""
    angle(point1::T, point2::T) where {T}

Accurately ascertains the undirected angle (0 <= radians < pi)
between two points given in N-dimensional Cartesian coordinates..

If one of the points is at the origin, the result is zero.

You *must* define a tuple constructor `Tuple(x::T) = ...`.
"""
function angle(point1::NT, point2::NT) where {N,F<:AbstractFloat,NT<:NTuple{N,F}}
    unitvec1 = unitvec(point1)
    unitvec2 = unitvec(point2)
    
    y = unitvec1 .- unitvec2
    x = unitvec1 .+ unitvec2
          
    a = 2 * atan(norm(y) / norm(x))
   
    !signbit(a) && !(signbit(F(pi) - a)) ? a : (signbit(a) ? zero(F) : F(pi))
end

function angle(point1::NT, point2::NT) where {N,F<:Integer,NT<:NTuple{N,F}}
    unitvec1 = unitvec(point1)
    unitvec2 = unitvec(point2)
    
    y = unitvec1 .- unitvec2
    x = unitvec1 .+ unitvec2
          
    a = 2 * atan(norm(y) / norm(x))
   
    !signbit(a) && !(signbit(Float64(pi) - a)) ? a : (signbit(a) ? zero(F) : Float64(pi))
end

@inline angle(point1::T, point2::T) where {T} = angle(Tuple(point1), Tuple(point2))

@inline unitvec(p) = p ./ norm(p)

end # AngleBetweenVectors
