@doc raw"""
    Point2

An object `p` of the type [`Point2`](@ref) is a point in the two-dimensional
Euclidean plane ``Ε^2``.

# Example

The following declaration creates two points with Cartesian coordinates.

```julia-repl
julia> p, q = Point2(), Point2(1.0, 2.0)
(PointC2(0, 0), PointC2(1, 2))
```
"""
Point2

"""
    Point2(::Origin = ORIGIN)

Introduces a variable `p` with Cartesian coordinates ``(0, 0)``.
"""
Point2(::Origin = ORIGIN)

"""
    Point2(x::Real, y::Real)

Introduces a point `p` initialized to ``(x, y)``.
"""
Point2(x::Real, y::Real) = Point2(convert(FT, x), convert(FT, y))

@doc raw"""
    Point2(x::Real, y::Real, hw::Real = 1)

Introduces a point `p` initialized to `(hx/hw,hy/hw)`.

!!! info "Precondition"

    `hw` ``≠`` `0`
"""
Point2(x::Real, y::Real, hw::Real) =
    Point2(convert(RT, x), convert(RT, y), convert(RT, hw))

"""
    Point2(wp::WeightedPoint2)

Introduces a point from a weighted point.
"""
Point2(wp::WeightedPoint2)

"""
    ==(p::Point2, q::Point2)

Test for equality.

Two points are equal, iff their ``x`` and ``y`` coordinates are equal. The point
can be compared with [`ORIGIN`](@ref).
"""
==(p::Point2, q::Point2)

"""
    hx(p::Point2)

Returns the homogeneous ``x`` coordinate.
"""
hx(p::Point2)

"""
    hy(p::Point2)

Returns the homogeneous ``y`` coordinate.
"""
hy(p::Point2)

"""
    hw(p::Point2)

Returns the homogenizing coordinate.
"""
hw(p::Point2)

"""
    x(p::Point2)

Returns the Cartesian ``x`` coordinate, that is [`hx()`](@ref)/[`hw()`](@ref).
"""
x(p::Point2)

"""
    y(p::Point2)

Returns the Cartesian ``y`` coordinate, that is [`hy()`](@ref)/[`hw()`](@ref).
"""
y(p::Point2)

@doc raw"""
    homogeneous(p::Point2, i::Integer)

Returns the `i`ᵗʰ homogeneous coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``.
"""
homogeneous(p::Point2, i::Integer)

@doc raw"""
    cartesian(p::Point2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``.
"""
cartesian(p::Point2, i::Integer)

"""
    dimension(p::Point2)

Returns the dimension (the constant 2).
"""
dimension(p::Point2)

"""
    bbox(p::Point2)

Returns a bounding box containing `p`.
"""
bbox(p::Point2)

"""
    transform(p::Point2, t::AffTransformation2)

Returns the point obtained by applying `t` on `p`.
"""
transform(p::Point2, t::AffTransformation2)

"""
    <(p::Point2, q::Point2)

Return `true` iff `p` is lexicographically smaller than `q`, i.e. either if
`x(p) < x(q)` or if `x(p) == x(q)` and `y(p) < y(q)`.
"""
<(p::Point2, q::Point2)

"""
    >(p::Point2, q::Point2)

Return `true` iff `p` is lexicographically greater than `q`.
"""
>(p::Point2, q::Point2)

"""
    <=(p::Point2, q::Point2)

Return `true` iff `p` is lexicographically smaller or equal to `q`.
"""
<=(p::Point2, q::Point2)

"""
    >=(p::Point2, q::Point2)

Return `true` iff `p` is lexicographically greater or equal to `q`.
"""
>=(p::Point2, q::Point2)

"""
    -(p::Point2, q::Point2)

Returns the difference vector between `p` and `q`.

You can substitute [`ORIGIN`](@ref) for either `p` or `q`, but not for both.
"""
-(p::Point2, q::Point2)
