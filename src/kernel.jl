export FT, RT, FieldType, RingType

if !@isdefined FieldType
    const FieldType = Float64
end

# only true for cartesian kernels, see homogeneous kernels
const RingType = FieldType
const FT = FieldType
const RT = RingType

if iscxxtype(FT) # define a couple more constructors, conversions, promotions
    # upscaling
    FT(x::AbstractFloat) = FT(Float64(x))
    FT(x::Integer) = FT(Int64(x))
    # have one for Rational
    function FT(x::Rational)
        isinf(x) && return FT(x*Inf) # preserve sign
        convert(FT, x.num)/convert(FT, x.den)
    end

    Base.promote_rule(::Type{<:Union{FT,CxxBaseRef{FT}}}, ::Type{<:Real}) = FT
    Base.promote_rule(::Type{<:Union{FT,CxxBaseRef{FT}}}, ::Type{Real}) = Real

    @cxxdereference (::Type{T})(x::FT) where {T<:Real} = T(float(x))

    @cxxdereference Base.oftype(x::FT, y) = convert(FT, y)
    @cxxdereference Base.isinteger(x::FT) = isinteger(float(x))
else
    for op ∈ (:<, :<=, :>, :>=, :/, :+, :-, :*, :^)
        @eval begin
            Base.$op(x::CxxBaseRef{FT}, y::CxxBaseRef{FT}) = $op(x[], y[]) # solves ambiguity
            Base.$op(x::CxxBaseRef{FT}, y) = $op(x[], y)
            Base.$op(x, y::CxxBaseRef{FT}) = $op(x, y[])
        end
    end
    Base.:+(x::CxxBaseRef{FT}) = +x[]
    Base.:-(x::CxxBaseRef{FT}) = -x[]
end

Base.convert(::Type{FT}, x::CxxBaseRef{FT}) = x[]
Base.convert(::Type{T}, x::CxxBaseRef{FT}) where {T<:Real} = convert(T, x[])

(::Type{T})(x::CxxBaseRef{FT}) where {T<:Real} = T(float(x))
FT(x::CxxBaseRef{FT}) = FT(x[])
Base.isnan(x::CxxBaseRef{FT}) = isnan(x[])

export AffTransformation2,
       AffTransformation3,
       Bbox2,
       Bbox3,
       Circle2,
       Circle3,
       CircularArc2,
       CircularArc3,
       Direction2,
       Direction3,
       IsoRectangle2,
       IsoCuboid3,
       Line2,
       Line3,
       Plane3,
       Point2,
       Point3,
       Ray2,
       Ray3,
       Segment2,
       Segment3,
       Sphere3,
       Tetrahedron3,
       Triangle2,
       Triangle3,
       Vector2,
       Vector3,
       WeightedPoint2,
       WeightedPoint3

const AffTransformation23 = Union{AffTransformation2,AffTransformation3}
const Bbox23 = Union{Bbox2,Bbox3}
const Circle23 = Union{Circle2,Circle3}
const CircularArc23 = Union{CircularArc2,CircularArc3}
const Direction23 = Union{Direction2,Direction3}
const IsoBox23 = Union{IsoRectangle2,IsoCuboid3}
const Line23 = Union{Line2,Line3}
const Point23  = Union{Point2,Point3}
const Ray23 = Union{Ray2,Ray3}
const Segment23 = Union{Segment2,Segment3}
const Triangle23 = Union{Triangle2,Triangle3}
const Vector23 = Union{Vector2,Vector3}
const WeightedPoint23 = Union{WeightedPoint2,WeightedPoint3}

# min and max specialize Base's respective functions
export # Operations
       a,
       approximate_area,
       approximate_squared_length,
       area_divided_by_pi,
       b,
       base1, base2,
       c,
       counterclockwise_in_between,
       d,
       delta,
       diametral_sphere,
       dilate,
       dimension,
       direction,
       dx, dy, dz,
       min_coord, max_coord,
       opposite,
       point,
       projection,
       source,
       squared_length,
       squared_length_divided_by_pi_square,
       supporting_line,
       supporting_plane,
       target,
       to_vector,
       vertex,
       volume,
       x_at_y,
       xmax,
       xmin,
       y_at_x,
       ymax,
       ymin,
       zmax,
       zmin,
       # 2D Conversion
       to_2d,
       to_3d,
       # Predicates
       bounded_side,
       collinear_has_on,
       has_on,
       has_on_boundary, 
       has_on_bounded_side,
       has_on_negative_side,
       has_on_positive_side,
       has_on_unbounded_side,
       inverse,
       is_degenerate,
       is_even,
       is_horizontal,
       is_odd,
       is_vertical,
       is_x_monotone,
       is_y_monotone,
       orientation,
       oriented_side,
       orthogonal_direction,
       orthogonal_transform,
       orthogonal_vector,
       # Access Functions
       cartesian,
       center,
       dimension,
       hm,
       homogeneous,
       hw,
       hx,
       hy,
       hz,
       left,
       m,
       orientation,
       right,
       squared_radius,
       supporting_circle,
       weight,
       x,
       y,
       z,
       # Miscellaneous
       area,
       bbox,
       direction,
       opposite,
       perpendicular,
       perpendicular_line,
       perpendicular_plane,
       to_vector,
       transform,
       vector

