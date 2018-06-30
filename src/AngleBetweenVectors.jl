import Base: angle

using LinearAlgebra

function Base.angle(point1::T, point2::T) where {N, R<:Real, T<:Union{NTuple{N,R}, AbstractArray{R,1}}}
   rescaled_point1 = point1 .* LinearAlgebra.norm(point2)
   rescaled_point2 = point2 .* LinearAlgebra.norm(point1)

   x = LinearAlgebra.norm(rescaled_point2 .+ rescaled_point1)
   y = LinearAlgebra.norm(rescaled_point2 .- rescaled_point1)
   return 2 * atan(y, x)
end
