@doc raw"""
    Bbox2

An object `b` of the type [`Bbox2`](@ref) is a bounding box in the
two-dimensional Euclidean plane ``Ε^2``.
"""
Bbox2

@doc raw"""
    Bbox2()

Introduces an *empty* bounding box with lower left corner point at ``(∞, ∞)``
and with upper right corner point at ``(-∞, -∞)``, ``∞`` being [`Inf`](@ref).
"""
Bbox2()

"""
    Bbox2(xmin::Float64, ymin::Float64, xmax::Float64, ymax::Float64)
    Bbox2(xmin::Real, ymin::Real, xmax::Real, ymax::Real)

Introduces a bounding box `b` with lower left corner at `(xmin, ymin)` and with
upper right corner at `(xmax, ymax)`.
"""
Bbox2(xmin, ymin, xmax, ymax)

Bbox2(xmin::Real, ymin::Real, xmax::Real, ymax::Real) =
    Bbox2(convert.(Float64, (xmin, ymin, xmax, ymax))...)

"""
    dimension(b::Bbox2)

Returns 2.
"""
dimension(b::Bbox2)

"""
    +(b::Bbox2, c::Bbox2)

Returns a bounding box of `b` and `c`.
"""
+(b::Bbox2, c::Bbox2)

"""
    min(b::Bbox2, i::Integer)

Returns [`xmin(b)`](@ref) if `i == 0` or [`ymin(b)`](@ref) if `i == 1`.

!!! info "Precondition"

    `i == 0` or `i == 1`.
"""
min(b::Bbox2, i::Integer)


"""
    max(b::Bbox2, i::Integer)

Returns [`xmax(b)`](@ref) if `i == 0` or [`ymax(b)`](@ref) if `i == 1`.

!!! info "Precondition"

    `i == 0` or `i == 1`.
"""
max(b::Bbox2, i::Integer)

"""
    dilate(b::Bbox2, dist::Integer)

Dilates the bounding box by a specified number of ULP.
"""
dilate(b::Bbox2, dist::Integer)
