"""
    CircularArc2(c::Circle2)

Constructs an arc from a full circle.
"""
CircularArc2(c::Circle2)

"""
    CircularArc2(c::Circle2, p::Point2, q::Point2)

Constructs the circular arc supported by `c`, whose source is `p` and whose
target is `q` when traversing the circle in counterclockwise direction.

If `p` and `q` are the same, the arc is in fact a full circle.

!!! info "Precondition"

    `p` and `q` lie on `c`.
"""
CircularArc2(c::Circle2, p::Point2, q::Point2)

"""
    CircularArc2(p::Point2, q::Point2, r::Point2)

Constructs an arc that is supported by the circle of type [`Circle2`](@ref)
passing through points `p`, `q` and `r`.

The source and target are respectively `p` and `r`, when traversing the
supporting circle in the counterclockwise direction.  Note that, depending on
the orientation of the point triple `(p,q,r)`, `q` may not lie on the arc.

!!! info "Precondition"

    `p`, `q`, and `r` are not collinear.
"""
CircularArc2(p::Point2, q::Point2, r::Point2)

"""
    supporting_circle(ca::CircularArc2)

Returns the supporting circle of `ca`.
"""
supporting_circle(ca::CircularArc2)

"""
    center(ca::CircularArc2)

Returns the center of `ca`'s supporting circle.
"""
center(ca::CircularArc2)

"""
    squared_radius(ca::CircularArc2)

Returns the squared radius of `ca`'s supporting circle.
"""
squared_radius(ca::CircularArc2)

"""
    source(ca::CircularArc2)

Returns the arc's starting point, supposing its supporting circle is
traversed in counterclockwise direction.
"""
source(ca::CircularArc2)

"""
    target(ca::CircularArc2)

Returns the arc's ending point, supposing its supporting circle is traversed
in counterclockwise direction.
"""
target(ca::CircularArc2)

"""
    left(ca::CircularArc2)

Returns the arc's leftmost point.

!!! info "Precondition"

    `is_x_monotone(ca)`
"""
left(ca::CircularArc2)

"""
    right(ca::CircularArc2)

Returns the arc's rightmost point.

!!! info "Precondition"

    `is_x_monotone(ca)`
"""
right(ca::CircularArc2)

"""
    bbox(ca::CircularArc2)

Returns a bounding box containing the arc.
"""
bbox(ca::CircularArc2)

"""
    is_x_monotone(ca::CircularArc2)

Tests whether the arc is x-monotone.
"""
is_x_monotone(ca::CircularArc2)

"""
    is_y_monotone(ca::CircularArc2)

Tests whether the arc is y-monotone.
"""
is_y_monotone(ca::CircularArc2)

"""
==(ca₁::CircularArc2, ca₂::CircularArc2)

Test for equality.

Two arcs are equal, iff their non-oriented supporting circles are equal (i.e.
they have the same center and same squared radius) and their endpoints are
equal.
"""
==(ca₁::CircularArc2, ca₂::CircularArc2)
