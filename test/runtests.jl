using AngleBetweenVectors
using Test

@testset "Angles" begin

point1 = (1.0, 0.0)
point2 = (0.0, 1.0)
point3 = (-1.0, 0.0)

@test angle(point1, point2) == angle(point2, point1)
@test angle(point1, point3) == angle(point3, point1)
@test angle(point3, point2) == angle(point2, point3)

@test angle(point1, point2) == pi/2.0
@test angle(point1, point3) == pi/1.0

point1 = (1.0, -1.0, 0.0,  0.0)
point2 = (0.0,  1.0, 0.0, -1.0)

# note: 2pi/3 !== Float64(2*BigFloat(pi)/3)
@test angle(point1, point2) == Float64(2*BigFloat(pi)/3)
@test angle(point1, point2) == angle(point2, point1)

struct P{T}
    x::T
    y::T
end

BaseTuple(p::P) = (p.x, p.y)

@test angle(P(1.0,0.5), P(0.25, 1.5))

end
