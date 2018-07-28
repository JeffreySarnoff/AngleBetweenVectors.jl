# AngleBetweenVectors.jl

#### When computing the arc separating two cartesian vectors, this is robustly stable; others are not.

----

#### Copyright ©&thinsp;2018 by Jeffrey Sarnoff. &nbsp;&nbsp; This work is released under The MIT License.


-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl)
----

### provides

- angle( point₁, point₂ )
    - points are given as Cartesian coordinates
    - points may be of any finite dimension >= 2
    - points may be any type with a Tuple constructor defined
    
#### point representations that just work 

- points as Tuples
- points as NamedTuples
- points as Vectors
- points as SVectors     (StaticArrays)
- points as FixedVectors (StaticArrays)

#### working with other point representations

Just define a `Tuple` constructor for the representation.  That's all.

```julia
# working with this?
struct Point3D{T}
    x::T
    y::T
    z::T
end

#  define this:
Base.Tuple(a::Point3D{T}) where {T} = (a.x, a.y, a.z)

#  this just works:
angle(point1::Point3D{T}, point2::Point3D{T})  where {T}
```

### why use it

This implementation is more robustly accurate than the usual method.

You can work with points in 2D, 3D, .. 1000D .. ?.

### notes

- The shorter of two angle solutions is returned as an unoriented magnitude (0 <= radians < π).

- Vectors are given by their Cartesian coordinates in 2D, 3D or .. N-dimensions.

- This approach is from the work of Professor William Kahan.
    - [a more accurate angle](https://people.eecs.berkeley.edu/~wkahan/MathH110/Cross.pdf) (page 15)
