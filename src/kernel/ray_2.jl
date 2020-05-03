@doc raw"""
    Ray2

An object `r` of the data type [`Ray2`](@ref) is a directed straight ray in the
two-dimensional Euclidean plane ``Ε^2``.

It starts in a point called the *source* of `r` and goes to infinity.
"""
Ray2

"""
    Ray2(p::Point2, q::Point2)

Introduces a ray `r` with source `p` and passing through point `q`.
"""
Ray2(p::Point2, q::Point2)

"""
    Ray2(p::Point2, d::Direction2)

Introduces a ray `r` starting at source `p` with direction `d`.
"""
Ray2(p::Point2, d::Direction2)

"""
    Ray2(p::Point2, v::Vector2)

Introduces a ray `r` starting at source `p` with the direction of `v`.
"""
Ray2(p::Point2, v::Vector2)

"""
    Ray2(p::Point2, l::Line2)

Introduces a ray `r` starting at source `p` with the same direction as `l`.
"""
Ray2(p::Point2, l::Line2)

"""
    ==(r::Ray2, h::Ray2)

Test for equality: two rays are equal, iff they have the same source and the
same direction.
"""
==(r::Ray2, h::Ray2)

"""
    source(r::Ray2)

Returns the source of `r`.
"""
source(r::Ray2)

@doc raw"""
    point(r::Ray2, i::FT)
    point(r::Ray2, i::Real)

Returns a point on `r`.

!!! info "Precondition"

    ``i ≥ 0``.
"""
point(r::Ray2, i)

@cxxdereference point(r::Ray2, i::Real) = point(r, convert(FT, i))

"""
    direction(r::Ray2)

Returns the direction of `r`.
"""
direction(r::Ray2)

"""
    to_vector(r::Ray2)

Returns a vector giving the direction of `r`.
"""
to_vector(r::Ray2)

"""
    supporting_line(r::Ray2)

Returns the line supporting `r` which has the same direction.
"""
supporting_line(r::Ray2)

"""
    opposite(r::Ray2)

Returns the ray with the same source and opposite direction.
"""
opposite(r::Ray2)

"""
    is_degenerate(r::Ray2)

Ray `r` is degenerate, if the source and the second defining point fall
together (that is if the direction is degenerate).
"""
is_degenerate(r::Ray2)

"""
    is_horizontal(r::Ray2)

Ray `r` is horizontal, if coefficient `a` of the supporting line's equation is
zero.
"""
is_horizontal(r::Ray2)

"""
    is_vertical(r::Ray2)

Ray `r` is vertical, if coefficient `b` of the supporting line's equation is
zero.
"""
is_vertical(r::Ray2)

"""
    has_on(r::Ray2, p::Point2)

A point is on `r`, iff it is equal to the source of `r`, or if it is in the
interior of `r`.
"""
has_on(r::Ray2, p::Point2)

"""
    collinear_has_on(r::Ray2, p::Point2)

Checks if point `p` is on `r`.

!!! info "Precondition"

    `p` is on the supporting line of `r`.
"""
collinear_has_on(r::Ray2, p::Point2)

"""
    transform(r::Ray2, t::AffTransformation2)

Returns the ray obtained by applying `t` on the source and on the direction of
`r`.
"""
transform(r::Ray2, t::AffTransformation2)
