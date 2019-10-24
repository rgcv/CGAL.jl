### CONSTANTS ##################################################################

export IDENTITY_TRANSFORMATION,
       NULL_VECTOR,
       ORIGIN,
       ROTATION,
       SCALING,
       TRANSLATION

### ENUMS ######################################################################

export Angle,
       OBTUSE, RIGHT, ACUTE

export BoundedSide,
       ON_UNBOUNDED_SIDE, ON_BOUNDARY, ON_BOUNDED_SIDE

export Sign,
       NEGATIVE, ZERO, POSITIVE

const  Orientation = Sign
export Orientation,
       LEFT_TURN, RIGHT_TURN,
       CLOCKWISE, COUNTERCLOCKWISE,
       COLLINEAR, COPLANAR, DEGENERATE

const  OrientedSide = Sign
export OrientedSide,
       ON_NEGATIVE_SIDE, ON_ORIENTED_BOUNDARY, ON_POSITIVE_SIDE

const  ComparisonResult = Sign
export ComparisonResult,
       SMALLER, EQUAL, LARGER

### TYPES #####################################################################

# only true for cartesian kernels, see homogeneous kernels
const RingType = FieldType
const FT = FieldType
const RT = RingType

export FT, RT, FieldType, RingType,
       # Conversion
       to_double

export AffTransformation2,
       # Operations
       transform,
       # Miscellaneous
       inverse, is_even, is_odd,
       # Matrix Entry Access
       cartesian, m, homogeneous, hm

export BBox2,
       # Operations
       dimension, xmin, ymin, xmax, ymax, min, max, dilate

export Circle2,
       # Access Functions
       center, squared_radius, orientation,
       # Predicates
       is_degenerate, oriented_side, bounded_side, has_on_positive_side,
       has_on_negative_side, has_on_boundary, has_on_bounded_side,
       has_on_unbounded_side,
       # Miscellaneous
       opposite, orthogonal_transform, bbox

export Direction2,
       # Operations
       delta, dx, dy, counterclockwise_in_between,
       # Miscellaneous
       vector, transform

export IsoRectangle2,
       # Operations
       vertex, min, max, xmin, ymin, xmax, ymax, min_coord, max_coord,
       # Predicates
       is_degenerate, bounded_side, has_on_boundary, has_on_bounded_side,
       has_on_unbounded_side,
       # Miscellaneous
       area, bbox, transform

export Line2,
       # Operations
       a, b, c, point, projection, x_at_y, y_at_x,
       # Predicates
       is_degenerate, is_horizontal, is_vertical, oriented_side,
       # Convenience boolean functions
       has_on, has_on_positive_side, has_on_negative_side,
       # Miscellaneous
       to_vector, direction, opposite, perpendicular, transform

export Point2,
       # Coordinate Access
       hx, hy, hw, x, y,
       # Convenience Operations
       homogeneous, cartesian, dimension, bbox, transform

export Ray2,
       # Operations
       source, point, direction, to_vector, supporting_line, opposite,
       # Predicates
       is_degenerate, is_horizontal, is_vertical, has_on, collinear_has_on,
       # Miscellaneous
       transform

export Segment2,
       # Operations
       source, target, min, max, vertex, point, squared_length, direction,
       to_vector, opposite, supporting_line,
       # Predicates
       is_degenerate, is_horizontal, is_vertical, has_on, collinear_has_on,
       # Miscellaneous
       bbox, transform

export Triangle2,
       # Operations
       vertex,
       # Predicates
       is_degenerate, orientation, oriented_side, bounded_side,
       has_on_positive_side, has_on_negative_side, has_on_boundary,
       has_on_bounded_side, has_on_unbounded_side,
       # Miscellaneous
       opposite, area, bbox, transform

export Vector2,
       # Coordinate Access
       hx, hy, hw, x, y,
       # Convenience Operations
       homogeneous, cartesian, dimension, direction, transform, perpendicular

export WeightedPoint2,
       # Bare point and weight accessor
       point, weight,
       # Coordinate Access
       hx, hy, hw, x, y,
       # Convenience Operations
       homogeneous, cartesian, dimension, bbox, transform
