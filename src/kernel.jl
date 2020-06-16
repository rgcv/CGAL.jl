import CxxWrap.CxxWrapCore: cpp_trait_type, IsCxxType

export FT, RT, FieldType, RingType

if !@isdefined FieldType
    const FieldType = Float64
end

# only true for cartesian kernels, see homogeneous kernels
const RingType = FieldType
const FT = FieldType
const RT = RingType

iscxxtype(T::Type) = _iscxxtype(cpp_trait_type(T))
_iscxxtype(::Type) = false
_iscxxtype(::Type{IsCxxType}) = true

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

    @cxxdereference Base.float(x::FT) = to_double(x)
    @cxxdereference (::Type{T})(x::FT) where {T<:Real} = T(float(x))

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

export IDENTITY,
       REFLECTION,
       ROTATION,
       SCALING,
       TRANSLATION

export AffTransformation2, AffTransformation3,
       Bbox2, Bbox3,
       Circle2, Circle3,
       Direction2, Direction3,
       IsoRectangle2, IsoCuboid3,
       Line2, Line3,
       Plane3,
       Point2, Point3,
       Ray2, Ray3,
       Segment2, Segment3,
       Sphere3,
       Tetrahedron3,
       Triangle2, Triangle3,
       Vector2, Vector3,
       WeightedPoint2, WeightedPoint3

const AffTransformation23 = Union{AffTransformation2,AffTransformation3}
const Bbox23 = Union{Bbox2,Bbox3}
const Circle23 = Union{Circle2,Circle3}
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
       a, b, c, d,
       area_divided_by_pi,
       approximate_area,
       approximate_squared_length,
       base1, base2,
       counterclockwise_in_between,
       delta,
       diametral_sphere,
       dilate,
       direction,
       dimension,
       dx, dy, dz,
       xmin, ymin, zmin,
       xmax, ymax, zmax,
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
       orthogonal_direction,
       orthogonal_transform,
       orthogonal_vector,
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
       perpendicular_line,
       perpendicular_plane,
       vector,
       to_vector,
       transform

include("kernel/aff_transformation_2.jl")
include("kernel/bbox_2.jl")
include("kernel/circle_2.jl")
include("kernel/direction_2.jl")
include("kernel/iso_rectangle_2.jl")
include("kernel/line_2.jl")
include("kernel/point_2.jl")
include("kernel/ray_2.jl")
include("kernel/segment_2.jl")
include("kernel/triangle_2.jl")
include("kernel/vector_2.jl")
include("kernel/weighted_point_2.jl")

include("kernel/aff_transformation_3.jl")
include("kernel/bbox_3.jl")
include("kernel/circle_3.jl")
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
