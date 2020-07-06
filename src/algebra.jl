# abs, sign, and sqrt specialize Base's functions
export compare,
       integral_division,
       inverse,
       is_negative,
       # TODO: missing is_one
       is_positive,
       is_square,
       is_zero,
       sign,
       square,
       to_double,
       to_interval,
       unit_part

const NT = RT
export NT


"""
    compare(x::NT, y::NT)
    compare(x::Real, y::Real)

The function [`compare()`](@ref) compares the first argument with respect to the
second, i.e. it returns [`LARGER`](@ref) if ``x`` is larger than ``y``.
"""
compare(x::NT, y::NT)


"""
    integral_division(x::NT, y::NT)
    integral_division(x::Real, y::Real)

The function [`integral_division()`](@ref) (a.k.a. exact division or division
without remainder) maps ring elements ``(x, y)`` to ring element ``z`` such that
``x = yz`` if such a ``z`` exists (i.e. if ``x`` is divisible by ``y``).
"""
integral_division(x::NT, y::NT)


"""
    inverse(x::NT)
    inverse(x::Real)

The function [`inverse()`](@ref) returns the inverse element with respect to
multiplication.

!!! info "Precondition"

    ``x ≠ 0``.
"""
inverse(x::NT)


"""
    is_negative(x::NT)
    is_negative(x::Real)

The function [`is_negative()`](@ref) determines if a value is negative or not.
"""
is_negative(x::NT)


"""
    is_positive(x::NT)
    is_positive(x::Real)

The function [`is_positive()`](@ref) determines if a value is positive or not.
"""
is_positive(x::NT)


"""
    is_square(x::NT, y::Ref{NT} = Ref{NT}())

A ring element ``x`` is said to be a square iff there exists a ring element
``y`` such that ``x = y * y``.
"""
is_square(x::NT, y::Ref{NT} = Ref{NT}())


"""
    is_zero(x::NT)
    is_zero(x::Real)

The function [`is_zero()`](@ref) determines if a value is equal to 0 or not.
"""
is_zero(x::NT)

@cxxdereference Base.iszero(x::NT) = is_zero(x)


"""
    sign(x::NT)

The function [`sign()`](@ref) returns the sign of its argument.

See also: [`Sign`](@ref).
"""
sign(x::NT)


"""
    to_double(x::NT)

The function [`to_double()`](@ref) returns a double approximation of a number.
"""
to_double(x::NT)


"""
    to_interval(x::NT)

The function [`to_interval()`](@ref) computes for a given number ``x`` a double
interval containing ``x``.
"""
to_interval(x::NT)


"""
    unit_part(x::NT)

The function [`unit_part()`](@ref) computes the unit part of a given ring
element.
"""
unit_part(x::NT)
