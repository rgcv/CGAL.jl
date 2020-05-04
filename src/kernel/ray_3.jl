@doc raw"""
    Ray3

An object `r` of the data type [`Ray3`](@ref) is a directed straight ray in the
three-dimensional Euclidean space ``Ε^2``.

It starts in a point called the *source* of `r` and goes to infinity.
"""
Ray3

"""
    Ray3(p::Point3, q::Point3)

Introduces a ray `r` with source `p` and passing through point `q`.
"""
Ray3(p::Point3, q::Point3)

"""
    Ray3(p::Point3, d::Direction3)

Introduces a ray `r` starting at source `p` with direction `d`.
"""
Ray3(p::Point3, d::Direction3)

"""
    Ray3(p::Point3, v::Vector3)

Introduces a ray `r` starting at source `p` with the direction of `v`.
"""
Ray3(p::Point3, v::Vector3)

"""
    Ray3(p::Point3, l::Line3)

Introduces a ray `r` starting at source `p` with the same direction as `l`.
"""
Ray3(p::Point3, l::Line3)

"""
    ==(r::Ray3, h::Ray3)

Test for equality: two rays are equal, iff they have the same source and the
same direction.
"""
==(r::Ray3, h::Ray3)

"""
    source(r::Ray3)

Returns the source of `r`.
"""
source(r::Ray3)

@doc raw"""
    point(r::Ray3, i::FT)
    point(r::Ray3, i::Real)

Returns a point on `r`.

!!! info "Precondition"

    ``i ≥ 0``.
"""
point(r::Ray3, i)

@cxxdereference point(r::Ray3, i::Real) = point(r, convert(FT, i))

"""
    direction(r::Ray3)

Returns the direction of `r`.
"""
direction(r::Ray3)

"""
    to_vector(r::Ray3)

Returns a vector giving the direction of `r`.
"""
to_vector(r::Ray3)

"""
    supporting_line(r::Ray3)

Returns the line supporting `r` which has the same direction.
"""
supporting_line(r::Ray3)

"""
    opposite(r::Ray3)

Returns the ray with the same source and opposite direction.
"""
opposite(r::Ray3)

"""
    is_degenerate(r::Ray3)

Ray `r` is degenerate, if the source and the second defining point fall
together (that is if the direction is degenerate).
"""
is_degenerate(r::Ray3)

"""
    has_on(r::Ray3, p::Point3)

A point is on `r`, iff it is equal to the source of `r`, or if it is in the
interior of `r`.
"""
has_on(r::Ray3, p::Point3)

"""
    transform(r::Ray3, t::AffTransformation3)

Returns the ray obtained by applying `t` on the source and on the direction of
`r`.
"""
transform(r::Ray3, t::AffTransformation3)
