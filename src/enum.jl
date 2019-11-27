export Sign,
       NEGATIVE,
       ZERO,
       POSITIVE

const  Orientation = Sign
export Orientation,
       LEFT_TURN, RIGHT_TURN,
       CLOCKWISE, COUNTERCLOCKWISE,
       COLLINEAR, COPLANAR, DEGENERATE

const  OrientedSide = Sign
export OrientedSide,
       ON_NEGATIVE_SIDE,
       ON_ORIENTED_BOUNDARY,
       ON_POSITIVE_SIDE

const  ComparisonResult = Sign
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
