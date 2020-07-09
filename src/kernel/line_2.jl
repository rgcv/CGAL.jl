@doc raw"""
    Line2

An object `l` of the data type [`Line2`](@ref) is a directed straight line in
the two-dimensional Euclidean plane ``Ε^2``.

It is defined by the set of points with Cartesian coordinates ``(x, y)`` that
satisfy the equation

```math
    l:\; a\, x + b\, y + c = 0.
```

The line splits ``Ε^2`` in a *positive* and a *negative* side. A point p with
Cartesian coordinates ``(px, py)`` is on the positive side of `l`, iff
``a\, px + b\, py + c > 0``, it is on the negative side of `l`, iff
``a\, px + b\, py + c < 0``. The positive side is to the left of `l`.

# Example

Let us first define two Cartesian two-dimensional points in the Euclidean place
``Ε^2``. Their dimension and the fact that they are Cartesian is expressed by
the suffix `2` and the `C2` suffix in their representation.

```jldoctest
julia> p, q = Point2(1.0,1.0), Point2(4.0,7.0)
(PointC2(1, 1), PointC2(4, 7))
```

To define a line `l` we write:

```jldoctest
julia> l = Line2(p,q)
Line_2(-6, 3, 3)
```
"""
Line2

"""
    Line2(a::Real, b::Real, c::Real)

Introduces a line `l` with the line equation in Cartesian coordinates
``ax + by + c = 0``.
"""
Line2(a::Real, b::Real, c::Real) =
    Line2(convert(FT, a), convert(FT, b), convert(FT, c))

"""
    Line2(p::Point2, q::Point2)

Introduces a line `l` passing through the points `p` and `q`.

Line `l` is directed from `p` to `q`.
"""
Line2(p::Point2, q::Point2)

"""
    Line2(p::Point2, d::Direction2)

Introduces a line `l` passing through point `p` with direction `d`.
"""
Line2(p::Point2, d::Direction2)

"""
    Line2(p::Point2, d::Vector2)

Introduces a line `l` passing through point `p` and oriented by `v`.
"""
Line2(p::Point2, v::Vector2)

"""
    Line2(s::Segment2)

Introduces a line `l` supporting the segment `s`, oriented from source to
target.
"""
Line2(s::Segment2)

"""
    Line2(r::Ray2)

Introduces a line `l` supporting the ray `r`, with same orientation.
"""
Line2(r::Ray2)

"""
    ==(l::Line2, h::Line2)

Test for equality: two lines are equal, iff they have a non empty intersection
and the same direction.
"""
==(l::Line2, h::Line2)

"""
    a(l::Line2)

Returns the first coefficient of `l`.
"""
a(l::Line2)

"""
    b(l::Line2)

Returns the second coefficient of `l`.
"""
b(l::Line2)

"""
    c(l::Line2)

Returns the third coefficient of `l`.
"""
c(l::Line2)

"""
    point(l::Line2, i::Real)

Returns an arbitrary point on `l`.

It holds `point(l, i) == point(l, j)`, iff `i == j`. Furthermore, `l` is
directed from `point(l, i)` to `point(l, j)`, for all `i` ``<`` `j`.
"""
point(l::Line2, i::Real)

@cxxdereference point(l::Line2, i::Real) = point(l, convert(FT, i))

"""
    projection(l::Line2, p::Point2)

Returns the orthogonal projection of `p` onto `l`.
"""
projection(l::Line2, p::Point2)

"""
    x_at_y(l::Line2, y::Real)

Returns the ``x``-coordinate of the point at `l` with the given
``y``-coordinate.

!!! info "Precondition"

    `l` is not horizontal.
"""
x_at_y(l::Line2, y::Real)

@cxxdereference x_at_y(l::Line2, y::Real) = x_at_y(l, convert(FT, y))

"""
    y_at_x(l::Line2, x::Real)

Returns the ``y``-coordinate of the point at `l` with the given
``x``-coordinate.

!!! info "Precondition"

    `l` is not vertical.
"""
y_at_x(l::Line2, x)

@cxxdereference y_at_x(l::Line2, x::Real) = y_at_x(l, convert(FT, x))

"""
    is_degenerate(l::Line2)

Line `l` is degenerate, if the coefficients `a` and `b` of the line equation are
zero.
"""
is_degenerate(l::Line2)

"""
    is_horizontal(l::Line2)

Line `l` is horizontal, if coefficient `a` of the line equation is zero.
"""
is_horizontal(l::Line2)

"""
    is_vertical(l::Line2)

Line `l` is horizontal, if coefficient `b` of the line equation is zero.
"""
is_vertical(l::Line2)

"""
    oriented_side(l::Line2, p::Point2)

Returns [`ON_ORIENTED_BOUNDARY`](@ref), [`ON_NEGATIVE_SIDE`](@ref), or the
constant [`ON_POSITIVE_SIDE`](@ref), depending on the position of `p` relative
to the oriented line `l`.
"""
oriented_side(l::Line2, p::Point2)

"""
    has_on(l::Line2, p::Point2)

Returns `true`, iff `p` lies properly on `l`.
"""
has_on(l::Line2, p::Point2)

"""
    has_on_positive_side(l::Line2, p::Point2)

Returns `true`, iff `p` lies on the positive side of `l`.
"""
has_on_positive_side(l::Line2, p::Point2)

"""
    has_on_negative_side(l::Line2, p::Point2)

Returns `true`, iff `p` lies on the negative side of `l`.
"""
has_on_negative_side(c::Line2, p::Point2)

"""
    to_vector(l::Line2)

Returns a vector having the direction of `l`.
"""
to_vector(l::Line2)

"""
    direction(l::Line2)

Returns the direction of `l`.
"""
direction(l::Line2)

"""
    opposite(l::Line2)

Returns the line with opposite direction.
"""
opposite(l::Line2)

"""
    perpendicular(l::Line2, p::Point2)

Returns the line perpendicular to `l` and passing through `p`, where the
direction is the direction of `l` rotate counterclockwise by 90 degrees.
"""
perpendicular(l::Line2, p::Point2)

"""
    transform(l::Line2, t::AffTransformation2)

Returns the line obtained by applying `t` on a point on `l` and the direction of
`l`.
"""
transform(l::Line2, t::AffTransformation2)
