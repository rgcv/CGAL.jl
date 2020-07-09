@doc raw"""
    Circle2

An object `c` of type [`Circle2`](@ref) is a circle in the two-dimensional
Euclidean plane ``Ε^2``.

The circle is oriented, i.e. its boundary has clockwise or counterclockwise
orientation. The boundary splits ``Ε^2`` into a positive and a negative
side, where the positive side is to the left of the boundary. The boundary also
splits ``Ε^2`` into a bounded and an unbounded side. Note that the circle
can be degenerated, i.e. the squared radius may be zero.
"""
Circle2

@doc raw"""
    Circle2(center::Point2, squared_radius::Real, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `c` of type [`Circle2`](@ref).

It is initialized to the circle with center `center`, squared radius
`squared_radius`, and orientation `ori`.

!!! info "Precondition"

    `ori` ``≠`` `COLLINEAR`, and further, `squared_radius` ``≥ 0``.
"""
Circle2(center::Point2, squared_radius::Real, ori::Orientation = COUNTERCLOCKWISE)

@cxxdereference Circle2(c::Point2, r²::Real, ori::Union{Orientation,Ref{Orientation}} = COUNTERCLOCKWISE) =
    Circle2(c, convert(FT, r²), ori)

@doc raw"""
    Circle2(p::Point2, q::Point2, r::Point2)

Introduces a variable `c` of type [`Circle2`](@ref).

It is initialized to the unique circle which passes through the points `p`, `q`
and `r`. The orientation of the circle is the orientation of the point triple
`p`, `q`, `r`.

!!! info "Precondition"

    `p`, `q`, and `r` are not collinear.
"""
Circle2(p::Point2, q::Point2, r::Point2)

@doc raw"""
    Circle2(p::Point2, q::Point2, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `c` of type [`Circle2`](@ref).

It is initialized to the circle with diameter ``\overline{pq}`` and orientation
`ori`.

!!! info "Precondition"

    `ori` ``≠`` `COLLINEAR`.
"""
Circle2(p::Point2, q::Point2, ori::Orientation = COUNTERCLOCKWISE)

@doc raw"""
    Circle2(p::Point2, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `c` of type [`Circle2`](@ref).

It is initialized to the circle with center `center`, squared radius zero, and
orientation `ori`.

!!! info "Precondition"

    `ori` ``≠`` `COLLINEAR`.

!!! info "Postcondition"

    `is_degenerate(c) == true`.
"""
Circle2(p::Point2, ori::Orientation = COUNTERCLOCKWISE)

"""
    center(c::Circle2)

Returns the center of `c`.
"""
center(c::Circle2)

"""
    squared_radius(c::Circle2)

Returns the squared radius of `c`.
"""
squared_radius(c::Circle2)

"""
    orientation(c::Circle2)

Returns the orientation of `c`.
"""
orientation(c::Circle2)

"""
    ==(c::Circle2, circle2::Circle2)

Returns `true`, iff `c` and `circle2` are equal, i.e. if they have the same
center, same squared radius and same orientation.
"""
==(c::Circle2, circle2::Circle2)

"""
    is_degenerate(c::Circle2)

Returns `true`, iff `c` is degenerate, i.e. if `c` has squared radius zero.
"""
is_degenerate(c::Circle2)

"""
    oriented_side(c::Circle2, p::Point2)

Returns either the constant [`ON_ORIENTED_BOUNDARY`](@ref),
[`ON_POSITIVE_SIDE`](@ref), or [`ON_NEGATIVE_SIDE`](@ref), iff `p` lies on the
boundary, properly on the positive side, or properly on the negative side of
`c`, resp.
"""
oriented_side(c::Circle2, p::Point2)

"""
    bounded_side(c::Circle2, p::Point2)

Returns [`ON_BOUNDED_SIDE`](@ref), [`ON_BOUNDARY`](@ref), or
[`ON_UNBOUNDED_SIDE`](@ref) iff p lies properly inside, on the boundary, or
properly outside of `c`, resp.
"""
bounded_side(c::Circle2, p::Point2)

"""
    has_on_positive_side(c::Circle2, p::Point2)

Returns `true`, iff `p` lies on the positive side of `c`.
"""
has_on_positive_side(c::Circle2, p::Point2)

"""
    has_on_negative_side(c::Circle2, p::Point2)

Returns `true`, iff `p` lies on the negative side of `c`.
"""
has_on_negative_side(c::Circle2, p::Point2)

"""
    has_on_boundary(c::Circle2, p::Point2)

Returns `true`, iff `p` lies on the boundary of `c`.
"""
has_on_boundary(c::Circle2, p::Point2)

"""
    has_on_bounded_side(c::Circle2, p::Point2)

Returns `true`, iff `p` lies properly inside of `c`.
"""
has_on_bounded_side(c::Circle2, p::Point2)

"""
    has_on_unbounded_side(c::Circle2, p::Point2)

Returns `true`, iff `p` lies properly outside of `c`.
"""
has_on_unbounded_side(c::Circle2, p::Point2)

"""
    opposite(c::Circle2)

Returns the circle with the same center and squared radius as `c`, but with
opposite orientation.
"""
opposite(c::Circle2)

"""
    orthogonal_transform(c::Circle2, at::AffTransformation2)

Returns the circle obtained by applying `at` on `c`.

!!! info "Precondition"

    `at` is an orthogonal transformation.
"""
orthogonal_transform(c::Circle2, at::AffTransformation2)

"""
    bbox(c::Circle2)

Returns a bounding box containing `c`.
"""
bbox(c::Circle2)
