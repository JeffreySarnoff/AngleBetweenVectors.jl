module AngleBetweenVectors

export angle, PointRepr

import Base: angle

import LinearAlgebra.norm

"""
    PointRepr{N, R<:Real}

Generate a `Union` of Point representations.

Exported for expansion of representations covered.

PointRepr{N, R} = Union{ NTuple{N, R}, AbstractArray{R, 1},
                         <your point representation types> }
"""
PointRepr{N, R} = Union{NTuple{N, R}, AbstractArray{R, 1}}

"""
    angle( apoint::T, bpoint::T) where {N, R, T<:PointRepr{N,R}}

Accurately ascertains the undirected angle (0 <= radians < pi)
between two points given in Cartesian coordinates.

The angle is taken in the plane that contains both `apoint` and `bpoint`.

If one of the points is at the origin, the result is undefined.
"""
function Base.angle(point1::T, point2::T) where {N, R, T<:PointRepresentation{N, R}}
   rescaled_point1 = point1 .* norm(point2)
   rescaled_point2 = point2 .* norm(point1)
    
   normalized_abcissa  = norm(rescaled_point2 .+ rescaled_point1)
   normalized_ordinate = norm(rescaled_point2 .- rescaled_point1)
   
   return 2 * atan(normalized_ordinate / normalized_abcissa)
end
