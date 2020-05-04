@doc raw"""
    AffTransformation2

Represents two-dimensional affine transformations.

The general form of an affine transformation is based on a homogeneous
representation of points. Thereby all transformations can be realized by matrix
multiplications.

Multiplying the transformation matrix by a scalar does not change the
represented transformation. Therefore, any transformation represented by a
matrix with rational entries can be represented by a transformation matrix with
integer entries as well. (Multiply the matrix with the common denominator of
the rational entries.) Hence, it is sufficient to use the number type
[`RT`](@ref) to represent the entries of the transformation matrix.

CGAL offers several specialized affine transformations. Different constructors
are provided to create them. They are paremeterized with a symbolic name to
denote the transformation type, followed by additional parameters. The symbolic
name tags solve ambiguities in the function overloading and they make the code
more readable, i.e., what type of transformation is created.

Since two-dimensional points have three homogeneous coordinates, we have a
``3 × 3`` matrix ``(m_{ij})_{i,j=0…2}``.

If the homogeneous representations are normalized (the homogenizing coordinate
is 1), then the upper left ``2 × 2`` matrix realizes linear transformations. In
the matrix form of a translation, the translation vector ``(v_0,\,v_1,\,1)``
appears in the last column of the matrix. The entries ``m_{20}`` and ``m_{21}``
are always zero and therefore do not appear in the constructors.

# Examples
```julia-repl
julia> for (A, T) ∈ ((:Transformation, AffTransformation2),
                      (:Point, Point2),
                      (:Vector, Vector2),
                      (:Direction, Direction2))
           @eval const $A = $T
       end

julia> rotate = Transformation(ROTATION, sin(π), cos(π))
Aff_TransformationC2(0, -1)

julia> rational_rotate = Transformation(ROTATION, Direction(1,1), 1, 100)
Aff_TransformationC2(0.710059, 0.704142)

julia> translate = Transformation(TRANSLATION, Vector(-2, 0))
Aff_TransformationC2(VectorC2(-2, 0))

julia> scale = Transformation(SCALING, 3)
Aff_TransformationC2(3)

julia> q = Point(0, 1)
PointC2(0, 1)

julia> q = rational_rotate(q)
PointC2(-0.710059, 0.704142)

julia> p = Point(1, 1)
PointC2(1, 1)

julia> p = rotate(p)
PointC2(-1, -1)

julia> p = translate(p)
PointC2(-3, -1)

julia> p = scale(p)
PointC2(-9, -3)
```

The same would have been achieved with

```julia-repl
julia> transform = scale * (translate * rotate)
Aff_TransformationC2(-3 0 -6
                     0 -2 0)

julia> p = transform(Point(1.0, 1.0))
PointC2(-9, -3)
```

See also: [`IdentityTransformation`](@ref), [`Rotation`](@ref),
[`Scaling`](@ref), [`Translation`](@ref), [`Reflection`](@ref),
[`rational_rotation_approximation`](@ref)
"""
AffTransformation2

"""
    AffTransformation2(::IdentityTransformation)

Introduces an identity transformation.
"""
AffTransformation2(::IdentityTransformation)

"""
    AffTransformation2(::Translation, v::Vector2)

Introduces a translation by vector `v`.
"""
AffTransformation2(::Translation, v::Vector2)

"""
    AffTransformation2(::Rotation, d::Direction2, num::RT, den::RT = RT(1))
    AffTransformation2(::Rotation, d::Direction2, num::Real, den::Real = 1)

Approximates the rotation over the angle indicated by direction `d`, such that
the differences between the sines and cosines of the rotation given by `d` and
the approximating rotation are at most `num/den` each.

!!! info "Precondition"

    ``num/den>0`` and ``d ≠ 0``.
"""
AffTransformation2(::Rotation, d::Direction2, num::RT, den::RT = RT(1))

@cxxdereference AffTransformation2(::Union{Rotation,Ref{Rotation}}, d::Direction2, num::Real, den::Real = 1) =
    AffTransformation2(ROTATION, d, convert.(FT, (num, den))...)

@doc raw"""
    AffTransformation2(::Rotation, sineᵨ::RT, cosineᵨ::RT, hw::RT = RT(1))
    AffTransformation2(::Rotation, sineᵨ::Real, cosineᵨ::Real, hw::Real = 1)

Introduces a rotation by the angle `ρ`.

!!! info "Precondition"

    ``sine_ρ^2 + cosine_ρ^2 = hw^2``.
"""
AffTransformation2(::Rotation, sinᵨ::RT, cosᵨ::RT, hw::RT = RT(1))

AffTransformation2(::Union{Rotation,Ref{Rotation}}, sinᵨ::Real, cosᵨ::Real, hw::Real = 1) =
    AffTransformation2(ROTATION, convert.(FT, (sinᵨ, cosᵨ, hw))...)

"""
    AffTransformation2(::Scaling, s::RT, hw::RT = RT(1))
    AffTransformation2(::Scaling, s::Real, hw::Real = 1)

Introduces a scaling by a scale factor ``s/hw``.
"""
AffTransformation2(::Scaling, s::RT, hw::RT = RT(1))

