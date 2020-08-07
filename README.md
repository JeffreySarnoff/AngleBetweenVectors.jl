# AngleBetweenVectors.jl

#### When computing the arc separating two cartesian vectors, this is robustly stable; others are not.

----

#### Copyright ©&thinsp;2018-2020 by Jeffrey Sarnoff. &nbsp;&nbsp; This work is released under The MIT License.

----

[![Build Status](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl)

----


[AngleBetweenVectors](https://github.com/JeffreySarnoff/AngleBetweenVectors.jl) exports `angle`.
`angle(point1, point2)` determines the angle of their separation.   The smaller of the two solutions is used.  `π` obtains If the points are opposed, [(1,0), (-1,0)]; so `0 <= angle(p1, p2) <= pi`.

This function expects two points from a 2D, 3D .. ManyD space, in Cartesian coordinates.  Tuples and Vectors are handled immediately (prefer Tuples for speed). To use another point representations, just define a `Tuple` constructor for it.  NamedTuples and SVectors have this already.

Most software uses `acos(dot(p1, p2) / sqrt(norm(p1) norm(p2))` instead.  While they coincide often; it is exceedingly easy to find cases where `angle` is more accurate and then, usually they differ by a few ulps. Not always.

-----

### provides

- `angle( point₁, point₂ )`
    - points are given as Cartesian coordinates
    - points may be of any finite dimension >= 2
    - points may be any type with a Tuple constructor defined


#### point representations that just work 

- points as Tuples
- points as NamedTuples
- points as Vectors
- points as SVectors     (StaticArrays)

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



-----



### notes

- The shorter of two angle solutions is returned as an unoriented magnitude (0 <= radians < π).

- Vectors are given by their Cartesian coordinates in 2D, 3D or .. N-dimensions.

- This follows a note by Professor Kahan in [Computing Cross-Products and Rotations]( https://people.eecs.berkeley.edu/%7Ewkahan/MathH110/Cross.pdf) (pg 15): "More uniformly accurate .. valid for  Euclidean  spaces of any dimension,   it never errs by more than a modest multiple of ε."  
