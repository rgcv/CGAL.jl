@doc raw"""
    Direction2

An object `d` of the class [`Direction_2`](@ref) is a vector in the
two-dimensional vector space ``ℝ^2`` where we forget about its length.

They can be viewed as unit vectors, although there is no normalization
internally, since this is error prone. Directions are used whenever the
length of a vector does not matter. They also characterize a set of parallel
oriented lines that have the same orientations. For example, you can ask for
the direction orthogonal to an oriented plane, or the direction of an
oriented line. Further, they can be used to indicate angles. The slope of a
direction is [`dy()`](@ref)/[`dx()`](@ref).

There is a total order on directions.

We compare the angles between the positive ``x``-axis and the directions in
counterclockwise order.
"""
Direction2

"""
    Direction2(v::Vector2)

Introduces the direction `d` of vector `v`.
"""
Direction2(v::Vector2)

"""
    Direction2(l::Line2)

Introduces the direction `d` of line `l`.
"""
Direction2(l::Line2)

"""
    Direction2(r::Ray2)

Introduces the direction `d` of ray `r`.
"""
Direction2(r::Ray2)

"""
    Direction2(s::Segment2)

Introduces the direction `d` of segment `s`.
"""
Direction2(s::Segment2)

"""
    Direction2(x::Real, y::Real)

Introduces a direction `d` passing through the origin and the point with
Cartesian coordinates ``(x, y)``.
"""
Direction2(x::Real, y::Real) = Direction2(convert(FT, x), convert(FT, y))

@doc raw"""
    delta(d::Direction2, i::Integer)

Returns values, such that `d == [Direction2](@ref)(delta(d, 0), delta(d, 1))`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``
"""
delta(d::Direction2, i::Integer)

"""
    dx(d::Direction2)

Returns `delta(d, 0)`.
"""
dx(d::Direction2)

"""
    dy(d::Direction2)

Returns `delta(d, 1)`.
"""
dy(d::Direction2)

"""
    counterclockwise_in_between(d::Direction2, d1::Direction2, d2::Direction2)

Returns `true`, iff `d` is not equal to `d1`, and while rotating
counterclockwise starting at `d1`, `d` is reached strictly before `d2` is
reached.

Note that `true` is returned if `d1 == d2`, unless also `d == d1`.
"""
counterclockwise_in_between(d::Direction2, d1::Direction2, d2::Direction2)

"""
    -(d::Direction2)

The direction opposite to `d`.
"""
-(d::Direction2)

"""
    vector(d::Direction2)

Returns a vector that has the same direction as `d`.
"""
vector(d::Direction2)

"""
    transform(d::Direction2, t::AffTransformation2)

Returns the direction obtained by applying `t` on `d`.
"""
transform(d::Direction2, t::AffTransformation2)
