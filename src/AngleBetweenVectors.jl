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
    angle( apoint, bpoint)

accurately ascertains the undirected angle between to vectorial points
"""
function Base.angle(point1::T, point2::T) where {N, R, T<:PointRepresentation{N, R}}
   rescaled_point1 = point1 .* norm(point2)
   rescaled_point2 = point2 .* norm(point1)

   x = norm(rescaled_point2 .+ rescaled_point1)
   y = norm(rescaled_point2 .- rescaled_point1)
   
   return 2 * atan(y / x)
end
