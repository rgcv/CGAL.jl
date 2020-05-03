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
