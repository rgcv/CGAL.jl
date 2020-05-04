@doc raw"""
    Direction3

An object `d` of the class [`Direction_2`](@ref) is a vector in the
three-dimensional vector space ``ℝ^3`` where we forget about its length.

They can be viewed as unit vectors, although there is no normalization
internally, since this is error prone. Directions are used whenever the
length of a vector does not matter. They also characterize a set of parallel
oriented lines that have the same orientations. For example, you can ask for
the direction orthogonal to an oriented plane, or the direction of an
oriented line.
"""
Direction3

"""
    Direction3(v::Vector3)

Introduces a direction `d` initialized with the direction of vector `v`.
"""
Direction3(v::Vector3)

"""
    Direction3(l::Line3)

Introduces the direction `d` of line `l`.
"""
Direction3(l::Line3)

"""
    Direction3(r::Ray3)

Introduces the direction `d` of ray `r`.
"""
Direction3(r::Ray3)

"""
    Direction3(s::Segment3)

Introduces the direction `d` of segment `s`.
"""
Direction3(s::Segment3)

"""
    Direction3(x::RT, y::RT, z::RT)
    Direction3(x::Real, y::Real, z::Real)

Introduces a direction `d` initialized with the direction from the origin and
the point with Cartesian coordinates ``(x, y, z)``.
"""
Direction3(x, y, z)

Direction3(x::Real, y::Real, z::Real) = Direction3(convert.(FT, (x, y, z))...)

@doc raw"""
    delta(d::Direction3, i::Integer)

Returns values, such that
`d == [Direction3](@ref)(delta(d, 0), delta(d, 1), delta(d, 3))`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``
"""
delta(d::Direction3, i::Integer)

"""
    dx(d::Direction3)

Returns `delta(d, 0)`.
"""
dx(d::Direction3)

"""
    dy(d::Direction3)

returns `delta(d, 1)`.
"""
dy(d::Direction3)

"""
    dz(d::Direction3)

returns `delta(d, 2)`.
"""
dz(d::Direction3)

"""
    -(d::Direction3)

The direction opposite to `d`.
"""
-(d::Direction3)

"""
    vector(d::Direction3)

Returns a vector that has the same direction as `d`.
"""
vector(d::Direction3)

"""
    transform(d::Direction3, t::AffTransformation2)

Returns the direction obtained by applying `t` on `d`.
"""
transform(d::Direction3, t::AffTransformation2)
