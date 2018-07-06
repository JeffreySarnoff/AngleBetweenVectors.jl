module AngleBetweenVectors

export angle, norm,
       PointRepresentation,


import Base: angle

import LinearAlgebra.norm


# basic collection of types that may be used to represent points
const InitialPointReprs =
     Union{ NTuple{2, Float32}, NTuple{3, Float32}, NTuple{4, Float32},
            NTuple{2, Float64}, NTuple{3, Float64}, NTuple{4, Float64},
            AbstractArray{Float32, 1}, AbstractArray{Float64, 1} }

TypesForPoints = InitialPointReprs

"""
    PointRepresentation{types_representing_points...}

Generate a `Union` of Point representations.

Interoperable expansion of internal point representations.

PointRepresention( <your point representation types> }

```
using AngleBetweenPoints

struct Point2D{T}
    x::T
    y::T
end

#  always specialize these two functions
#  `norm(pt::YourStruct)`, `Tuple(pt::YourStruct)`

norm(pt::Point2D{T}) where {T} = sqrt(pt.x^2 + pt.y^2)

Tuple(pt::Point2D{T}) where {T} = (pt.x, pt.y)

PointRepresentation(Point2D{Float32}, Point2D{Float64})

point1 = Point2D(0.0, 1.0)
point2 = Point2D(1.0, 0.5)

angle_between = angle(point1, point2)

"""
function PointRepresentation(point_types...)
    global TypesForPoints
    added_point_types = Union{point_types...,}
    TypesForPoints = Union{TypesForPoints, added_point_types}
    nothing
end

"""
    angle( apoint::T, bpoint::T) where {N, R, T<:PointRepr{N,R}}

Accurately ascertains the undirected angle (0 <= radians < pi)
between two points given in Cartesian coordinates.

The angle is taken in the plane that contains both `apoint` and `bpoint`.

If one of the points is at the origin, the result is undefined.
"""
function Base.angle(point1::T, point2::T) where {N,R,T<:NTuple{N,R}}
   rescaled_point1 = point1 .* norm(point2)
   rescaled_point2 = point2 .* norm(point1)
    
   normalized_abcissa  = norm(rescaled_point2 .+ rescaled_point1)
   normalized_ordinate = norm(rescaled_point2 .- rescaled_point1)
   
   return 2 * atan(normalized_ordinate / normalized_abcissa)
end

Base.angle(point1::T, point2::T) where {T} = angle(Tuple(point1), Tuple(point2))

end # AngleBetweenVectors
