import CxxWrap: @cxxdereference

export IDENTITY,
       REFLECTION,
       ROTATION,
       SCALING,
       TRANSLATION

export FT, RT, FieldType, RingType

if !@isdefined FieldType
    const FieldType = Float64
end

# only true for cartesian kernels, see homogeneous kernels
const RingType = FieldType
const FT = FieldType
const RT = RingType

if FT !== Float64 # define a couple more constructors, convertions, promotions
    # upscaling
    FT(x::AbstractFloat) = FT(Float64(x))
    FT(x::Integer) = FT(Int64(x))
    # have one for Rational
    function FT(x::Rational)
        isinf(x) && return x*Inf # preserve sign
        convert(FT, x.num)/convert(FT, x.den)
    end

    Base.promote_rule(::Type{<:Union{FT,Ref{FT}}}, ::Type{<:Real}) = FT
    Base.promote_rule(::Type{<:Union{FT,Ref{FT}}}, ::Type{Real}) = Real

    Base.float(x::FT) = to_double(x)
    (::Type{T})(x::FT) where {T<:Real} = T(float(x))

    @cxxdereference Base.oftype(x::FT, y) = convert(FT, y)
    @cxxdereference Base.isinteger(x::FT) = isinteger(float(x))
else
    for op ∈ (:<, :<=, :>, :>=, :/, :+, :-, :*)
        @eval begin
            Base.$op(x::Ref{FT}, y::Ref{FT}) = $op(x[], y[]) # solves ambiguity
            Base.$op(x::Ref{FT}, y) = $op(x[], y)
            Base.$op(x, y::Ref{FT}) = $op(x, y[])
        end
    end
    Base.:+(x::Ref{FT}) = +x[]
    Base.:-(x::Ref{FT}) = -x[]
end

Base.convert(::Type{FT}, x::Ref{FT}) = x[]
Base.convert(::Type{T}, x::Ref{FT}) where {T<:Real} = convert(T, x[])

Base.float(x::Ref{FT}) = float(x[])
(::Type{T})(x::Ref{FT}) where {T<:Real} = T(float(x))
FT(x::Ref{FT}) = FT(x[])
Base.isnan(x::Ref{FT}) = isnan(x[])

export AffTransformation2,
       Bbox2,
       Circle2,
       Direction2,
       IsoRectangle2,
       Line2,
       Plane3,
       Point2, Point3,
       Ray2,
       Segment2, Segment3,
       Triangle2,
       Vector2, Vector3,
       WeightedPoint2

# min and max specialize Base's functions
export # Operations
       a, b, c, d,
       base1, base2,
       counterclockwise_in_between,
       delta,
       dilate,
       direction,
       dimension,
       dx, dy,
       xmin, ymin,
       xmax, ymax,
       min_coord, max_coord,
       opposite,
       point,
       projection,
       source,
       squared_length,
       supporting_line,
       target,
       to_vector,
       vertex,
       x_at_y, y_at_x,
       # 2D Conversion
       to_2d, to_3d,
       # Predicates
       bounded_side,
       collinear_has_on,
       has_on,
       has_on_boundary, has_on_bounded_side, has_on_unbounded_side,
       has_on_positive_side, has_on_negative_side,
       inverse,
       is_degenerate,
       is_even, is_odd,
       is_horizontal, is_vertical,
       orientation,
       oriented_side,
       orthogonal_transform,
       # Access Functions
       cartesian,
       center,
       dimension,
       homogeneous,
       hm, hw, hx, hy, hz,
       m, x, y, z,
       orientation,
       squared_radius,
       weight,
       # Miscellaneous
       area,
       bbox,
       direction,
       opposite,
       perpendicular,
       vector,
       to_vector,
       transform

# =====================================
# = AffTransformation2
# =====================================

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
    AffTransformation2(m₀₀::RT, m₀₁::RT, m₀₂::RT, m₁₀::RT, m₁₁::RT, m₁₂::RT, hw::RT = RT(1))
    AffTransformation2(m₀₀::Real, m₀₁::Real, m₀₂::Real, m₁₀::Real, m₁₁::Real, m₁₂::Real, hw::Real = 1)

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
AffTransformation2(m₀₀::RT, m₀₁::RT, m₀₂::RT, m₁₀::RT, m₁₁::RT, m₁₂::RT, hw::RT = RT(1))

AffTransformation2(m₀₀::Real, m₀₁::Real, m₀₂::Real, m₁₀::Real, m₁₁::Real, m₁₂::Real, hw::Real = 1) =
    AffTransformation2(convert.(FT, (m₀₀, m₀₁, m₀₂, m₁₀, m₁₁, m₁₂, hw))...)

@doc raw"""
    AffTransformation2(m₀₀::RT, m₀₁::RT, m₁₀::RT, m₁₁::RT, hw::RT = RT(1))
    AffTransformation2(m₀₀::Real, m₀₁::Real, m₁₀::Real, m₁₁::Real, hw::Real = 1)

Introduces a general linear transformation ``
\small\left(\begin{array}{ccc}
    m_{00} & m_{01} & 0 \\ m_{10} & m_{11} & 0 \\ 0 & 0 & hw
\end{array}\right)
``,
i.e. there is no translational part.
"""
AffTransformation2(m₀₀::RT, m₀₁::RT, m₁₀::RT, m₁₁::RT, hw::RT = RT(1))

AffTransformation2(m₀₀::Real, m₀₁::Real, m₁₀::Real, m₁₁::Real, hw::Real = 1) =
    AffTransformation2(convert.(FT, (m₀₀, m₀₁, m₁₀, m₁₁, hw))...)

"""
    transform(t::AffTransformation2, p::Point2)
    transform(t::AffTransformation2, v::Vector2)
    transform(t::AffTransformation2, d::Direction2)
    transform(t::AffTransformation2, l::Line2)

    (::AffTransformation2)(p::Point2)
    (::AffTransformation2)(v::Vector2)
    (::AffTransformation2)(d::Direction2)
    (::AffTransformation2)(l::Line2)

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


# =====================================
# = Bbox2
# =====================================

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
    ==(b::Bbox2, c::Bbox2)

Test for equality.
"""
==(b::Bbox2, c::Bbox2)

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
    dilate(b::Bbox2, dist::Integer)

Dilates the bounding box by a specified number of ULP.
"""
dilate(b::Bbox2, dist::Integer)


# =====================================
# = Circle2
# =====================================

@doc raw"""
    Circle2

An object `c` of type [`Circle2`](@ref) is a circle in the two-dimensional
Euclidean plane ``Ε^2``.

