@doc raw"""
    Vector2

An object `v` of the type [`Vector2`](@ref) is a vector in the two-dimensional
vector space ``ℝ^2``.

Geometrically spoken, a vector is the difference of two points ``p_2, p_1`` and
and denotes the direction and the distance from ``p_1`` to ``p_2``.

CGAL defines a symbolic constant [`NULL_VECTOR`](@ref). We will explicitly
state where you can pass this constant as an argument instead of a vector
initialized with zeros.
"""
Vector2

"""
    Vector2(a::Point2, b::Point2)

Introduces the vector `b - a`.
"""
Vector2(a::Point2, b::Point2)

"""
    Vector2(s::Segment2)

Introduces the vector `target(s) - source(s)`.
"""
Vector2(s::Segment2)

"""
    Vector2(r::Ray2)

Introduces the vector having the same direction as `r`.
"""
Vector2(r::Ray2)

"""
    Vector2(l::Line2)

Introduces the vector having the same direction as `t`.
"""
Vector2(l::Line2)

"""
    Vector2()
    Vector2(NULL_VECTOR::NullVector)

Introduces a null vector `v`.
"""
Vector2()

"""
    Vector2(x::FT, y::FT)
    Vector2(x::Real, y::Real)

Introduces a vector `v` initialized to ``(x, y)``.
"""
Vector2(x, y)

@doc raw"""
    Vector2(hx::RT, hy::RT, hw::RT = RT(1))
    Vector2(hx::Real, hy::Real, hw::Real = 1)

Introduces a vector `v` initialized to `(hx/hw,hy/hw)`.

!!! info "Precondition"

    `hw` ``≠`` `RT(0)`
"""
Vector2(hx, hy, hw)

Vector2(hx::Real, hy::Real, hw::Real = 1) = isone(hw) ?
    Vector2(convert.(FT, (hx, hy))...) :
    Vector2(convert.(RT, (hx, hy, hw))...)

"""
    hx(p::Vector2)

Returns the homogeneous ``x`` coordinate.
"""
hx(p::Vector2)

"""
    hy(p::Vector2)

Returns the homogeneous ``y`` coordinate.
"""
hy(p::Vector2)

"""
    hw(p::Vector2)

Returns the homogenizing coordinate.
"""
hw(p::Vector2)

"""
    x(p::Vector2)

Returns the Cartesian ``x`` coordinate, that is [`hx()`](@ref)/[`hw()`](@ref).
"""
x(p::Vector2)

"""
    y(p::Vector2)

Returns the Cartesian ``y`` coordinate, that is [`hy()`](@ref)/[`hw()`](@ref).
"""
y(p::Vector2)

@doc raw"""
    homogeneous(v::Vector2, i::Integer)

Returns the `i`ᵗʰ homogeneous coordinate of `v`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``.
"""
homogeneous(v::Vector2, i::Integer)

@doc raw"""
    cartesian(v::Vector2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of `v`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``.
"""
cartesian(v::Vector2, i::Integer)

"""
    dimension(v::Vector2)

Returns the dimension (the constant 2).
"""
dimension(v::Vector2)

"""
    direction(v::Vector2)

Returns the direction which passes through `v`.
"""
direction(v::Vector2)

"""
    transform(v::Vector2, t::AffTransformation2)

Returns the vector obtained by applying `t` on `v`.
"""
transform(v::Vector2, t::AffTransformation2)

"""
    perpendicular(v::Vector2, o::Orientation)

Returns the vector perpendicular to `v` in clockwise or counterclockwise
orientation.
"""
perpendicular(v::Vector2, o::Orientation)

"""
    squared_length(v::Vector2)

Returns the squared length of `v`.
"""
squared_length(v::Vector2)

"""
    ==(v::Vector2, w::Vector2)

Test for equality: two vectors are equal, iff their ``x`` and ``y`` coordinates
are equal.

You can compare a vector with the `NULL_VECTOR`.
"""
==(v::Vector2, w::Vector2)

"""
    +(v::Vector2, w::Vector2)

Addition.
"""
+(v::Vector2, w::Vector2)

"""
    -(v::Vector2, w::Vector2)

Subtraction.
"""
-(v::Vector2, w::Vector2)

"""
    -(v::Vector2)

Returns the opposite vector.
"""
-(v::Vector2)

"""
    *(v::Vector2, w::Vector2)

Returns the scalar product (= inner product) of the two vectors.
"""
*(v::Vector2, w::Vector2)

"""
    /(v::Vector2, s::RT)
    /(v::Vector2, s::Real)

Division by a scalar.
"""
/(v::Vector2, s)

@cxxdereference Base.:/(v::Vector2, s::Real) = v / convert(RT, s)
