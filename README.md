# AngleBetweenVectors.jl

#### When computing the arc separating two cartesian vectors, this is robustly stable; others are not.

----

#### Copyright ©&thinsp;2018 by Jeffrey Sarnoff. &nbsp;&nbsp; This work is released under The MIT License.


-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl)
----

### provides

- angle( n_tuple₁  ,  n_tuple₂ )

- angle( n_vector₁ , n_vector₂ )


### why use thishttps://mail.google.com/mail/u/0/#inbox

```julia
julia> 

julia> inaccurate_twothirds_pi = 2*pi/3
2.0943951023931953

julia> accurate_twothirds_pi = Float64( 2 * BigFloat(pi) / BigFloat(3) )
2.0943951023931957

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

#  always specialize the Tuple constructor
Tuple(point::Point2D{T}) where {T} = (point.x, point.y)

PointRepresentation!(Point2D{Float32}, Point2D{Float64})

point1 = Point2D(0.0, 1.0)
point2 = Point2D(1.0, 1.0)

angle(point1, point2) / pi == 0.25
true
``` 

```
julia> using StaticArrays

julia> struct NDPoint{N,T}
           value::SArray{Tuple{N}, T, 1, N}
       end

julia> Tuple(p::NDPoint{N,T}) where {N,T} = p.value.data;
julia> PointRepresentation!(NDPoint{N,T}) where {N,T}

julia> p = NDPoint(SVector(1.0,2.0,3.0,4.0))
NDPoint{4,Float64}([1.0, 2.0, 3.0, 4.0])

julia> angle(p, p)
0.0
```
 
### notes

- The shorter of two angle solutions is returned as an unoriented magnitude (0 <= radians < π).

- Vectors are given by their Cartesian coordinates in 2D, 3D or .. N-dimensions.

- This approach is from the work of Professor William Kahan.
    - [a more accurate angle](https://people.eecs.berkeley.edu/~wkahan/MathH110/Cross.pdf) (page 15)