The circle is oriented, i.e. its boundary has clockwise or counterclockwise
orientation. The boundary splits ``Ε^2`` into a positive and a negative
side, where the positive side is to the left of the boundary. The boundary also
splits ``Ε^2`` into a bounded and an unbounded side. Note that the circle
can be degenerated, i.e. the squared radius may be zero.
"""
Circle2

@doc raw"""
    Circle2(center::Point2, squared_radius::FT, ori::Orientation = COUNTERCLOCKWISE)
    Circle2(center::Point2, squared_radius::Real, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `c` of type [`Circle2`](@ref).

It is initialized to the circle with center `center`, squared radius
`squared_radius`, and orientation `ori`.

!!! info "Precondition"

    `ori` ``≠`` `COLLINEAR`, and further, `squared_radius` ``≥ 0``.
"""
Circle2(center::Point2, squared_radius, ori::Orientation = COUNTERCLOCKWISE)

@cxxdereference Circle2(c::Point2, r²::Real, ori::Union{Orientation,Ref{Orientation}} = COUNTERCLOCKWISE) =
    Circle2(c, convert(FT, r²), ori)

@doc raw"""
    Circle2(p::Point2, q::Point2, r::Point2)

Introduces a variable `c` of type [`Circle2`](@ref).

It is initialized to the unique circle which passes through the points `p`, `q`
and `r`. The orientation of the circle is the orientation of the point triple
`p`, `q`, `r`.

!!! info "Precondition"

    `p`, `q`, and `r` are not collinear.
"""
Circle2(p::Point2, q::Point2, r::Point2)

@doc raw"""
    Circle2(p::Point2, q::Point2, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `c` of type [`Circle2`](@ref).

It is initialized to the circle with diameter ``\overline{pq}`` and orientation
`ori`.

!!! info "Precondition"

    `ori` ``≠`` `COLLINEAR`.
"""
Circle2(p::Point2, q::Point2, ori::Orientation = COUNTERCLOCKWISE)

@doc raw"""
    Circle2(p::Point2, ori::Orientation = COUNTERCLOCKWISE)

Introduces a variable `c` of type [`Circle2`](@ref).

It is initialized to the circle with center `center`, squared radius zero, and
orientation `ori`.

!!! info "Precondition"

    `ori` ``≠`` `COLLINEAR`.

!!! info "Postcondition"

    `is_degenerate(c) == true`.
"""
Circle2(p::Point2, ori::Orientation = COUNTERCLOCKWISE)

"""
    center(c::Circle2)

Returns the center of `c`.
"""
center(c::Circle2)

"""
    squared_radius(c::Circle2)

Returns the squared radius of `c`.
"""
squared_radius(c::Circle2)

"""
    orientation(c::Circle2)

Returns the orientation of `c`.
"""
orientation(c::Circle2)

"""
    ==(c::Circle2, circle2::Circle2)

Returns `true`, iff `c` and `circle2` are equal, i.e. if they have the same
center, same squared radius and same orientation.
"""
==(c::Circle2, circle2::Circle2)

"""
    is_degenerate(c::Circle2)

Returns `true`, iff `c` is degenerate, i.e. if `c` has squared radius zero.
"""
is_degenerate(c::Circle2)

"""
    oriented_side(c::Circle2, p::Point2)

Returns either the constant [`ON_ORIENTED_BOUNDARY`](@ref),
[`ON_POSITIVE_SIDE`](@ref), or [`ON_NEGATIVE_SIDE`](@ref), iff `p` lies on the
boundary, properly on the positive side, or properly on the negative side of
`c`, resp.
"""
oriented_side(c::Circle2, p::Point2)

"""
    bounded_side(c::Circle2, p::Point2)

Returns [`ON_BOUNDED_SIDE`](@ref), [`ON_BOUNDARY`](@ref), or
[`ON_UNBOUNDED_SIDE`](@ref) iff p lies properly inside, on the boundary, or
properly outside of c, resp.
"""
bounded_side(c::Circle2, p::Point2)

"""
    has_on_positive_side(c::Circle2, p::Point2)

Returns `true`, iff `p` lies on the positive side of `c`.
"""
has_on_positive_side(c::Circle2, p::Point2)

"""
    has_on_negative_side(c::Circle2, p::Point2)

Returns `true`, iff `p` lies on the negative side of `c`.
"""
has_on_negative_side(c::Circle2, p::Point2)

"""
    has_on_boundary(c::Circle2, p::Point2)

Returns `true`, iff `p` lies on the boundary of `c`.
"""
has_on_boundary(c::Circle2, p::Point2)

"""
    has_on_bounded_side(c::Circle2, p::Point2)

Returns `true`, iff `p` lies properly inside of `c`.
"""
has_on_bounded_side(c::Circle2, p::Point2)

"""
    has_on_unbounded_side(c::Circle2, p::Point2)

Returns `true`, iff `p` lies properly outside of `c`.
"""
has_on_unbounded_side(c::Circle2, p::Point2)

"""
    opposite(c::Circle2)

Returns the circle with the same center and squared radius as `c`, but with
opposite orientation.
"""
opposite(c::Circle2)

"""
    orthogonal_transform(c::Circle2, at::AffTransformation2)

Returns the circle obtained by applying `at` on `c`.

!!! info "Precondition"

    `at` is an orthogonal transformation.
"""
orthogonal_transform(c::Circle2, at::AffTransformation2)

"""
    bbox(c::Circle2)

Returns a bounding box containing `c`.
"""
bbox(c::Circle2)


# =====================================
# = Direction2
# =====================================

@doc raw"""
    Direction2

An object `d` of the class [`Direction_2`](@ref) is a vector in the
two-dimensional vector space ``ℝ^2`` where we forget about its length.

They can be viewed as unit vectors, although there is no normalization
internally, since this is error prone. Directions are used whenever the
length of a vector does not matter. They also characterize a set of parallel
oriented lines that have the same orientations. For example, you can ask for
the direction orthogonal to an oriented plane, or the direction of an
oriented line. Further, they can be used to indicate angles. The slope of a
direction is [`dy()`](@ref)/[`dx()`](@ref).

There is a total order on directions.

We compare the angles between the positive ``x``-axis and the directions in
counterclockwise order.
"""
Direction2

"""
    Direction2(v::Vector2)

Introduces the direction `d` of vector `v`.
"""
Direction2(v::Vector2)

"""
    Direction2(l::Line2)

Introduces the direction `d` of line `l`.
"""
Direction2(l::Line2)

"""
    Direction2(r::Ray2)

Introduces the direction `d` of line `r`.
"""
Direction2(r::Ray2)

"""
    Direction2(s::Segment2)

Introduces the direction `d` of segment `s`.
"""
Direction2(s::Segment2)

"""
    Direction2(x::RT, y::RT)
    Direction2(x::Real, y::Real)

Introduces a direction `d` passing through the origin and the point with
Cartesian coordinates ``(x, y)``.
"""
Direction2(x, y)

Direction2(x::Real, y::Real) = Direction2(convert.(FT, (x, y))...)

@doc raw"""
    delta(d::Direction2, i::Integer)

Returns values, such that `d == [Direction2](@ref)(delta(d, 0), delta(d, 1))`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``
"""
delta(d::Direction2, i::Integer)

"""
    counterclockwise_in_between(d::Direction2, d1::Direction2, d2::Direction2)

Returns `true`, iff `d` is not equal to `d1`, and while rotating
counterclockwise starting at `d1`, `d` is reached strictly before `d2` is
reached.

Note that `true` is returned if `d1 == d2`, unless also `d == d1`.
"""
counterclockwise_in_between(d::Direction2, d1::Direction2, d2::Direction2)

"""
    -(d::Direction2)

The direction opposite to `d`.
"""
-(d::Direction2)

"""
    vector(d::Direction2)

Returns a vector that has the same direction as `d`.
"""
vector(d::Direction2)

"""
    transform(d::Direction2, t::AffTransformation2)

Returns the direction obtained by applying `t` on `d`.
"""
transform(d::Direction2, t::AffTransformation2)


# =====================================
# = IsoRectangle2
# =====================================

@doc raw"""
    IsoRectangle2

An object `r` of the data type [`IsoRectangle2`](@ref) is a rectangle in the
Euclidean plane ``Ε^2`` with sides parallel to the ``x`` and ``y`` axis
of the coordinate system.

Although they are represented in a canonical form by only two vertices, namely
the lower left and the upper right vertex, we provide functions for "accessing"
the other vertices as well. The vertices are returned in counterclockwise order.

Iso-oriented rectangles and bounding boxes are quite similar. The difference
however is that bounding boxes have always double coordinates, whereas the
coordinate type of an iso-oriented rectangle is chosen by the user.
"""
IsoRectangle2

"""
    IsoRectangle2(p::Point2, q::Point2)

Introduces an iso-oriented rectangle `r` with diagonal opposite vertices `p` and
`q`.

Note that the object is brought in the canonical form.
"""
IsoRectangle2(p::Point2, q::Point2)

"""
    IsoRectangle2(p::Point2, q::Point2, ::Integer)

Introduces an iso-oriented rectangle `r` with diagonal opposite vertices `p` and
`q`.

Note that the object is brought in the canonical form.
"""
IsoRectangle2(p::Point2, q::Point2, ::Integer)

@doc raw"""
    IsoRectangle(left::Point2, right::Point2, bottom::Point2, top::Point2)

Introduces an iso-oriented rectangle `r` whose minimal ``x`` coordinate is the
one of `left`, the maximal ``x`` coordinate is the one of `right`, the minimal
``y`` coordinate is the one of `bottom`, the maximal ``y`` coordinate is the one
of ``top``.
"""
IsoRectangle(left::Point2, right::Point2, bottom::Point2, top::Point2)

"""
    IsoRectangle(min_hx::RT, min_hy::RT, max_hx::RT, max_hy::RT, hw::RT = RT(1))
    IsoRectangle(min_hx::Real, min_hy::Real, max_hx::Real, max_hy::Real, hw::Real = 1)

Introduces an iso-oriented rectangle `r` with diagonal opposite vertices
`(min_hx/hw, min_hy/hw)` and `(max_hx/hw, max_hy/hw)`.

!!! info "Precondition"

    `hw` ``≠`` `0`.
"""
IsoRectangle2(min_hx, min_hy, max_hx, max_hy, hw = 1)

IsoRectangle2(min_hx::Real, min_hy::Real, max_hx::Real, max_hy::Real, hw::Real = 1) =
    IsoRectangle2(convert.(FT, (min_hx, min_hy, max_hx, max_hy, hw))...)

"""
    IsoRectangle2(bbox::Bbox2)

If [`RT`](@ref) is constructible from `Float64`, introduces an iso-oriented
rectangle from `bbox`.
"""
IsoRectangle2(bbox::Bbox2)

"""
    ==(r::IsoRectangle2, r2::IsoRectangle2)

Test for equality: two iso-oriented rectangles are equal, iff their lower left
and upper right vertices are equal.
"""
==(r::IsoRectangle2, r2::IsoRectangle2)

"""
    vertex(r::IsoRectangle2, i::Integer)

Returns the `i`ᵗʰ vertex modulo 4 of `r` in counterclockwise order, starting
with the lower left vertex.
"""
vertex(r::IsoRectangle2, i::Integer)

"""
    min(r::IsoRectangle2)

Returns the lower left vertex of `r` (= `vertex(r, 0)`).
"""
min(r::IsoRectangle2)

"""
    max(r::IsoRectangle2)

Returns the upper right vertex of `r` (= `vertex(r, 2)`).
"""
max(r::IsoRectangle2)

"""
    xmin(r::IsoRectangle2)

Returns the ``x`` coordinate of the lower left vertex of `r`.
"""
xmin(r::IsoRectangle2)

"""
    ymin(r::IsoRectangle2)

Returns the ``y`` coordinate of the lower left vertex of `r`.
"""
ymin(r::IsoRectangle2)

"""
    xmax(r::IsoRectangle2)

Returns the ``x`` coordinate of the upper right vertex of `r`.
"""
xmax(r::IsoRectangle2)

"""
    ymax(r::IsoRectangle2)

Returns the ``y`` coordinate of the upper right vertex of `r`.
"""
ymax(r::IsoRectangle2)

"""
    min_coord(r::IsoRectangle2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of the lower left vertex of `r`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``
"""
min_coord(r::IsoRectangle2, i::Integer)

"""
    max_coord(r::IsoRectangle2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of the upper right vertex of `r`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``
"""
max_coord(r::IsoRectangle2, i::Integer)

"""
    is_degenerate(r::IsoRectangle2)

`r` is degenerate, if all vertices are collinear.
"""
is_degenerate(r::IsoRectangle2)

"""
    bounded_side(r::IsoRectangle2, p::Point2)

Returns either [`ON_UNBOUNDED_SIDE`](@ref), [`ON_BOUNDED_SIDE`](@ref), or the
constant [`ON_BOUNDARY`](@ref), depending on where point `p` is.
"""
bounded_side(r::IsoRectangle2, p::Point2)

"""
    has_on_boundary(r::IsoRectangle2, p::Point2)

Returns `true`, iff `p` lies on the boundary of `r`.
"""
has_on_boundary(c::IsoRectangle2, p::Point2)

"""
    has_on_bounded_side(r::IsoRectangle2, p::Point2)

Returns `true`, iff `p` lies properly inside of `r`.
"""
has_on_bounded_side(c::IsoRectangle2, p::Point2)

"""
    has_on_unbounded_side(r::IsoRectangle2, p::Point2)

Returns `true`, iff `p` lies properly outside of `r`.
"""
has_on_unbounded_side(c::IsoRectangle2, p::Point2)

"""
    area(r::IsoRectangle2)

Returns the area of `r`.
"""
area(r::IsoRectangle2)

"""
    bbox(r::IsoRectangle2)

Returns a bounding box containing `r`.
"""
bbox(r::IsoRectangle2)

@doc raw"""
    transform(t::AffTransformation2)

Returns the iso-oriented rectangle obtained by applying `t` on the lower left
and upper right corner of `r`.

!!! info "Precondition"

    The angle at a rotation must be a multiple of ``π \over 2``, otherwise the
    resulting rectangle does not have the same side length. Note that rotating
    about an arbitrary angle can even result in a degenerate iso-oriented
    rectangle.
"""
transform(t::AffTransformation2)


# =====================================
# = Line2
# =====================================

@doc raw"""
    Line2

An object `l` of the data type [`Line2`](@ref) is a directed straight line in
the two-dimensional Euclidean plane ``Ε^2``.

It is defined by the set of points with Cartesian coordinates ``(x, y)`` that
satisfy the equation

```math
    l:\; a\, x + b\, y + c = 0.
```

The line splits ``Ε^2`` in a *positive* and a *negative* side. A point p with
Cartesian coordinates ``(px, py)`` is on the positive side of `l`, iff
``a\, px + b\, py + c > 0``, it is on the negative side of `l`, iff
``a\, px + b\, py + c < 0``. The positive side is to the left of `l`.

# Example

Let us first define two Cartesian two-dimensional points in the Euclidean place
``Ε^2``. Their dimension and the fact that they are Cartesian is expressed by
the suffix `2` and the `C2` suffix in their representation.

```jldoctest
julia> p, q = Point2(1.0,1.0), Point2(4.0,7.0)
(PointC2(1, 1), PointC2(4, 7))
```

To define a line `l` we write:

```jldoctest
julia> l = Line2(p,q)
Line_2(-6, 3, 3)
```
"""
Line2

"""
    Line2(a::RT, b::RT, c::RT)
    Line2(a::Real, b::Real, c::Real)

Introduces a line `l` with the line equation in Cartesian coordinates
``ax + by + c = 0``.
"""
Line2(a, b, c)

Line2(a::Real, b::Real, c::Real) = Line2(convert.(FT, (a, b, c))...)

"""
    Line2(p::Point2, q::Point2)

Introduces a line `l` passing through the points `p` and `q`.

Line `l` is directed from `p` to `q`.
"""
Line2(p::Point2, q::Point2)

"""
    Line2(p::Point2, d::Direction2)

Introduces a line `l` passing through point `p` with direction `d`.
"""
Line2(p::Point2, d::Direction2)

"""
    Line2(p::Point2, d::Vector2)

Introduces a line `l` passing through point `p` and oriented by `v`.
"""
Line2(p::Point2, v::Vector2)

"""
    Line2(s::Segment2)

Introduces a line `l` supporting the segment `s`, oriented from source to
target.
"""
Line2(s::Segment2)

"""
    Line2(r::Ray2)

Introduces a line `l` supporting the ray `r`, with same orientation.
"""
Line2(r::Ray2)

"""
    ==(l::Line2, h::Line2)

Test for equality: two lines are equal, iff they have a non empty intersection
and the same direction.
"""
==(l::Line2, h::Line2)

"""
    a(l::Line2)

Returns the first coefficient of `l`.
"""
a(l::Line2)

"""
    b(l::Line2)

Returns the second coefficient of `l`.
"""
b(l::Line2)

"""
    c(l::Line2)

Returns the third coefficient of `l`.
"""
c(l::Line2)

"""
    point(l::Line2, i::FT)
    point(l::Line2, i::Real)

Returns an arbitrary point on `l`.

It holds `point(l, i) == point(l, j)`, iff `i == j`. Furthermore, `l` is
directed from `point(l, i)` to `point(l, j)`, for all `i` ``<`` `j`.
"""
point(l::Line2, i)

@cxxdereference point(l::Line2, i::Real) = point(l, convert(FT, i))

"""
    projection(l::Line2, p::Point2)

Returns the orthogonal projection of `p` onto `l`.
"""
projection(l::Line2, p::Point2)

"""
    x_at_y(l::Line2, y::FT)
    x_at_y(l::Line2, y::Real)

Returns the ``x``-coordinate of the point at `l` with the given
``y``-coordinate.

!!! info "Precondition"

    `l` is not horizontal.
"""
x_at_y(l::Line2, y)

@cxxdereference x_at_y(l::Line2, y::Real) = x_at_y(l, convert(FT, y))

"""
    y_at_x(l::Line2, x::FT)
    y_at_x(l::Line2, x::Real)

Returns the ``y``-coordinate of the point at `l` with the given
``x``-coordinate.

!!! info "Precondition"

    `l` is not vertical.
"""
y_at_x(l::Line2, x)

@cxxdereference y_at_x(l::Line2, x::Real) = y_at_x(l, convert(FT, x))

"""
    is_degenerate(l::Line2)

Line `l` is degenerate, if the coefficients `a` and `b` of the line equation are
zero.
"""
is_degenerate(l::Line2)

"""
    is_horizontal(l::Line2)

Line `l` is horizontal, if coefficient `a` of the line equation is zero.
"""
is_horizontal(l::Line2)

"""
    is_vertical(l::Line2)

Line `l` is horizontal, if coefficient `b` of the line equation is zero.
"""
is_vertical(l::Line2)

"""
    oriented_side(l::Line2, p::Point2)

Returns [`ON_ORIENTED_BOUNDARY`](@ref), [`ON_NEGATIVE_SIDE`](@ref), or the
constant [`ON_POSITIVE_SIDE`](@ref), depending on the position of `p` relative
to the oriented line `l`.
"""
oriented_side(l::Line2, p::Point2)

"""
    has_on(l::Line2, p::Point2)

Returns `true`, iff `p` lies properly on `l`.
"""
has_on(l::Line2, p::Point2)

"""
    has_on_positive_side(l::Line2, p::Point2)

Returns `true`, iff `p` lies on the positive side of `l`.
"""
has_on_positive_side(l::Line2, p::Point2)

"""
    has_on_negative_side(l::Line2, p::Point2)

Returns `true`, iff `p` lies on the negative side of `l`.
"""
has_on_negative_side(c::Line2, p::Point2)

"""
    to_vector(l::Line2)

Returns a vector having the direction of `l`.
"""
to_vector(l::Line2)

"""
    direction(l::Line2)

Returns the direction of `l`.
"""
direction(l::Line2)

"""
    opposite(l::Line2)

Returns the line with opposite direction.
"""
opposite(l::Line2)

"""
    perpendicular(l::Line2, p::Point2)

Returns the line perpendicular to `l` and passing through `p`, where the
direction is the direction of `l` rotate counterclockwise by 90 degrees.
"""
perpendicular(l::Line2, p::Point2)

"""
    transform(l::Line2, t::AffTransformation2)

Returns the line obtained by applying `t` on a point on `l` and the direction of
`l`.
"""
transform(l::Line2, t::AffTransformation2)

@doc raw"""
    Plane3

An object `h` of the data type [`Plane3`](@ref) is an oriented plane in the
three-dimensional Euclidean space ``Ε^3``.

It is defined by the set of points with Cartesian coordinates ``(x,y,z)`` that
satisfy the plane equation

```math
    h:\; a\, x + b\, y + c\, z + d = 0.
```

The plane splits ``Ε^3`` in a *positive* and a *negative side*. A point `p` with
Cartesian coordinates ``(px, py, pz)`` is on the positive side of `h`, iff
``a\, px + b\, py + c\, pz + d > 0``. It is on the negative side, iff
``a\, px + b\, py + c\, pz + d < 0``.
"""
Plane3

@doc raw"""
    Plane3(a::RT, b::RT, c::RT, d::RT)
    Plane3(a::Real, b::Real, c::Real, d::Real)

Create a plane `h` defined by the equation ``a\, px + b\, py + c\, pz + d = 0``.

Notice that `h` is degenerate if ``a = b = c = 0``.
"""
Plane3(a, b, c, d)

Plane3(a::Real, b::Real, c::Real, d::Real) =
    Plane3(convert.(FT, (a, b, c, d))...)

"""
    Plane3(p::Point3, q::Point3, r::Point3)

Create a plane `h` passing through the points `p`, `q`, and `r`.

The plane is oriented such that `p`, `q` and `r` are oriented in a positive
sense (that is counterclockwise) when seen form the positive side of `h`. Notice
that `h` is degenerate if the points are collinear.
"""
Plane3(p::Point3, q::Point3, r::Point3)


"""
    Plane3(p::Point3, v::Vector3)

Introduces a plane `h` that passes through point `p` and that is orthogonal to
`v`.
"""
Plane3(p::Point3, v::Vector3)

"""
    Plane3(s::Segment3, p::Point3)

Introduces a plane `h` that is defined through the three points `source(s)`,
`target(s)` and `p`.
"""
Plane3(s::Segment3, p::Point3)

"""
    ==(h::Plane3, h2::Plane3)

Test for equality: two planes are equal, iff they have a non empty intersection
and the same orientation.
"""
==(h::Plane3, h2::Plane3)

"""
    a(h::Plane3)

Returns the first coefficient of `h`.
"""
a(h::Plane3)

"""
    b(h::Plane3)

Returns the second coefficient of `h`.
"""
b(h::Plane3)

"""
    c(h::Plane3)

Returns the third coefficient of `h`.
"""
c(h::Plane3)

"""
    d(h::Plane3)

Returns the fourth coefficient of `h`.
"""
d(h::Plane3)

"""
    projection(h::Plane3, p::Point3)

Returns the orthogonal projection of `p` on `h`.
"""
projection(h::Plane3, p::Point3)

"""
    opposite(h::Plane3)

Returns the plane with opposite orientation.
"""
opposite(h::Plane3)

"""
    point(h::Plane3)

Returns an arbitrary point on `h`.
"""
point(h::Plane3)

"""
    base1(h::Plane3)

Returns a vector orthogonal to [`orthogonal_vector()`](@ref).
"""
base1(h::Plane3)

"""
    base2(h::Plane3)

Returns a vector that is both orthogonal to [`base1()`](@ref), and to
[`orthogonal_vector()`](@ref), and such that the result of `orientation(
point(h), point(h) + base1(h), point(h) +
base2(h), point(h) + orthogonal_vector(h) )` is positive.
"""
base2(h::Plane3)

"""
    to_2d(h::Plane3, p::Point3)

Returns the image point of the projection of `p` under an affine transformation,
which maps `h` onto the ``xy``-plane, with the ``z``-coordinate removed.
"""
to_2d(h::Plane3, p::Point3)

"""
    to_3d(h::Plane3, p::Point2)

Returns a point `q`, such that `to_2d(h, to_3d(h, p))` is equal to `p`.
"""
to_3d(h::Plane3, p::Point2)

"""
    oriented_side(h::Plane3, p::Point3)

Returns either [`ON_ORIENTED_BOUNDARY`](@ref), or the constant
[`ON_POSITIVE_SIDE`](@ref), or the constant [`ON_NEGATIVE_SIDE`](@ref),
determined by the position of `p` relative to the oriented plane `h`.
"""
oriented_side(h::Plane3, p::Point3)

"""
    has_on(h::Plane3, p::Point3)

Returns `true`, iff `p` properly lies on `h`.
"""
has_on(h::Plane3, p::Point3)

"""
    has_on_positive_side(h::Plane3, p::Point3)

Returns `true`, iff `p` lies on the positive side of `h`.
"""
has_on_positive_side(h::Plane3, p::Point3)

"""
    has_on_negative_side(h::Plane3, p::Point3)

Returns `true`, iff `p` lies on the negative side of `h`.
"""
has_on_negative_side(h::Plane3, p::Point3)

"""
    is_degenerate(h::Plane3)

Plane `h` is degenerate, if the coefficients `a`, `b`, and `c` of the plane
equation are zero.
"""
is_degenerate(h::Plane3)


# =====================================
# = Point2
# =====================================

@doc raw"""
    Point2

An object `p` of the type [`Point2`](@ref) is a point in the two-dimensional
Euclidean plane ``Ε^2``.

# Example

The following declaration creates two points with Cartesian coordinates.

```julia-repl
julia> p, q = Point2(), Point2(1.0, 2.0)
(PointC2(0, 0), PointC2(1, 2))
```
"""
Point2

"""
    Point2()
    Point2(ORIGIN::Origin)

Introduces a variable `p` with Cartesian coordinates ``(0, 0)``.
"""
Point2()

"""
    Point2(x::FT, y::FT)
    Point2(x::Real, y::Real)

Introduces a point `p` initialized to ``(x, y)``.
"""
Point2(x, y)

@doc raw"""
    Point2(x::RT, y::RT, hw::RT = RT(1))
    Point2(x::Real, y::Real, hw::Real = 1)

Introduces a point `p` initialized to `(hx/hw,hy/hw)`.

!!! info "Precondition"

    `hw` ``≠`` `RT(0)`
"""
Point2(x, y, hw)

Point2(x::Real, y::Real, hw::Real = 1) = isone(hw) ?
    Point2(convert.(FT, (x, y))...) :
    Point2(convert.(RT, (x, y, hw))...)

"""
    Point2(wp::WeightedPoint2)

Introduces a point from a weighted point.
"""
Point2(wp::WeightedPoint2)

"""
    ==(p::Point2, q::Point2)

Test for equality.

Two points are equal, iff their ``x`` and ``y`` coordinates are equal. The point
can be compared with [`ORIGIN`](@ref).
"""
==(p::Point2, q::Point2)

"""
    hx(p::Point2)

Returns the homogeneous ``x`` coordinate.
"""
hx(p::Point2)

"""
    hy(p::Point2)

Returns the homogeneous ``y`` coordinate.
"""
hy(p::Point2)

"""
    hw(p::Point2)

Returns the homogenizing coordinate.
"""
hw(p::Point2)

"""
    x(p::Point2)

Returns the Cartesian ``x`` coordinate, that is [`hx()`](@ref)/[`hw()`](@ref).
"""
x(p::Point2)

"""
    y(p::Point2)

Returns the Cartesian ``y`` coordinate, that is [`hy()`](@ref)/[`hw()`](@ref).
"""
y(p::Point2)

@doc raw"""
    homogeneous(p::Point2, i::Integer)

Returns the `i`ᵗʰ homogeneous coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``.
"""
homogeneous(p::Point2, i::Integer)

@doc raw"""
    cartesian(p::Point2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``.
"""
cartesian(p::Point2, i::Integer)

"""
    dimension(p::Point2)

Returns the dimension (the constant 2).
"""
dimension(p::Point2)

"""
    bbox(p::Point2)

Returns a bounding box containing `p`.
"""
bbox(p::Point2)

"""
    transform(p::Point2, t::AffTransformation2)

Returns the point obtained by applying `t` on `p`.
"""
transform(p::Point2, t::AffTransformation2)

"""
    <(p::Point2, q::Point2)

Return `true` iff `p` is lexicographically smaller than `q`, i.e. either if
`x(p) < x(q)` or if `x(p) == x(q)` and `y(p) < y(q)`.
"""
<(p::Point2, q::Point2)

"""
    >(p::Point2, q::Point2)

Return `true` iff `p` is lexicographically greater than `q`.
"""
>(p::Point2, q::Point2)

"""
    <=(p::Point2, q::Point2)

Return `true` iff `p` is lexicographically smaller or equal to `q`.
"""
<=(p::Point2, q::Point2)

"""
    >=(p::Point2, q::Point2)

Return `true` iff `p` is lexicographically greater or equal to `q`.
"""
>=(p::Point2, q::Point2)

"""
    -(p::Point2, q::Point2)

Returns the difference vector between `p` and `q`.

You can substitute [`ORIGIN`](@ref) for either `p` or `q`, but not for both.
"""
-(p::Point2, q::Point2)


# =====================================
# = Point3
# =====================================

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


# =====================================
# = Ray2
# =====================================

@doc raw"""
    Ray2

An object `r` of the data type [`Ray2`](@ref) is a directed straight ray in the
two-dimensional Euclidean plane ``Ε^2``.

It starts in a point called the *source* of `r` and goes to infinity.
"""
Ray2

"""
    Ray2(p::Point2, q::Point2)

Introduces a ray `r` with source `p` and passing through point `q`.
"""
Ray2(p::Point2, q::Point2)

"""
    Ray2(p::Point2, d::Direction2)

Introduces a ray `r` starting at source `p` with direction `d`.
"""
Ray2(p::Point2, d::Direction2)

"""
    Ray2(p::Point2, v::Vector2)

Introduces a ray `r` starting at source `p` with the direction of `v`.
"""
Ray2(p::Point2, v::Vector2)

"""
    Ray2(p::Point2, l::Line2)

Introduces a ray `r` starting at source `p` with the same direction as `l`.
"""
Ray2(p::Point2, l::Line2)

"""
    ==(r::Ray2, h::Ray2)

Test for equality: two rays are equal, iff they have the same source and the
same direction.
"""
==(r::Ray2, h::Ray2)

"""
    source(r::Ray2)

Returns the source of `r`.
"""
source(r::Ray2)

@doc raw"""
    point(r::Ray2, i::FT)
    point(r::Ray2, i::Real)

Returns a point on `r`.

!!! info "Precondition"

    ``i ≥ 0``.
"""
point(r::Ray2, i)

@cxxdereference point(r::Ray2, i::Real) = point(r, convert(FT, i))

"""
    direction(r::Ray2)

Returns the direction of `r`.
"""
direction(r::Ray2)

"""
    to_vector(r::Ray2)

Returns a vector giving the direction of `r`.
"""
to_vector(r::Ray2)

"""
    supporting_line(r::Ray2)

Returns the line supporting `r` which has the same direction.
"""
supporting_line(r::Ray2)

"""
    opposite(r::Ray2)

Returns the ray with the same source and opposite direction.
"""
opposite(r::Ray2)

"""
    is_degenerate(r::Ray2)

Ray `r` is degenerate, if the source and the second defining point fall
together (that is if the direction is degenerate).
"""
is_degenerate(r::Ray2)

"""
    is_horizontal(r::Ray2)

Ray `r` is horizontal, if coefficient `a` of the supporting line's equation is
zero.
"""
is_horizontal(r::Ray2)

"""
    is_vertical(r::Ray2)

Ray `r` is vertical, if coefficient `b` of the supporting line's equation is
zero.
"""
is_vertical(r::Ray2)

"""
    has_on(r::Ray2, p::Point2)

A point is on `r`, iff it is equal to the source of `r`, or if it is in the
interior of `r`.
"""
has_on(r::Ray2, p::Point2)

"""
    collinear_has_on(r::Ray2, p::Point2)

Checks if point `p` is on `r`.

!!! info "Precondition"

    `p` is on the supporting line of `r`.
"""
collinear_has_on(r::Ray2, p::Point2)

"""
    transform(r::Ray2, t::AffTransformation2)

Returns the ray obtained by applying `t` on the source and on the direction of
`r`.
"""
transform(r::Ray2, t::AffTransformation2)


# =====================================
# = Segment2
# =====================================

@doc raw"""
    Segment2

An object `s` of the data type [`Segment2`](@ref) is a directed straight line
segment in the two-dimensional Euclidean plane ``Ε^2``, i.e. a straight line
segment ``[p, q]`` connecting two points ``p, q ∈ ℝ^2``.

The segment is topologically closed, i.e. the end points belong to it. Point `p`
is called the *source* and `q` is called the *target* of `s`. The length of `s`
is the Euclidean distance between `p` and `q`. Note that there is only a
function to compute the square of the length, because otherwise we had to
perform a square root operation which is expensive, and may not be exact.
"""
Segment2

"""
    Segment2(p::Point2, q::Point2)

Introduces a segment `s` with source `p` and target `q`.

The segment is directed from the source towards the target.
"""
Segment2(p::Point2, q::Point2)

"""
    ==(s::Segment2, q::Segment2)

Test for equality: Two segments are equal, iff their sources and targets are
equal.
"""
==(s::Segment2, q::Segment2)

"""
    source(s::Segment2)

The source of `s`.
"""
source(s::Segment2)

"""
    target(s::Segment2)

The target of `s`.
"""
target(s::Segment2)

"""
    min(s::Segment2)

Returns the point of `s` with lexicographically smallest coordinate.
"""
min(s::Segment2)

"""
    max(s::Segment2)

Returns the point of `s` with lexicographically largest coordinate.
"""
max(s::Segment2)

@doc raw"""
    vertex(s::Segment2, i::Integer)

Returns source of target or `s`: `vertex(s, 0)` returns the source of `s`,
`vertex(s, 1)` returns the target of `s`

The parameter `i` is taken module 2, which gives easy access to the other
vertex.
"""
vertex(s::Segment2, i::Integer)

"""
    point(s::Segment2, i::Integer)

Returns `vertex(s, i)`.
"""
point(s::Segment2, i::Integer)

"""
    squared_length(s::Segment2)

Returns the squared lenght of `s`.
"""
squared_length(s::Segment2)

"""
    direction(s::Segment2)

Returns the direction from source to target of `s`.
"""
direction(s::Segment2)

"""
    to_vector(s::Segment2)

Returns the vector `target(s) - source(s)`.
"""
to_vector(s::Segment2)

"""
    opposite(s::Segment2)

Returns a segment with source and target point interchanged.
"""
opposite(s::Segment2)

"""
    supporting_line(s::Segment2)

Returns the line `l` passing through `s`.
"""
supporting_line(s::Segment2)

"""
    is_degenerate(s::Segment2)

Segment `s` is degenerate, if source and target are equal.
"""
is_degenerate(s::Segment2)

"""
    is_horizontal(s::Segment2)

Segment `s` is horizontal, if both the source and target's ``y``-coordinate is
the same.
"""
is_horizontal(s::Segment2)

"""
    is_vertical(s::Segment2)

Segment `s` is vertical, if both the source and target's ``x``-coordinate is
the same.
"""
is_vertical(s::Segment2)

"""
    has_on(s::Segment2, p::Point2)

A point is on `s`, iff it is equal to the source or target of `s` or if it is
in the interior of `s`.
"""
has_on(s::Segment2, p::Point2)

"""
    collinear_has_on(s::Segment2, p::Point2)

Checks if point `p` is on segment `s`.

!!! info "Precondition"

    `p` is on the supporting line of `s`.
"""
collinear_has_on(s::Segment2, p::Point2)

"""
    bbox(s::Segment2)

Returns a bounding box containing `s`.
"""
bbox(s::Segment2)

"""
    transform(s::Segment2, t::AffTransformation2)

Returns the segment obtained by applying `t` on the source and the target of
`s`.
"""
transform(s::Segment2, t::AffTransformation2)


# =====================================
# = Segment2
# =====================================

@doc raw"""
    Segment3

An object `s` of the data type [`Segment3`](@ref) is a directed straight line
segment in the three-dimensional Euclidean space ``Ε^3``, i.e. a straight line
segment ``[p, q]`` connecting two points ``p, q ∈ ℝ^3``.

The segment is topologically closed, i.e. the end points belong to it. Point `p`
is called the *source* and `q` is called the *target* of `s`. The length of `s`
is the Euclidean distance between `p` and `q`. Note that there is only a
function to compute the square of the length, because otherwise we had to
perform a square root operation which is expensive, and may not be exact.
"""
Segment3

"""
    Segment3(p::Point3, q::Point3)

Introduces a segment `s` with source `p` and target `q`.

The segment is directed from the source towards the target.
"""
Segment3(p::Point3, q::Point3)

"""
    ==(s::Segment3, q::Segment3)

Test for equality: Two segments are equal, iff their sources and targets are
equal.
"""
==(s::Segment3, q::Segment3)

"""
    source(s::Segment3)

The source of `s`.
"""
source(s::Segment3)

"""
    target(s::Segment3)

The target of `s`.
"""
target(s::Segment3)

"""
    min(s::Segment3)

Returns the point of `s` with lexicographically smallest coordinate.
"""
min(s::Segment3)

"""
    max(s::Segment3)

Returns the point of `s` with lexicographically largest coordinate.
"""
max(s::Segment3)

@doc raw"""
    vertex(s::Segment3, i::Integer)

Returns source of target or `s`: `vertex(s, 0)` returns the source of `s`,
`vertex(s, 1)` returns the target of `s`

The parameter `i` is taken module 2, which gives easy access to the other
vertex.
"""
vertex(s::Segment3, i::Integer)

"""
    point(s::Segment3, i::Integer)

Returns `vertex(s, i)`.
"""
point(s::Segment3, i::Integer)

"""
    squared_length(s::Segment3)

Returns the squared length of `s`.
"""
squared_length(s::Segment3)

"""
    to_vector(s::Segment3)

Returns the vector `target(s) - source(s)`.
"""
to_vector(s::Segment3)

"""
    opposite(s::Segment3)

Returns a segment with source and target point interchanged.
"""
opposite(s::Segment3)

"""
    is_degenerate(s::Segment3)

Segment `s` is degenerate, if source and target fall together.
"""
is_degenerate(s::Segment3)

"""
    has_on(s::Segment3, p::Point3)

A point is on `s`, iff it is equal to the source or target of `s` or if it is
in the interior of `s`.
"""
has_on(s::Segment3, p::Point3)


# =====================================
# = Triangle2
# =====================================

@doc raw"""
    Triangle2

An object `t` of the type [`Triangle2`](@ref) is a triangle in the
two-dimensional Euclidean plane ``Ε^2``.

Triangle `t` is oriented, i.e., its boundary has clockwise or
counterclockwise orientation. We call the side to the left of the boundary the
positive side and the side to the right of the boundary the negative side.

The boundary of a triangle splits the plane in two open regions, a bounded one
and an unbounded one.
"""
Triangle2

"""
    Triangle2(p::Point2, q::Point2, r::Point2)

Introduces a triangle `t` with vertices `p`, `q` and `r`.
"""
Triangle2(p::Point2, q::Point2, r::Point2)

"""
    ==(t::Triangle2, t2::Triangle2)

Test for equality: two triangles are equal, iff there exists a cyclic
permutation of the vertices of ``t2``, such that they are equal to the vertices
of `t`.
"""
==(t::Triangle2, t2::Triangle2)

"""
    vertex(t::Triangle2, i::Integer)

Returns the `i`ᵗʰ vertex module 3 of `t`.
"""
vertex(t::Triangle2, i::Integer)

"""
    is_degenerate(t::Triangle2)

Triangle `t` is degenerate, if the vertices are collinear.
"""
is_degenerate(t::Triangle2)

"""
    orientation(t::Triangle2)

Returns the orientation of `t`.
"""
orientation(t::Triangle2)

"""
    oriented_side(t::Triangle2, p::Point2)

Returns [`ON_ORIENTED_BOUNDARY`](@ref), or [`POSITIVE_SIDE`](@ref), or the
constant [`ON_NEGATIVE_SIDE`](@ref), determined by the position of point `p`.

!!! info "Precondition"

    `t` is not degenerate.
"""
oriented_side(t::Triangle2, p::Point2)

"""
    bounded_side(t::Triangle2, p::Point2)

Returns [`ON_BOUNDARY`](@ref), [`ON_BOUNDED_SIDE`](@ref), or else
[`ON_UNBOUNDED_SIDE`](@ref), depending on where point `p` is.

!!! info "Precondition"

    `t` is not degenerate.
"""
bounded_side(t::Triangle2, p::Point2)

"""
    has_on_positive_side(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies on the positive side of `t`.
"""
has_on_positive_side(t::Triangle2, p::Point2)

"""
    has_on_negative_side(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies on the negative side of `t`.
"""
has_on_negative_side(t::Triangle2, p::Point2)

"""
    has_on_boundary(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies on the boundary of `t`.
"""
has_on_boundary(t::Triangle2, p::Point2)

"""
    has_on_bounded_side(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies properly inside of `t`.
"""
has_on_bounded_side(t::Triangle2, p::Point2)

"""
    has_on_unbounded_side(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies properly outside of `t`.
"""
has_on_unbounded_side(t::Triangle2, p::Point2)

"""
    opposite(t::Triangle2)

Returns a triangle where the boundary is oriented the other way round (this
flips the positive and negative side, but not the bounded and unbounded side).
"""
opposite(t::Triangle2)

"""
    area(t::Triangle2)

Returns the signed area of `t`.
"""
area(t::Triangle2)

"""
    bbox(t::Triangle2)

Returns a bounding box containing `t`.
"""
bbox(t::Triangle2)

"""
    transform(t::Triangle2, at::AffTransformation2)

Returns the triangle obtained by applying `at` on the three vertices of `t`.
"""
transform(t::Triangle2, at::AffTransformation2)


# =====================================
# = Vector2
# =====================================

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


# =====================================
# = Vector3
# =====================================

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

"
    /(v::Vector3, s::RT)
    /(v::Vector3, s::Real)

Division by a scalar.
"
/(v::Vector3, s)

for V ∈ (Vector2, Vector3)
    @eval @cxxdereference Base.:/(v::$V, s::Real) = v / convert(FT, s)
end


# =====================================
# = WeightedPoint2
# =====================================

"""
    WeightedPoint2

An object of the type [`WeightedPoint2`](@ref) is a tuple of a two-dimensional
point and a scalar weight.

See also: [`Point2`](@ref)
"""
WeightedPoint2

"""
    WeightedPoint()
    WeightedPoint(ORIGIN::Origin)

Introduces a weighted point with Cartesian coordinates `(0, 0)` and weight `0`.
"""
WeightedPoint()

"""
    WeightedPoint2(p::Point2)

Introduces a weighted point from point `p` and weight `0`.
"""
WeightedPoint2(p::Point2)

"""
    WeightedPoint2(p::Point2, w::FT)
    WeightedPoint2(p::Point2, w::Real)

Introduces a weighted point from point `p` and weight `w`.
"""
WeightedPoint2(p::Point2, w)

@cxxdereference WeightedPoint2(p::Point2, w::Real) = WeightedPoint2(p, convert(FT, w))



"""
    WeightedPoint2(x::FT, y::FT)
    WeightedPoint2(x::Real, y::Real)

Introduces a weighted point with coordinates `x`, `y`, and weight `0`.
"""
WeightedPoint2(x, y)

WeightedPoint2(x::Real, y::Real) = WeightedPoint2(convert.(FT, (x, y))...)

"""
    point(p::WeightedPoint2)

Returns the point of the weighted point.
"""
point(p::WeightedPoint2)

"""
    weight(p::WeightedPoint2)

Returns the weight of the weighted point.
"""
weight(p::WeightedPoint2)

"""
    ==(p::WeightedPoint2, q::WeightedPoint2)

Test for equality.

Two points are equal, iff their ``x`` and ``y`` coordinates are equal. The point
can be compared with [`ORIGIN`](@ref).

!!! warn "Warning"

    Comparison and equality (==, <, etc.) currently operate directly on the
    underlying bare point. Consequently:

    ```julia-repl
    julia> p = Point2(1.0, 2.0)
    PointC2(1, 2)

    julia> wp, wq = WeightedPoint2.((p, p), (1.0, 2.0))    # same bare point here,
    (Weighted_pointC2(1, 2, 1), Weighted_pointC2(1, 2, 2)) # but different weights

    julia> wp == wq
    true
    ```
"""
==(p::WeightedPoint2, q::WeightedPoint2)

"""
    hx(p::WeightedPoint2)

Returns the homogeneous ``x`` coordinate.
"""
hx(p::WeightedPoint2)

"""
    hy(p::WeightedPoint2)

Returns the homogeneous ``y`` coordinate.
"""
hy(p::WeightedPoint2)

"""
    hw(p::WeightedPoint2)

Returns the homogenizing coordinate.
"""
hw(p::WeightedPoint2)

"""
    x(p::WeightedPoint2)

Returns the Cartesian ``x`` coordinate, that is [`hx()`](@ref)/[`hw()`](@ref).
"""
x(p::WeightedPoint2)

"""
    y(p::WeightedPoint2)

Returns the Cartesian ``y`` coordinate, that is [`hy()`](@ref)/[`hw()`](@ref).
"""
y(p::WeightedPoint2)

@doc raw"""
    homogeneous(p::WeightedPoint2, i::Integer)

Returns the `i`ᵗʰ homogeneous coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``.
"""
homogeneous(p::WeightedPoint2, i::Integer)

@doc raw"""
    cartesian(p::WeightedPoint2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of `p`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``.
"""
cartesian(p::WeightedPoint2, i::Integer)

"""
    dimension(p::WeightedPoint2)

Returns the dimension (the constant 2).
"""
dimension(p::WeightedPoint2)

"""
    bbox(p::WeightedPoint2)

Returns a bounding box containing `p`.
"""
bbox(p::WeightedPoint2)

"""
    transform(p::WeightedPoint2, t::AffTransformation2)

Returns the weighted point obtained by applying `t` on `p`.
"""
transform(p::WeightedPoint2, t::AffTransformation2)