_pointfor(x) = _pointfor(typeof(x))
_pointfor(::Type) = Any
for T ∈ (:AffTransformation2, :AffTransformation3
       , :Bbox2, :Bbox3
       , :Circle2, :Circle3
       , :CircularArc2, :CircularArc3
       , :Direction2, :Direction3
       , :IsoRectangle2, :IsoCuboid3
       , :Line2, :Line3
       , :Plane3
       , :Point2, :Point3
       , :Ray2, :Ray3
       , :Segment2, :Segment3
       , :Sphere3
       , :Tetrahedron3
       , :Triangle2, :Triangle3
       , :Vector2, :Vector3
       , :WeightedPoint2, :WeightedPoint3)
    D = Symbol(last(string(T)))
    @eval _pointfor(::Type{<:reference_type_union($T)}) = $(Symbol(:Point, D))
end


## Origin & NullVector
export ORIGIN, NULL_VECTOR

"""
    ORIGIN

A symbolic constant which denotes the point at the origin.

This constant is used in the conversion between points and vectors.

# Example

```jldoctest
julia> p = Point2(1.0, 1.0)
PointC2(1, 1)

julia> v = p - ORIGIN
VectorC2(1, 1)

julia> q = ORIGIN + v
PointC2(1, 1)

julia> p == q
true
```

See also: [`Point2`](@ref), [`Point3`](@ref)
"""
ORIGIN


"""
    NULL_VECTOR

A symbolic constant used to construct zero length vectors.

See also: [`Vector2`](@ref), [`Vector3`](@ref)
"""
NULL_VECTOR
 

## Enumerations and Related Functions
export Sign,
       NEGATIVE,
       ZERO,
       POSITIVE

export Orientation,
       LEFT_TURN, RIGHT_TURN,
       CLOCKWISE, COUNTERCLOCKWISE,
       COLLINEAR, COPLANAR, DEGENERATE

export OrientedSide
       ON_NEGATIVE_SIDE,
       ON_ORIENTED_BOUNDARY,
       ON_POSITIVE_SIDE

export ComparisonResult,
       SMALLER,
       EQUAL,
       LARGER

export BoundedSide,
       ON_UNBOUNDED_SIDE,
       ON_BOUNDARY,
       ON_BOUNDED_SIDE

export Angle,
       OBTUSE,
       RIGHT,
       ACUTE

export BoxParameterSpace2,
       LEFT_BOUNDARY, RIGHT_BOUNDARY,
       BOTTOM_BOUNDARY, TOP_BOUNDARY,
       INTERIOR, EXTERIOR


"""
    Sign

See also: [`Orientation`](@ref)

|     Enumerator     |
|:-------------------|
| [`NEGATIVE`](@ref) |
| [`ZERO`](@ref)     |
| [`POSITIVE`](@ref) |
"""
Sign

# make Sign look more like a Number
Base.promote_rule(::Type{Sign}, ::Type{T}) where T <: Number = T
Base.promote_rule(::Type{Sign}, ::Type{Bool}) = Sign
(::Type{T})(x::Sign) where T <: AbstractFloat = T(convert(Integer, x))

# reimplement these in julia
Base.:-(x::Sign) = opposite(x)
Base.:*(a::Sign, b::Sign) = reinterpret(Sign, convert(Integer, a) * convert(Integer, b))


"""
    Orientation

See also: [`LEFT_TURN`](@ref), [`RIGHT_TURN`](@ref), [`COLLINEAR`](@ref),
[`CLOCKWISE`](@ref), [`COUNTERCLOCKWISE`](@ref), [`COPLANAR`](@ref)
"""
const Orientation = Sign

"""
    CLOCKWISE = NEGATIVE

See also: [`COUNTERCLOCKWISE`](@ref)
"""
CLOCKWISE

"""
    COLLINEAR = ZERO

See also: [`LEFT_TURN`](@ref), [`RIGHT_TURN`](@ref)
"""
COLLINEAR

"""
    COUNTERCLOCKWISE = POSITIVE

See also: [`CLOCKWISE`]
"""
COUNTERCLOCKWISE

"""
    LEFT_TURN = POSITIVE

See also: [`COLLINEAR`](@ref), [`RIGHT_TURN`](@ref)
"""
LEFT_TURN

"""
    RIGHT_TURN = NEGATIVE

See also: [`COLLINEAR`](@ref), [`LEFT_TURN`](@ref)
"""
RIGHT_TURN

"`COPLANAR = ZERO`" COPLANAR
"`DEGENERATE = ZERO`" DEGENERATE


"""
    OrientedSide

|           Enumerator           |
|:-------------------------------|
| [`ON_NEGATIVE_SIDE`](@ref)     |
| [`ON_ORIENTED_BOUNDARY`](@ref) |
| [`ON_POSITIVE_SIDE`](@ref)     |
"""
const OrientedSide = Sign

