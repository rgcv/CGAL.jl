### CONSTANTS ##################################################################

export IDENTITY,
       ROTATION,
       SCALING,
       TRANSLATION

### TYPES #####################################################################

export FT, RT, FieldType, RingType

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

# only true for cartesian kernels, see homogeneous kernels
const RingType = FieldType
const FT = FieldType
const RT = RingType

Base.convert(::Type{<:FT}, r::Real) = FT(r)
Base.convert(::Type{<:FT}, r::Rational) = convert(FT, float(r)) # exactness loss
Base.promote_rule(::Type{<:FT}, ::Type{<:Real}) = FT