AffTransformation2(::Union{Scaling,Ref{Scaling}}, s::Real, hw::Real = 1) =
    AffTransformation2(SCALING, convert.(FT, (s, hw))...)

"""
    AffTransformation2(::Reflection, l::Line2)

Introduces a reflection by a line ``l``.
"""
AffTransformation2(::Reflection, l::Line2)

@doc raw"""
    AffTransformation2(m₀₀::RT, m₀₁::RT, m₀₂::RT,
                       m₁₀::RT, m₁₁::RT, m₁₂::RT,
                                                  hw::RT = RT(1))
    AffTransformation2(m₀₀::Real, m₀₁::Real, m₀₂::Real,
                       m₁₀::Real, m₁₁::Real, m₁₂::Real,
                                                        hw::Real = 1)

Introduces a general affine transformation in the ``3 × 3`` matrix form ``
\small\left(\begin{array}{ccc}
    m_{00} & m_{01} & m_{02} \\ m_{10} & m_{11} & m_{12} \\ 0 & 0 & hw
\end{array}\right)
``.

The sub-matrix ``
\frac{1}{hw}\small\left(\begin{array}{cc}
    m_{00} & m_{01} \\ m_{10} & m_{11}
\end{array}\right)
``
contains the scaling and rotation information, the vector ``
\small\left(\begin{array}{c}
    m_{02}\\ m_{12}
\end{array}\right)
``
contains the translational part of the transformation.
"""
AffTransformation2(m₀₀::RT, m₀₁::RT, m₀₂::RT,
                   m₁₀::RT, m₁₁::RT, m₁₂::RT,
                                              hw::RT = RT(1))

AffTransformation2(m₀₀::Real, m₀₁::Real, m₀₂::Real,
                   m₁₀::Real, m₁₁::Real, m₁₂::Real,
                                                    hw::Real = 1) =
    AffTransformation2(convert.(FT, (m₀₀, m₀₁, m₀₂,
                                     m₁₀, m₁₁, m₁₂,
                                                    hw))...)

@doc raw"""
    AffTransformation2(m₀₀::RT, m₀₁::RT,
                       m₁₀::RT, m₁₁::RT,
                                         hw::RT = RT(1))
    AffTransformation2(m₀₀::Real, m₀₁::Real,
                       m₁₀::Real, m₁₁::Real,
                                             hw::Real = 1)

Introduces a general linear transformation ``
\small\left(\begin{array}{ccc}
    m_{00} & m_{01} & 0 \\ m_{10} & m_{11} & 0 \\ 0 & 0 & hw
\end{array}\right)
``,
i.e. there is no translational part.
"""
AffTransformation2(m₀₀::RT, m₀₁::RT,
                   m₁₀::RT, m₁₁::RT,
                                     hw::RT = RT(1))

AffTransformation2(m₀₀::Real, m₀₁::Real,
                   m₁₀::Real, m₁₁::Real,
                                         hw::Real = 1) =
    AffTransformation2(convert.(FT, (m₀₀, m₀₁, m₁₀, m₁₁, hw))...)

"""
    transform(t::AffTransformation2, x::Union{Point2,Vector2,Direction2,Line2})
    (::AffTransformation2)(x::Union{Point2,Vector2,Direction2,Line2})

The [`transform`](@ref) function has methods for points, vectors, directions,
and lines. The same functionality is available through the invocation of
[`AffTransformation2`](@ref) instances.
"""
transform(t::AffTransformation2, p::Union{Point2,Vector2,Direction2,Line2}),
(::AffTransformation2)(p::Union{Point2,Vector2,Direction2,Line2})

"""
    *(t::AffTransformation2, s::AffTransformation2)

Composes two affine transformations.
"""
*(t::AffTransformation2, s::AffTransformation2)

"""
    inverse(t::AffTransformation2)

Gives the inverse transformation.
"""
inverse(t::AffTransformation2)

"""
    ==(t::AffTransformation2, s::AffTransformation2)

Compares two affine transformations.
"""
==(t::AffTransformation2, s::AffTransformation2)

"""
    is_even(t::AffTransformation2)

Returns `true`, if the transformation is not reflecting, i.e., the determinant
of the involved linear transformation is non-negative.
"""
is_even(t::AffTransformation2)

"""
    is_odd(t::AffTransformation2)

Returns `true`, if the transformation is reflecting.
"""
is_odd(t::AffTransformation2)

"""
    m(t::AffTransformation2, i::Integer, j::Integer)

Returns entry ``m_{ij}`` in a matrix representation in which ``m_{22}`` is 1.
"""
m(t::AffTransformation2, i::Integer, j::Integer)

"""
    hm(t::AffTransformation2, i::Integer, j::Integer)

Returns entry ``m_{ij}`` in some fixed matrix representation.
"""
hm(t::AffTransformation2, i::Integer, j::Integer)
