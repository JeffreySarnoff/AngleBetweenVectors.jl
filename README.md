# AngleBetweenVectors.jl

----

#### Copyright © 2015-2018 by Jeffrey Sarnoff.
####  This work is released under The MIT License.

When computing the arc separating two cartesian vectors, this is robustly stable where other functions are not.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/AngleBetweenVectors.jl)
----

### exports

- angle(point₁::T, point₂::T) where {N, R<:Real, T<:Union{NTuple{N,R}, AbstractArray{R,1}}

- angle(n_tuple₁,  n_tuple₂), angle(n_vector₁,  n_vector₂)


### about

- The shorter of two angle solutions is returned as an unoriented magnitude (0 <= radians < π).

- Vectors are given by their Cartesian coordinates in 2D, 3D or .. N-dimensions.
- Vectors may be given as Tuples or as Array{T,1}s of length N.1


### notes

This approach is the work of Professor William Kahan.
