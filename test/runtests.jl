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

