@doc raw"""
    Line3

An object `l` of the data type [`Line3`](@ref) is a directed straight line in
the three-dimensional Euclidean space ``Ε^3``.
"""
Line3

"""
    Line3(p::Point3, q::Point3)

Introduces a line `l` passing through the points `p` and `q`.

Line `l` is directed from `p` to `q`.
"""
Line3(p::Point3, q::Point3)

"""
    Line3(p::Point3, d::Direction3)

Introduces a line `l` passing through point `p` with direction `d`.
"""
Line3(p::Point3, d::Direction3)

"""
    Line3(p::Point3, d::Vector3)

Introduces a line `l` passing through point `p` and oriented by `v`.
"""
Line3(p::Point3, v::Vector3)

"""
    Line3(s::Segment3)

Introduces a line `l` supporting the segment `s`, oriented from source to
target.
"""
Line3(s::Segment3)

"""
    Line3(r::Ray3)

Introduces a line `l` supporting the ray `r`, with same orientation.
"""
Line3(r::Ray3)

"""
    ==(l::Line3, h::Line3)

Test for equality: two lines are equal, iff they have a non empty intersection
and the same direction.
"""
==(l::Line3, h::Line3)

"""
    point(l::Line3, i::FT)
    point(l::Line3, i::Real)

Returns an arbitrary point on `l`.

It holds `point(l, i) == point(l, j)`, iff `i == j`.
"""
point(l::Line3, i)

@cxxdereference point(l::Line3, i::Real) = point(l, convert(FT, i))

"""
    projection(l::Line3, p::Point3)

Returns the orthogonal projection of `p` onto `l`.
"""
projection(l::Line3, p::Point3)

"""
    is_degenerate(l::Line3)

Returns `true` iff line `l` is degenerated to a point.
"""
is_degenerate(l::Line3)

"""
    has_on(l::Line3, p::Point3)

Returns `true`, iff `p` lies properly on `l`.
"""
has_on(l::Line3, p::Point3)

"""
    perpendicular_plane(l::Line3, p::Point3)

Returns the plane perpendicular to `l` passing through `p`.
"""
perpendicular_plane(l::Line3, p::Point3)

"""
    to_vector(l::Line3)

Returns a vector having the same direction as `l`.
"""
to_vector(l::Line3)

"""
    direction(l::Line3)

Returns the direction of `l`.
"""
direction(l::Line3)

"""
    opposite(l::Line3)

Returns the line with opposite direction.
"""
opposite(l::Line3)

"""
    transform(l::Line3, t::AffTransformation2)

Returns the line obtained by applying `t` on a point on `l` and the direction of
`l`.
"""
transform(l::Line3, t::AffTransformation2)
