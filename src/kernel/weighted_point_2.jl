"""
    WeightedPoint2

An object of the type [`WeightedPoint2`](@ref) is a tuple of a two-dimensional
point and a scalar weight.

See also: [`Point2`](@ref)
"""
WeightedPoint2

"""
    WeightedPoint()
    WeightedPoint(ORIGIN::Origin)

Introduces a weighted point with Cartesian coordinates `(0, 0)` and weight `0`.
"""
WeightedPoint()

"""
    WeightedPoint2(p::Point2)

Introduces a weighted point from point `p` and weight `0`.
"""
WeightedPoint2(p::Point2)

"""
    WeightedPoint2(p::Point2, w::FT)
    WeightedPoint2(p::Point2, w::Real)

Introduces a weighted point from point `p` and weight `w`.
"""
WeightedPoint2(p::Point2, w)

@cxxdereference WeightedPoint2(p::Point2, w::Real) =
    WeightedPoint2(p, convert(FT, w))

"""
    WeightedPoint2(x::FT, y::FT)
    WeightedPoint2(x::Real, y::Real)

Introduces a weighted point with coordinates `x`, `y`, and weight `0`.
"""
WeightedPoint2(x, y)

WeightedPoint2(x::Real, y::Real) = WeightedPoint2(convert.(FT, (x, y))...)

"""
    point(p::WeightedPoint2)

Returns the point of the weighted point.
"""
point(p::WeightedPoint2)

"""
    weight(p::WeightedPoint2)

Returns the weight of the weighted point.
"""
weight(p::WeightedPoint2)

"""
    ==(p::WeightedPoint2, q::WeightedPoint2)

Test for equality.

Two points are equal, iff their ``x`` and ``y`` coordinates are equal. The point
can be compared with [`ORIGIN`](@ref).

!!! warn "Warning"

    Comparison and equality (==, <, etc.) currently operate directly on the
    underlying bare point. Consequently:

    ```julia-repl
    julia> p = Point2(1.0, 2.0)
    PointC2(1, 2)

    julia> wp, wq = WeightedPoint2.((p, p), (1.0, 2.0))    # same bare point here,
    (Weighted_pointC2(1, 2, 1), Weighted_pointC2(1, 2, 2)) # but different weights

    julia> wp == wq
    true
    ```
"""
==(p::WeightedPoint2, q::WeightedPoint2)

"""
    hx(p::WeightedPoint2)

Returns the homogeneous ``x`` coordinate.
"""
hx(p::WeightedPoint2)

"""
    hy(p::WeightedPoint2)

Returns the homogeneous ``y`` coordinate.
"""
hy(p::WeightedPoint2)

"""
    hw(p::WeightedPoint2)

Returns the homogenizing coordinate.
"""
hw(p::WeightedPoint2)

"""
    x(p::WeightedPoint2)

Returns the Cartesian ``x`` coordinate, that is [`hx()`](@ref)/[`hw()`](@ref).
"""
x(p::WeightedPoint2)

"""
    y(p::WeightedPoint2)

Returns the Cartesian ``y`` coordinate, that is [`hy()`](@ref)/[`hw()`](@ref).
"""
y(p::WeightedPoint2)

@doc raw"""
    homogeneous(p::WeightedPoint2, i::Integer)

Returns the `i`ᵗʰ homogeneous coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``.
"""
homogeneous(p::WeightedPoint2, i::Integer)

@doc raw"""
    cartesian(p::WeightedPoint2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``.
"""
cartesian(p::WeightedPoint2, i::Integer)

"""
    dimension(p::WeightedPoint2)

Returns the dimension (the constant 2).
"""
dimension(p::WeightedPoint2)

"""
    bbox(p::WeightedPoint2)

Returns a bounding box containing `p`.
"""
bbox(p::WeightedPoint2)

"""
    transform(p::WeightedPoint2, t::AffTransformation2)

Returns the weighted point obtained by applying `t` on `p`.
"""
transform(p::WeightedPoint2, t::AffTransformation2)
