@doc raw"""
    AffTransformation3

Represents three-dimensional affine transformations.

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

In three-dimensional space we have a ``4 × 4`` matrix ``(m_{ij})_{i,j=0…3}``.
Entries ``m_{30}``, ``m_{31}``, and ``m_{30}`` are always zero and therefore do
not appear in the constructs.

See also: [`AffTransformation2`](@ref), [`IdentityTransformation`](@ref),
[`Rotation`](@ref), [`Scaling`](@ref), [`Translation`](@ref),
[`Reflection`](@ref), [`rational_rotation_approximation`](@ref)
"""
AffTransformation3

"""
    AffTransformation3(::IdentityTransformation)

Introduces an identity transformation.
"""
AffTransformation3(::IdentityTransformation)

"""
    AffTransformation3(::Translation, v::Vector3)

Introduces a translation by vector `v`.
"""
AffTransformation3(::Translation, v::Vector3)

"""
    AffTransformation3(::Scaling, s::Real, hw::Real = 1)

Introduces a scaling by a scale factor ``s/hw``.
"""
AffTransformation3(S::Scaling, s::Real, hw::Real = 1)

AffTransformation3(S, s::Real, hw::Real = 1) =
    AffTransformation3(S, convert(FT, s), convert(FT, hw))

@doc raw"""
    AffTransformation3(m₀₀::Real, m₀₁::Real, m₀₂::Real, m₀₃::Real,
                       m₁₀::Real, m₁₁::Real, m₁₂::Real, m₁₃::Real,
                       m₂₀::Real, m₂₁::Real, m₂₂::Real, m₂₃::Real,
                                                                   hw::Real = 1)

Introduces a general affine transformation in the matrix form ``
\small\left(\begin{array}{cccc}
    m_{00} & m_{01} & m_{02} & m_{03} \\ m_{10} & m_{11} & m_{12} & m_{13} \\ m_{20} & m_{21} & m_{22} & m_{23} \\ 0 & 0 & 0 & hw
\end{array}\right)
``.

The part ``
\frac{1}{hw}\small\left(\begin{array}{ccc}
    m_{00} & m_{01} & m_{02} \\ m_{10} & m_{11} & m_{12} \\ m_{20} & m_{21} & m_{22}
\end{array}\right)
``
defines the scaling and rotation part of the transformation, while the vector ``
\small\left(\begin{array}{c}
    m_{03} \\ m_{23} \\ m_{23}
\end{array}\right)
``
contains the translational part.
"""
AffTransformation3(m₀₀::Real, m₀₁::Real, m₀₂::Real, m₀₃::Real,
                   m₁₀::Real, m₁₁::Real, m₁₂::Real, m₁₃::Real,
                   m₂₀::Real, m₂₁::Real, m₂₂::Real, m₂₃::Real,
                                                               hw::Real = 1) =
    AffTransformation3(convert.(FT, (m₀₀, m₀₁, m₀₂, m₀₃,
                                     m₁₀, m₁₁, m₁₂, m₁₃,
                                     m₂₀, m₂₁, m₂₂, m₂₃,
                                                         hw))...)

@doc raw"""
    AffTransformation3(m₀₀::Real, m₀₁::Real, m₀₂::Real,
                       m₁₀::Real, m₁₁::Real, m₁₂::Real,
                       m₂₀::Real, m₂₁::Real, m₂₂::Real,
                                                        hw::Real = 1)

Introduces a general linear transformation ``
\small\left(\begin{array}{cccc}
    m_{00} & m_{01} & m_{02} & 0 \\ m_{10} & m_{11} & m_{12} & 0 \\ m_{20} & m_{21} & m_{22} & 0 \\ 0 & 0 & 0 & hw
\end{array}\right)
``,
i.e. an affine transformation without translational part.
"""
AffTransformation3(m₀₀::Real, m₀₁::Real, m₀₂::Real,
                   m₁₀::Real, m₁₁::Real, m₁₂::Real,
                   m₂₀::Real, m₂₁::Real, m₂₂::Real,
                                                    hw::Real = 1) =
    AffTransformation3(convert.(FT, (m₀₀, m₀₁, m₁₀, m₁₁, hw))...)

"""
    transform(t::AffTransformation3, x::Union{Point3,Vector3,Direction3,Line3})
    (::AffTransformation3)(x::Union{Point3,Vector3,Direction3,Line3})

The main thing to do with transformations is to apply them on geometric objects.

The transformations classes provide a [`transform`](@ref) function has methods
for points, vectors, directions, and planes. The same functionality is available
through the invocation of [`AffTransformation3`](@ref) instances.
"""
transform(t::AffTransformation3, p::Union{Point3,Vector3,Direction3,Plane3}),
(::AffTransformation3)(x::Union{Point3,Vector3,Direction3,Line3})

"""
    *(t::AffTransformation3, s::AffTransformation3)

Composes two affine transformations.
"""
*(t::AffTransformation3, s::AffTransformation3)

"""
    inverse(t::AffTransformation3)

Gives the inverse transformation.
"""
inverse(t::AffTransformation3)

"""
    ==(t::AffTransformation3, s::AffTransformation3)

Compares two affine transformations.
"""
==(t::AffTransformation3, s::AffTransformation3)

"""
    is_even(t::AffTransformation3)

Returns `true`, if the transformation is not reflecting, i.e., the determinant
of the involved linear transformation is non-negative.
"""
is_even(t::AffTransformation3)

"""
    is_odd(t::AffTransformation3)

Returns `true`, if the transformation is reflecting.
"""
is_odd(t::AffTransformation3)

"""
    m(t::AffTransformation3, i::Integer, j::Integer)

Returns entry ``m_{ij}`` in a matrix representation in which ``m_{22}`` is 1.
"""
m(t::AffTransformation3, i::Integer, j::Integer)

"""
    hm(t::AffTransformation3, i::Integer, j::Integer)

Returns entry ``m_{ij}`` in some fixed matrix representation.
"""
hm(t::AffTransformation3, i::Integer, j::Integer)