"""
    ON_NEGATIVE_SIDE

See also: [`ON_POSITIVE_SIDE`](@ref)
"""
ON_NEGATIVE_SIDE

"""
    ON_ORIENTED__BOUNDARY

See also: [`ON_NEGATIVE_SIDE`](@ref), [`ON_POSITIVE_SIDE`](@ref)
"""
ON_ORIENTED_BOUNDARY

"""
    ON_POSITIVE_SIDE

See also: [`ON_NEGATIVE_SIDE`](@ref)
"""
ON_POSITIVE_SIDE

"""
    opposite(o::OrientedSide)

Returns the opposite side (for example [`ON_POSITIVE_SIDE`](@ref) if `o ==
[ON_NEGATIVE_SIDE](@ref)`, or `[ON_ORIENTED_BOUNDARY](@ref) if o ==
[ON_ORIENTED_BOUNDARY](@ref)`)
"""
opposite(o::OrientedSide)


"""
    ComparisonResult

|    Enumerator     |
|:------------------|
| [`SMALLER`](@ref) |
| [`EQUAL`](@ref)   |
| [`LARGER`](@ref)  |
"""
const ComparisonResult = Sign

"""
    SMALLER = NEGATIVE

See also: [`LARGER`](@ref)
"""
SMALLER

"""
    EQUAL = ZERO

See also: [`SMALLER`](@ref), [`LARGER`](@ref)
"""
EQUAL

"""
    LARGER = POSITIVE

See also: [`SMALLER`](@ref)
"""
LARGER


"""
    BoundedSide

See also: [`opposite(o::BoundedSide)`](@ref)

|         Enumerator          |
|:----------------------------|
| [`ON_UNBOUNDED_SIDE`](@ref) |
| [`ON_BOUNDARY`](@ref)       |
| [`ON_BOUNDED_SIDE`](@ref)   |
"""
BoundedSide

"""
    ON_UNBOUNDED_SIDE = NEGATIVE

See also: [`ON_BOUNDED_SIDE`](@ref)
"""
ON_UNBOUNDED_SIDE

"""
    ON_BOUNDARY = ZERO

See also: [`ON_UNBOUNDED_SIDE`](@ref), [`ON_BOUNDED_SIDE`](@ref)
"""
ON_BOUNDARY

"""
    ON_BOUNDED_SIDE = POSITIVE

See also: [`ON_UNBOUNDED_SIDE`](@ref)
"""
ON_BOUNDED_SIDE

"""
    opposite(o::BoundedSide)

Returns the opposite side (for example [`ON_BOUNDED_SIDE`](@ref) if `o ==
[ON_UNBOUNDED_SIDE](@ref)`, or `[ON_BOUNDARY](@ref) if o ==
[ON_BOUNDARY](@ref)`)
"""
opposite(o::BoundedSide)


"""
    Angle

See also: [`angle`](@ref)

|    Enumerator    |
|:-----------------|
| [`OBTUSE`](@ref) |
| [`RIGHT`](@ref)  |
| [`ACUTE`](@ref)  |
"""
Angle


"""
    BoxParameterSpace2

|        Enumerator         |
|:--------------------------|
| [`LEFT_BOUNDARY`](@ref)   |
| [`RIGHT_BOUNDARY`](@ref)  |
| [`BOTTOM_BOUNDARY`](@ref) |
| [`TOP_BOUNDARY`](@ref)    |
| [`INTERIOR`](@ref)        |
| [`EXTERIOR`](@ref)        |
"""
BoxParameterSpace2

# despite undocumented, might as well just define `opposite` for all of them
for E ∈ (:Sign
       , :Angle
       , :BoundedSide
       , :BoxParameterSpace2)
    @eval opposite(x::$E) = reinterpret($E, -convert(Integer, x))
end


## 2D Kernel Objects
include("kernel/aff_transformation_2.jl")
include("kernel/bbox_2.jl")
include("kernel/circle_2.jl")
include("kernel/circular_arc_2.jl")
include("kernel/direction_2.jl")
include("kernel/iso_rectangle_2.jl")
include("kernel/line_2.jl")
include("kernel/point_2.jl")
include("kernel/ray_2.jl")
include("kernel/segment_2.jl")
include("kernel/triangle_2.jl")
include("kernel/vector_2.jl")
include("kernel/weighted_point_2.jl")

## 3D Kernel Objects
include("kernel/aff_transformation_3.jl")
include("kernel/bbox_3.jl")
include("kernel/circle_3.jl")
include("kernel/circular_arc_3.jl")
include("kernel/direction_3.jl")
include("kernel/iso_cuboid_3.jl")
include("kernel/line_3.jl")
include("kernel/plane_3.jl")
include("kernel/point_3.jl")
include("kernel/ray_3.jl")
include("kernel/segment_3.jl")
include("kernel/sphere_3.jl")
include("kernel/tetrahedron_3.jl")
include("kernel/triangle_3.jl")
include("kernel/vector_3.jl")
include("kernel/weighted_point_3.jl")
