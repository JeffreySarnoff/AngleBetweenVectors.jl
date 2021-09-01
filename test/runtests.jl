using AngleBetweenVectors
using Test

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

@test (@inferred angle(0:1, -1:0)) == pi/2 # abstract vector
@test (@inferred angle(0:1, -1.0:0.0)) == pi/2 # different eltype
@test (@inferred angle(Real[0.0 1], Int16[-1 0])) == pi/2 # array
@test (@inferred angle(0:1, (-1.0:0.0)*1im)) == pi/2 # complex

@test isnan(@inferred angle(zeros(2), 1:2)) # zero point returns NaN
