@doc raw"""
    Circle3

An object `c` of type [`Circle3`](@ref) is a circle in the three-dimensional
Euclidean space ``Ε^3``.

Note that the circle can be degenerated, i.e. the squared radius may be zero.
"""
Circle3

@doc raw"""
    Circle3(center::Point3, r²::Real, plane::Plane3)

Introduces a variable `c` of type [`Circle3`](@ref).

It is initalized to the circle of center `center` and squared radius `r²` in
plane `plane`.

!!! info "Precondition"

    `center` lies in `plane` and `r²` ``\ge`` 0.
"""
Circle3(center::Point3, r²::Real, plane::Plane3)

@cxxdereference Circle3(center::Point3, r²::Real, plane::Plane3) =
    Circle3(center, convert(FT, r²), plane)

@doc raw"""
    Circle3(center::Point3, r²::Real, n::Vector3)

Introduces a variable `c` of type [`Circle3`](@ref).

It is initalized to the circle of center `center` and squared radius `r²` in a
plane normal to the vector `n`.

!!! info "Precondition"

    `r²` ``\ge`` 0.
"""
Circle3(center::Point3, r²::Real, n::Vector3)

@cxxdereference Circle3(center::Point3, r²::Real, n::Vector3) =
    Circle3(center, convert(FT, r²), n)

@doc raw"""
    Circle3(p::Point3, q::Point3, r::Point3)

Introduces a variable `c` of type [`Circle3`](@ref).

It is initialized to the circle passing through the three points.

!!! info "Precondition"

    The three points are not collinear.
"""
Circle3(p::Point3, q::Point3, r::Point3)

@doc raw"""
    Circle3(sphere₁::Sphere3, sphere₂::Sphere3)

Introduces a variable `c` of type [`Circle3`](@ref).

It is initialized to the circle along which the two spheres intersect.

!!! info "Precondition"

    The two spheres intersect along a circle.
"""
Circle3(sphere₁::Sphere3, sphere₂::Sphere3)

@doc raw"""
    Circle3(sphere::Sphere3, plane::Plane3)

Introduces a variable `c` of type [`Circle3`](@ref).

It is initialized to the circle along which the sphere and the plane intersect.

!!! info "Precondition"

    The sphere and the plane intersect along a circle.
"""
Circle3(sphere::Sphere3, plane::Plane3)

@doc raw"""
    Circle3(plane::Plane3, sphere::Sphere3)

Introduces a variable `c` of type [`Circle3`](@ref).

It is initialized to the circle along which the sphere and the plane intersect.

!!! info "Precondition"

    The sphere and the plane intersect along a circle.
"""
Circle3(plane::Plane3, sphere::Sphere3)

"""
    center(c::Circle3)

Returns the center of `c`.
"""
center(c::Circle3)

"""
    squared_radius(c::Circle3)

Returns the squared radius of `c`.
"""
squared_radius(c::Circle3)

"""
    supporting_plane(c::Circle3)

Returns the supporting plane of `c`.
"""
supporting_plane(c::Circle3)

"""
    diametral_sphere(c::Circle3)

Returns the diametral sphere of `c`.
"""
diametral_sphere(c::Circle3)

"""
    area_divided_by_pi(c::Circle3)

Returns the area of `c`, divided by ``π``.
"""
area_divided_by_pi(c::Circle3)

"""
    approximate_area(c::Circle3)

Returns an approximation of the area of `c`.
"""
approximate_area(c::Circle3)

"""
    squared_length_divided_by_pi_square(c::Circle3)

Returns the squared length of `c`, divided by ``π^2``.
"""
squared_length_divided_by_pi_square(c::Circle3)

"""
    approximate_squared_length(c::Circle3)

Returns an approximation of the squared length (i.e. perimeter) of `c`.
"""
approximate_squared_length(c::Circle3)

"""
    ==(c::Circle3, circle3::Circle3)

Returns `true`, iff `c` and `circle3` are equal, i.e. if they have the same
center, same squared radius and same supporting plane.
"""
==(c::Circle3, circle3::Circle3)

"""
    bbox(c::Circle3)

Returns a bounding box containing `c`.
"""
bbox(c::Circle3)
