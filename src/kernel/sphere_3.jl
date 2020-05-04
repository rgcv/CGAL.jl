@doc raw"""
    Sphere3

An object `s` of type [`Sphere3`](@ref) is a sphere in the three-dimensional
Euclidean space ``Ε^3``.

The sphere is oriented, i.e. its boundary has clockwise or counterclockwise
orientation. The boundary splits ``Ε^3`` into a positive and a negative
side, where the positive side is to the left of the boundary. The boundary also
splits ``Ε^3`` into a bounded and an unbounded side. Note that the sphere
can be degenerated, i.e. the squared radius may be zero.
"""
Sphere3

@doc raw"""
    Sphere3(center::Point3, r²::FT, ori::Orientation = COUNTERCLOCKWISE)
    Sphere3(center::Point3, r²::Real, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `s` of type [`Sphere3`](@ref).

It is initialized to the circle with center `center`, squared radius
`squared_radius`, and orientation `ori`.

!!! info "Precondition"

    `ori` ``≠`` `COPLANAR`, and further, `squared_radius` ``≥ 0``.
"""
Sphere3(center::Point3, r², ori::Orientation = COUNTERCLOCKWISE)

@cxxdereference Sphere3(c::Point3, r²::Real, ori::Union{Orientation,Ref{Orientation}} = COUNTERCLOCKWISE) =
    Sphere3(c, convert(FT, r²), ori)

"""
    Sphere3(p::Point3, q::Point3, r::Point3, s::Point3)

Introduces a variable `s` of type [`Sphere3`](@ref).

It is initialized to the unique sphere which passes through the points `p`, `q`,
`r` and `s`. The orientation of the sphere is the orientation of the point
quadruple `p`, `q`, `r`, `s`.

!!! info "Precondition"

    `p`, `q`, `r` and `s` are not coplanar.
"""
Sphere3(p::Point3, q::Point3, r::Point3, s::Point3)

@doc raw"""
    Sphere3(p::Point3, q::Point3, r::Point3, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `s` of type [`Sphere3`](@ref).

It is initialized to the smallest sphere which passes through the points `p`,
`q`, and `r`. The orientation of the sphere is `ori`.

!!! info "Precondition"

    `ori` ``≠`` `COPLANAR`.
"""
Sphere3(p::Point3, q::Point3, r::Point3, ori::Orientation = COUNTERCLOCKWISE)

@doc raw"""
    Sphere3(p::Point3, q::Point3, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `s` of type [`Sphere3`](@ref).

It is initialized to the smallest sphere which passes through the points `p` and
`q`. The orientation of the sphere is `ori`.

!!! info "Precondition"

    `ori` ``≠`` `COPLANAR`.
"""
Sphere3(p::Point3, q::Point3, ori::Orientation = COUNTERCLOCKWISE)

@doc raw"""
    Sphere3(center::Point3, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `s` of type [`Sphere3`](@ref).

It is initialized to the sphere with center `center`, squared radius zero and
orientation `ori`.

!!! info "Precondition"

    `ori` ``≠`` `COPLANAR`.

!!! info "Postcondition"

    `is_degenerate(s) == true`.
"""
Sphere3(center::Point3, ori::Orientation = COUNTERCLOCKWISE)

"""
    Sphere3(c::Circle3)

Introduces a variable `s` of type [`Sphere3`](@ref).

It is initialized to the diametral sphere of the circle.
"""
Sphere3(c::Circle3)

"""
    center(s::Sphere3)

Returns the center of `s`.
"""
center(s::Sphere3)

"""
    squared_radius(s::Sphere3)

Returns the squared radius of `s`.
"""
squared_radius(s::Sphere3)

"""
    orientation(s::Sphere3)

Returns the orientation of `s`.
"""
orientation(s::Sphere3)

"""
    ==(s₁::Sphere3, s₂::Sphere3)

Returns `true`, iff `s₁` and `s₂` are equal, i.e. if they have the same center,
same squared radius and same orientation.
"""
==(s₁::Sphere3, s₂::Sphere3)

"""
    is_degenerate(s::Sphere3)

Returns `true`, iff `s` is degenerate, i.e. if `s` has squared radius zero.
"""
is_degenerate(s::Sphere3)

"""
    oriented_side(s::Sphere3, p::Point3)

Returns either the constant [`ON_ORIENTED_BOUNDARY`](@ref),
[`ON_POSITIVE_SIDE`](@ref), or [`ON_NEGATIVE_SIDE`](@ref), iff `p` lies on the
boundary, properly on the positive side, or properly on the negative side of
`s`, resp.
"""
oriented_side(s::Sphere3, p::Point3)

"""
    bounded_side(s::Sphere3, p::Point3)

Returns [`ON_BOUNDED_SIDE`](@ref), [`ON_BOUNDARY`](@ref), or
[`ON_UNBOUNDED_SIDE`](@ref) iff p lies properly inside, on the boundary, or
properly outside of `s`, resp.
"""
bounded_side(s::Sphere3, p::Point3)

"""
    has_on_positive_side(s::Sphere3, p::Point3)

Returns `true`, iff `p` lies on the positive side of `s`.
"""
has_on_positive_side(s::Sphere3, p::Point3)

"""
    has_on_negative_side(s::Sphere3, p::Point3)

Returns `true`, iff `p` lies on the negative side of `s`.
"""
has_on_negative_side(s::Sphere3, p::Point3)

"""
    has_on_boundary(s::Sphere3, p::Point3)

Returns `true`, iff `p` lies on the boundary of `s`.
"""
has_on_boundary(s::Sphere3, p::Point3)

"""
    has_on_bounded_side(s::Sphere3, p::Point3)

Returns `true`, iff `p` lies properly inside of `s`.
"""
has_on_bounded_side(s::Sphere3, p::Point3)

"""
    has_on_unbounded_side(s::Sphere3, p::Point3)

Returns `true`, iff `p` lies properly outside of `s`.
"""
has_on_unbounded_side(s::Sphere3, p::Point3)

"""
    opposite(s::Sphere3)

Returns the sphere with the same center and squared radius as `s`, but with
opposite orientation.
"""
opposite(s::Sphere3)

"""
    orthogonal_transform(s::Sphere3, at::AffTransformation3)

Returns the circle obtained by applying `at` on `s`.

!!! info "Precondition"

    `at` is an orthogonal transformation.
"""
orthogonal_transform(s::Sphere3, at::AffTransformation3)

"""
    bbox(s::Sphere3)

Returns a bounding box containing `s`.
"""
bbox(s::Sphere3)
