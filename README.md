# AngleBetweenVectors.jl

----

#### Copyright © 2015-2018 by Jeffrey Sarnoff.
####  This work is released under The MIT License.

When computing the arc separating two cartesian vectors, this is robustly stable where other functions are not.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl)
----

### provides

- angle( n_tuple₁  ,  n_tuple₂ )

- angle( n_vector₁ , n_vector₂ )


### why use this

```julia
julia> precise_twothirds_pi = 2*pi/3
2.0943951023931953

julia> accurate_twothirds_pi = Float64( 2 * BigFloat(pi) / BigFloat(3) )
2.0943951023931957

julia> prevfloat( accurate_twothirds_pi ) == precise_twothirds_pi
true

julia> point1, point2 = (1, -1, 0,  0), (0,  1, 0, -1); 

julia> angle(point1, point2)
2.0943951023931957

julia> angle(point1, point2) == accurate_twothirds_pi
true
```

### exensible

```julia
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
point2 = Point2D(1.0, 1.0)

angle_between = angle(point1, point2)
angle_between / pi == 0.25
``` 
 
### notes

- The shorter of two angle solutions is returned as an unoriented magnitude (0 <= radians < π).

- Vectors are given by their Cartesian coordinates in 2D, 3D or .. N-dimensions.

- This approach is from the work of Professor William Kahan.
