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

export ComparisonResult
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


"""
    opposite(o::OrientedSide)

Returns the opposite side (for example [`ON_POSITIVE_SIDE`](@ref) if `o ==
[ON_NEGATIVE_SIDE](@ref)`, or `[ON_ORIENTED_BOUNDARY](@ref) if o ==
[ON_ORIENTED_BOUNDARY](@ref)`)
"""
opposite(o::OrientedSide)

"""
    opposite(o::BoundedSide)

Returns the opposite side (for example [`ON_BOUNDED_SIDE`](@ref) if `o ==
[ON_UNBOUNDED_SIDE](@ref)`, or `[ON_BOUNDARY](@ref) if o ==
[ON_BOUNDARY](@ref)`)
"""
opposite(o::BoundedSide)
