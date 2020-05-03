@doc raw"""
    Point3

An object of the type [`Point3`](@ref) is a point in the three-dimensional
Euclidean space ``Ε^3``.
"""
Point3

"""
    Point3()
    Point3(ORIGIN::Origin)

Introduces a variable `p` with Cartesian coordinates ``(0, 0, 0)``.
"""
Point3()

"""
    Point3(x::FT, y::FT, z::FT)
    Point3(x::Real, y::Real, z::Real)

Introduces a point `p` initialized to ``(x, y, z)``.
"""
Point3(x, y, z)

@doc raw"""
    Point3(hx::RT, hy::RT, hz::RT, hw::RT = RT(1))
    Point3(hx::Real, hy::Real, hz::Real, hw::Real = 1)

Introduces a point `p` initialized to `(hx/hw,hy/hw,hz/hw)`.

!!! info "Precondition"

    `hw` ``≠`` `RT(0)`
"""
Point3(x, y, z, hw)

Point3(x::Real, y::Real, z::Real, hw::Real = 1) = isone(hw) ?
    Point3(convert.(FT, (x, y, z))...) :
    Point3(convert.(RT, (x, y, z, hw))...)

"""
    ==(p::Point3, q::Point3)

Test for equality.

Two points are equal, iff their ``x``, ``y`` and ``z`` coordinates are equal.
The point can be compared with [`ORIGIN`](@ref).
"""
==(p::Point3, q::Point3)

"""
    hx(p::Point3)

Returns the homogeneous ``x`` coordinate.
"""
hx(p::Point3)

"""
    hy(p::Point3)

Returns the homogeneous ``y`` coordinate.
"""
hy(p::Point3)

"""
    hz(p::Point3)

Returns the homogeneous ``z`` coordinate.
"""
hz(p::Point3)

"""
    hw(p::Point3)

Returns the homogenizing coordinate.
"""
hw(p::Point3)

"""
    x(p::Point3)

Returns the Cartesian ``x`` coordinate, that is [`hx()`](@ref)/[`hw()`](@ref).
"""
x(p::Point3)

"""
    y(p::Point3)

Returns the Cartesian ``y`` coordinate, that is [`hy()`](@ref)/[`hw()`](@ref).
"""
y(p::Point3)

"""
    z(p::Point3)

Returns the Cartesian ``y`` coordinate, that is [`hz()`](@ref)/[`hw()`](@ref).
"""
z(p::Point3)

@doc raw"""
    homogeneous(p::Point3, i::Integer)

Returns the `i`ᵗʰ homogeneous coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 3``.
"""
homogeneous(p::Point3, i::Integer)

@doc raw"""
    cartesian(p::Point3, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``.
"""
cartesian(p::Point3, i::Integer)

"""
    dimension(p::Point3)

Returns the dimension (the constant 3).
"""
dimension(p::Point3)

"""
    <(p::Point3, q::Point3)

Return `true` iff `p` is lexicographically smaller than `q` (the lexicographical
order being defined on the Cartesian coordinates).
"""
<(p::Point3, q::Point3)

"""
    >(p::Point3, q::Point3)

Return `true` iff `p` is lexicographically greater than `q`.
"""
>(p::Point3, q::Point3)

"""
    <=(p::Point3, q::Point3)

Return `true` iff `p` is lexicographically smaller or equal to `q`.
"""
<=(p::Point3, q::Point3)

"""
    >=(p::Point3, q::Point3)

Return `true` iff `p` is lexicographically greater or equal to `q`.
"""
>=(p::Point3, q::Point3)

"""
    -(p::Point3, q::Point3)

Returns the difference vector between `p` and `q`.

You can substitute [`ORIGIN`](@ref) for either `p` or `q`, but not for both.
"""
-(p::Point3, q::Point3)
