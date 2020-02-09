import CxxWrap: @cxxdereference

### CONSTANTS ##################################################################

export IDENTITY,
       REFLECTION,
       ROTATION,
       SCALING,
       TRANSLATION

### TYPES #####################################################################

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

    @cxxdereference Base.float(x::FT) = to_double(x)
    @cxxdereference (::Type{T})(x::FT) where {T<:AbstractFloat} = T(float(x))

    @cxxdereference Base.oftype(x::FT, y) = convert(FT, y)
    @cxxdereference Base.isinteger(x::FT) = isinteger(float(x))
end

Base.convert(::Type{FT}, x::Ref{FT}) = x[]
Base.convert(::Type{T}, x::Ref{FT}) where {T<:Real} = convert(T, x[])
Base.isnan(x::Ref{FT}) = isnan(x[])

export AffTransformation2,
       Bbox2,
       Circle2,
       Direction2,
       IsoRectangle2,
       Line2,
       Point2,
       Ray2,
       Segment2,
       Triangle2,
       Vector2,
       WeightedPoint2

const AT2 = AffTransformation2
@cxxdereference AT2(::Union{Rotation,Ref{Rotation}}, d::Direction2, num::Real, den::Real = 1) =
    AT2(ROTATION, d, convert.(FT, (num, den))...)
AT2(::Union{Rotation,Ref{Rotation}}, sinᵨ::Real, cosᵨ::Real, hw::Real = 1) =
    AT2(ROTATION, convert.(FT, (sinᵨ, cosᵨ, hw))...)
AT2(::Union{Scaling,Ref{Scaling}}, s, hw = 1) =
    AT2(SCALING, convert.(FT, (s, hw))...)
AT2(m₀₀::Real, m₀₁::Real, m₀₂::Real, m₁₀::Real, m₁₁::Real, m₁₂::Real, hw::Real = 1) =
    AT2(convert.(FT, (m₀₀, m₀₁, m₀₂, m₁₀, m₁₁, m₁₂, hw))...)
AT2(m₀₀::Real, m₀₁::Real, m₁₀::Real, m₁₁::Real, hw::Real = 1) =
    AT2(convert.(FT, (m₀₀, m₀₁, m₁₀, m₁₁, hw))...)

@cxxdereference Circle2(c::Point2, r²::Real, ori::Union{Orientation,Ref{Orientation}} = COUNTERCLOCKWISE) =
    Circle2(c, convert(FT, r²), ori)

Direction2(x::Real, y::Real) = Direction2(convert.(FT, (x, y))...)

IsoRectangle2(min_hx::Real, min_hy::Real, max_hx::Real, max_hy::Real, hw::Real = 1) =
    IsoRectangle2(convert.(FT, (min_hx, min_hy, max_hx, max_hy, hw))...)

Line2(a, b, c) = Line2(convert.(FT, (a, b, c))...)

Point2(x::Real, y::Real, hw::Real = 1) = Point2(convert.(FT, (x, y, hw))...)

Vector2(x::Real, y::Real, hw::Real = 1) = Vector2(convert.(FT, (x, y, hw))...)

@cxxdereference WeightedPoint2(p::Point2, w::Real) = WeightedPoint2(p, convert(FT, w))
WeightedPoint2(x::Real, y::Real) = WeightedPoint2(convert.(FT, (x, y))...)


### METHODS ####################################################################

# min and max specialize Base's functions
export # Operations
       a, b, c,
       counterclockwise_in_between,
       delta,
       dilate,
       direction,
       dimension,
       dx, dy,
       max, min,
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
       vertex,
       x_at_y, y_at_x,
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
       hm, hw, hx, hy,
       m, x, y,
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

@cxxdereference Base.:*(s::Real, v::Vector2) = convert(FT, s) * v
@cxxdereference Base.:*(v::Vector2, s::Real) = s * v
@cxxdereference Base.:/(v::Vector2, s::Real) = v / convert(FT, s)
