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
function angle(point1::NT, point2::NT) where {N,F,NT<:NTuple{N,F}}
   unitvec1 = unitvec(point1)
   unitvec2 = unitvec(point2)
    
   y = norm(unitvec1 .- unitvec2)
   x = norm(unitvec1 .+ unitvec2)
          
   a = (2 * atan(y, x))
   
   zero(F) <= a <= (F<:Integer ? Float64(pi) : F(pi)) ? a : zero(F)
end

@inline angle(point1::T, point2::T) where {T} = angle(Tuple(point1), Tuple(point2))

@inline unitvec(p) = p ./ norm(p)

end # AngleBetweenVectors
