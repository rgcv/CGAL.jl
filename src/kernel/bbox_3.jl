@doc raw"""
    Bbox3

An object `b` of the type [`Bbox3`](@ref) is a bounding box in the
three-dimensional Euclidean space ``Ε^3``.
"""
Bbox3

@doc raw"""
    Bbox3()

Introduces an *empty* bounding box with lower left corner point at ``(∞, ∞, ∞)``
and with upper right corner point at ``(-∞, -∞, -∞)``, ``∞`` being
[`Inf`](@ref).
"""
Bbox3()

"""
    Bbox3(xmin::Float64, ymin::Float64, zmin::Float64, xmax::Float64, ymax::Float64, zmax::Float64)
    Bbox3(xmin::Real, ymin::Real, zmin::Real, xmax::Real, ymax::Real, zmax::Real)

Introduces a bounding box `b` with lower left corner at `(xmin, ymin, zmin)` and
with upper right corner at `(xmax, ymax, zmax)`.
"""
Bbox3(xmin::Real, ymin::Real, zmin::Real, xmax::Real, ymax::Real, zmax::Real) =
    Bbox3(convert(Float64, xmin), convert(Float64, ymin), convert(Float64, zmin),
          convert(Float64, xmax), convert(Float64, ymax), convert(Float64, zmax))

"""
    dimension(b::Bbox3)

Returns 3.
"""
dimension(b::Bbox3)

"""
    min(b::Bbox3, i::Integer)

Returns [`xmin(b)`](@ref) if `i == 0` or [`ymin(b)`](@ref) if `i == 1` or
[`zmin(b)`](@ref) if `i == 2`.

!!! info "Precondition"

    `i >= 0` and `i <= 2`.
"""
min(b::Bbox3, i::Integer)


"""
    max(b::Bbox3, i::Integer)

Returns [`xmax(b)`](@ref) if `i == 0` or [`ymax(b)`](@ref) if `i == 1` or [`zmax(b)`](@ref) if `i == 2`.

!!! info "Precondition"

    `i >= 0` or `i <= 1`.
"""
max(b::Bbox3, i::Integer)

"""
    +(b::Bbox3, c::Bbox3)

Returns a bounding box of `b` and `c`.
"""
+(b::Bbox3, c::Bbox3)

"""
    dilate(b::Bbox3, dist::Integer)

Dilates the bounding box by a specified number of ULP.
"""
dilate(b::Bbox3, dist::Integer)
