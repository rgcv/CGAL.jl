using CxxWrap

### CONSTANTS ##################################################################

export IDENTITY,
       REFLECTION,
       ROTATION,
       SCALING,
       TRANSLATION

### TYPES #####################################################################

export FT, RT, FieldType, RingType

# only true for cartesian kernels, see homogeneous kernels
const RingType = FieldType
const FT = FieldType
const RT = RingType

# upscaling
FT(x::AbstractFloat) = FT(Float64(x))
FT(x::Integer) = FT(Int64(x))

Base.promote_rule(::Type{<:Union{FT,Ref{FT}}}, ::Type{<:Real}) = FT

@cxxdereference Base.oftype(x::FT, y) = convert(FT, y)

@cxxdereference Base.float(x::FT) = to_double(x)
@cxxdereference (::Type{T})(x::FT) where {T<:AbstractFloat} = T(float(x))
Base.convert(::Type{T}, x::Ref{FT}) where {T<:AbstractFloat} = convert(T, x[])

FT(x::Rational) = convert(FT, x.num)/convert(FT, x.den)

for op ∈ (:(==), :<, :>, :<=, :>=, :+, :*, :-, :/)
    @eval Base.$op(x::Ref{FT}, y) = $op(x[], y)
    @eval Base.$op(x, y::Ref{FT}) = $op(x, y[])
end

export AffTransformation2,
       BBox2,
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
