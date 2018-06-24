using LinearAlgebra: norm

function Base.angle(point1::T, point2::T) where {T<:Union{Tuple, Vector}}
   norm1, norm2 = norm(point1), norm(point2)
   norm1pt2 = norm1 .* (point2...,)
   norm2pt1 = norm2 .* (point1...,)
   x = norm(norm1pt2 .+ norm2pt1)
   y = norm(norm1pt2 .- norm2pt1)
   return 2 * atan(y, x)
end
