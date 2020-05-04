"""
    WeightedPoint3

An object of the type [`WeightedPoint3`](@ref) is a tuple of a three-dimensional
point and a scalar weight.

See also: [`Point3`](@ref)
"""
WeightedPoint3

"""
    WeightedPoint3()
    WeightedPoint3(ORIGIN::Origin)

Introduces a weighted point with Cartesian coordinates `(0, 0, 0)` and weight
`0`.
"""
WeightedPoint3()

"""
    WeightedPoint3(p::Point3)

Introduces a weighted point from point `p` and weight `0`.
"""
WeightedPoint3(p::Point3)

"""
    WeightedPoint3(p::Point3, w::FT)
    WeightedPoint3(p::Point3, w::Real)

Introduces a weighted point from point `p` and weight `w`.
"""
WeightedPoint3(p::Point3, w)

@cxxdereference WeightedPoint3(p::Point3, w::Real) =
    WeightedPoint3(p, convert(FT, w))

"""
    WeightedPoint3(x::FT, y::FT)
    WeightedPoint3(x::Real, y::Real)

Introduces a weighted point with coordinates `x`, `y`, and weight `0`.
"""
WeightedPoint3(x, y)

WeightedPoint3(x::Real, y::Real) = WeightedPoint3(convert.(FT, (x, y))...)

"""
    point(p::WeightedPoint3)

Returns the point of the weighted point.
"""
point(p::WeightedPoint3)

"""
    weight(p::WeightedPoint3)

Returns the weight of the weighted point.
"""
weight(p::WeightedPoint3)

"""
    ==(p::WeightedPoint3, q::WeightedPoint3)

Test for equality.

Two points are equal, iff their ``x``, ``y`` and ``z`` coordinates are equal.
The point can be compared with [`ORIGIN`](@ref).

!!! warn "Warning"

    Comparison and equality (==, <, etc.) currently operate directly on the
    underlying bare point. Consequently:

    ```julia-repl
    julia> p = Point3(1.0, 2.0)
    PointC2(1, 2)

    julia> wp, wq = WeightedPoint3.((p, p), (1.0, 2.0))    # same bare point here,
    (Weighted_pointC2(1, 2, 1), Weighted_pointC2(1, 2, 2)) # but different weights

    julia> wp == wq
    true
    ```
"""
==(p::WeightedPoint3, q::WeightedPoint3)

"""
    hx(p::WeightedPoint3)

Returns the homogeneous ``x`` coordinate.
"""
hx(p::WeightedPoint3)

"""
    hy(p::WeightedPoint3)

Returns the homogeneous ``y`` coordinate.
"""
hy(p::WeightedPoint3)

"""
    hz(p::WeightedPoint3)

Returns the homogeneous ``z`` coordinate.
"""
hz(p::WeightedPoint3)

"""
    hw(p::WeightedPoint3)

Returns the homogenizing coordinate.
"""
hw(p::WeightedPoint3)

"""
    x(p::WeightedPoint3)

Returns the Cartesian ``x`` coordinate, that is [`hx()`](@ref)/[`hw()`](@ref).
"""
x(p::WeightedPoint3)

"""
    y(p::WeightedPoint3)

Returns the Cartesian ``y`` coordinate, that is [`hy()`](@ref)/[`hw()`](@ref).
"""
y(p::WeightedPoint3)

"""
    z(p::WeightedPoint3)

Returns the Cartesian ``z`` coordinate, that is [`hz()`](@ref)/[`hw()`](@ref).
"""
z(p::WeightedPoint3)

@doc raw"""
    homogeneous(p::WeightedPoint3, i::Integer)

Returns the `i`ᵗʰ homogeneous coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``.
"""
homogeneous(p::WeightedPoint3, i::Integer)

@doc raw"""
    cartesian(p::WeightedPoint3, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``.
"""
cartesian(p::WeightedPoint3, i::Integer)

"""
    dimension(p::WeightedPoint3)

Returns the dimension (the constant 2).
"""
dimension(p::WeightedPoint3)

"""
    bbox(p::WeightedPoint3)

Returns a bounding box containing `p`.
"""
bbox(p::WeightedPoint3)

"""
    transform(p::WeightedPoint3, t::AffTransformation3)

Returns the weighted point obtained by applying `t` on `p`.
"""
transform(p::WeightedPoint3, t::AffTransformation3)
