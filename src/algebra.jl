# abs, iszero, isone, sign, and sqrt specialize Base's functions
# specially, float masks to_double
export compare,
       integral_division,
       inverse,
       is_negative,
       is_positive,
       is_square,
       square,
       to_interval,
       unit_part

const NT = RT
export NT

if !iscxxtype(NT)
    for F ∈ (:abs, :sqrt, :float, :iszero, :isone, :sign)
        @eval Base.$F(x::Ref{NT}) = $F(x[])
    end
end

"""
    compare(x::NT, y::NT)

The function [`compare()`](@ref) compares the first argument with respect to the
second, i.e. it returns [`LARGER`](@ref) if ``x`` is larger than ``y``.
"""
compare(x::Real, y::Real) = compare(convert(NT, x), convert(NT, y))

"""
    integral_division(x::NT, y::NT)

The function [`integral_division()`](@ref) (a.k.a. exact division or division
without remainder) maps ring elements ``(x, y)`` to ring element ``z`` such that
``x = yz`` if such a ``z`` exists (i.e. if ``x`` is divisible by ``y``).
"""
integral_division(x::Real, y::Real) = integral_division(convert(NT, x),
                                                        convert(NT, y))

"""
    inverse(x::NT)

The function [`inverse()`](@ref) returns the inverse element with respect to
multiplication.

!!! info "Precondition"

    ``x ≠ 0``.
"""
inverse(x::Real) = inverse(convert(NT, x))

"""
    is_negative(x::NT)

The function [`is_negative()`](@ref) determines if a value is negative or not.
"""
is_negative(x::Real) = is_negative(convert(NT, x))

"""
    is_positive(x::NT)

The function [`is_positive()`](@ref) determines if a value is positive or not.
"""
is_positive(x::Real) = is_positive(convert(FT, x))

"""
    is_square(x::NT, y::Ref{NT} = Ref(0))

A ring element ``x`` is said to be a square iff there exists a ring element
``y`` such that ``x = y * y``.
"""
is_square(x::Real, y::Ref{Real} = Ref(0)) = is_square(convert(NT, x), Ref(convert(NT, y[])))

"""
    to_interval(x::NT)

The function [`to_interval()`](@ref) computes for a given number ``x`` a double
interval containing ``x``.
"""
to_interval(x::Real) = to_interval(convert(NT, x))

"""
    unit_part(x::NT)

The function [`unit_part()`](@ref) computes the unit part of a given ring
element.
"""
unit_part(x::Real) = unit_part(convert(NT, x))
