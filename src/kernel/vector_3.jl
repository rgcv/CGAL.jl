@doc raw"""
    Vector3

An object `v` of the type [`Vector3`](@ref) is a vector in the three-dimensional
vector space ``ℝ^3``.

Geometrically spoken, a vector is the difference of two points ``p_2, p_1`` and
and denotes the direction and the distance from ``p_1`` to ``p_2``.

CGAL defines a symbolic constant [`NULL_VECTOR`](@ref). We will explicitly
state where you can pass this constant as an argument instead of a vector
initialized with zeros.
"""
Vector3

"""
    Vector3(a::Point3, b::Point3)

Introduces the vector `b - a`.
"""
Vector3(a::Point3, b::Point3)

"""
    Vector3(s::Segment3)

Introduces the vector `target(s) - source(s)`.
"""
Vector3(s::Segment3)

"""
    Vector3()
    Vector3(NULL_VECTOR::NullVector)

Introduces a null vector `v`.
"""
Vector3()

"""
    Vector3(x::FT, y::FT, z::FT)
    Vector3(x::Real, y::Real, z::Real)

Introduces a vector `v` initialized to ``(x, y, z)``.
"""
Vector3(x, y, z)

@doc raw"""
    Vector3(hx::RT, hy::RT, hz::RT, hw::RT = RT(1))
    Vector3(hx::Real, hy::Real, hz::Real, hw::Real = 1)

Introduces a vector `v` initialized to `(hx/hw,hy/hw,hz/hw)`.

!!! info "Precondition"

    `hw` ``≠`` `RT(0)`
"""
Vector3(hx, hy, hz, hw)

Vector3(x::Real, y::Real, z::Real, hw::Real = 1) = isone(hw) ?
    Vector3(convert.(FT, (x, y, z))...) :
    Vector3(convert.(RT, (x, y, z, hw))...)

"""
    hx(p::Vector3)

Returns the homogeneous ``x`` coordinate.
"""
hx(p::Vector3)

"""
    hy(p::Vector3)

Returns the homogeneous ``y`` coordinate.
"""
hy(p::Vector3)

"""
    hz(p::Vector3)

Returns the homogeneous ``z`` coordinate.
"""
hz(p::Vector3)

"""
    hw(p::Vector3)

Returns the homogenizing coordinate.
"""
hw(p::Vector3)

"""
    x(p::Vector3)

Returns the Cartesian ``x`` coordinate, that is [`hx()`](@ref)/[`hw()`](@ref).
"""
x(p::Vector3)

"""
    y(p::Vector3)

Returns the Cartesian ``y`` coordinate, that is [`hy()`](@ref)/[`hw()`](@ref).
"""
y(p::Vector3)

"""
    z(p::Vector3)

Returns the Cartesian ``z`` coordinate, that is [`hz()`](@ref)/[`hw()`](@ref).
"""
z(p::Vector3)

@doc raw"""
    homogeneous(v::Vector3, i::Integer)

Returns the `i`ᵗʰ homogeneous coordinate of `v`.

!!! info "Precondition"

    ``0 ≤ i ≤ 3``.
"""
homogeneous(v::Vector3, i::Integer)

@doc raw"""
    cartesian(v::Vector3, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of `v`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``.
"""
cartesian(v::Vector3, i::Integer)

"""
    dimension(v::Vector3)

Returns the dimension (the constant 3).
"""
dimension(v::Vector3)

"""
    squared_length(v::Vector3)

Returns the squared length of `v`.
"""
squared_length(v::Vector3)

"""
    ==(v::Vector3, w::Vector3)

Test for equality: two vectors are equal, iff their ``x``, ``y`` and ``z``
coordinates are equal.

You can compare a vector with the `NULL_VECTOR`.
"""
==(v::Vector3, w::Vector3)

"""
    +(v::Vector3, w::Vector3)

Addition.
"""
+(v::Vector3, w::Vector3)

"""
    -(v::Vector3, w::Vector3)

Subtraction.
"""
-(v::Vector3, w::Vector3)

"""
    -(v::Vector3)

Returns the opposite vector.
"""
-(v::Vector3)

"""
    *(v::Vector3, w::Vector3)

Returns the scalar product (= inner product) of the two vectors.
"""
*(v::Vector3, w::Vector3)

"""
    /(v::Vector3, s::RT)
    /(v::Vector3, s::Real)

Division by a scalar.
"""
/(v::Vector3, s)

@cxxdereference Base.:/(v::Vector3, s::Real) = v / convert(RT, s)
