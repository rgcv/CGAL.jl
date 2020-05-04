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
    direction(s::Segment3)

Returns the direction from source to target.
"""
direction(s::Segment3)

"""
    opposite(s::Segment3)

Returns a segment with source and target point interchanged.
"""
opposite(s::Segment3)

"""
    supporting_line(s::Segment3)

Returns the line `l` passing through `s`.

Line `l` has the same orientation as segment `s`, that is from the source to the
target of `s`.
"""
supporting_line(s::Segment3)

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

"""
    bbox(s::Segment3)

Returns a bounding box containing `s`.
"""
bbox(s::Segment3)

"""
    transform(s::Segment3, t::AffTransformation3)

Returns the segment obtained by applying `t` on the source and the target of
`s`.
"""
transform(s::Segment3, t::AffTransformation3)
