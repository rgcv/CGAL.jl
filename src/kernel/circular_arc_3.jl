
"""
    CircularArc3(c::Circle3)

Constructs an arc from a full circle.
"""
CircularArc3(c::Circle3)

"""
    CircularArc3(c::Circle3, pt::Point3)

Constructs an arc from a full circle, using `pt` as source and target.

!!! info "Precondition"

    `pt` lies on `c`
"""
CircularArc3(c::Circle3, pt::Point3)

"""
    CircularArc3(c::Circle3, p::Point3, q::Point3)

The circular arc constructed from a circle `c`, a source `p`, and a target `q`,
is defined as the set of points of the circle that lie between the source `p₁`
and the target `p₂`, when traversing the circle counterclockwise seen from the
side of the circle's supporting plane pointed by its *positive* normal vectors.

In this definition, we say that a normal vector ``(a,b,c)`` is positive if
``(a,b,c) > (0,0,0)`` (i.e. ``a > 0 ∨ (a = 0 ∧ b > 0) ∨ (b = 0 ∧ c > 0)``).

Constructs the circular arc supported by `c`, whose source and target are `p`
and `q`, respectively.

!!! info "Precondition"

    `p` and `q` lie on `c` and are different.
"""
CircularArc3(c::Circle3, p::Point3, q::Point3)

"""
    CircularArc3(p::Point3, q::Point3, r::Point3)

Constructs an arc that is supported by the circle of type [`Circle3`](@ref)
passing through points `p`, `q` and `r`.

The source and target are respectively `p` and `r`, when traversing the
supporting circle in the counterclockwise direction seen from the side of the
place containing the circle pointed by its *positive* normal vectors.  Note
that, depending on the orientation of the point triple `(p,q,r)`, `q` may not
lie on the arc.

!!! info "Precondition"

    `p`, `q`, and `r` are not collinear.
"""
CircularArc3(p::Point3, q::Point3, r::Point3)

"""
    supporting_circle(ca::CircularArc3)

Returns the supporting circle of `ca`.
"""
supporting_circle(ca::CircularArc3)

"""
    center(ca::CircularArc3)

Returns the center of `ca`'s supporting circle.
"""
center(ca::CircularArc3)

"""
    squared_radius(ca::CircularArc3)

Returns the squared radius of `ca`'s supporting circle.
"""
squared_radius(ca::CircularArc3)

"""
    supporting_plane(ca::CircularArc3)

Returns the supporting plane of `ca`'s supporting circle.
"""
supporting_plane(ca::CircularArc3)

"""
    diametral_sphere(ca::CircularArc3)

Returns the diametral_sphere of `ca`'s supporting circle.
"""
diametral_sphere(ca::CircularArc3)

"""
    source(ca::CircularArc3)

Returns the arc's smallest point, supposing its supporting circle is
traversed in counterclockwise direction.

When the arc was constructed from its (full) underlying circle, then source
returns the smallest ``x``-extremal point of the circle if the circle is not
contained in a plane ``x = A``, and the smallest ``y``-extremal point otherwise.
"""
source(ca::CircularArc3)

"""
    target(ca::CircularArc3)

Returns the arc's ending point, supposing its supporting circle is traversed
in counterclockwise direction.

When the arc was constructed from its (full) underlying circle, then target
returns the smallest ``x``-extremal point of the circle if the circle is not
contained in a plane ``x = A``, and the smallest ``y``-extremal point otherwise.
"""
target(ca::CircularArc3)

"""
    ==(ca₁::CircularArc3, ca₂::CircularArc3)

Test for equality.

Two arcs are equal, iff their non-oriented supporting planes are equal, the
centers and squared radii of their respective supporting circles are equal, and
their sources and targets are equal.
"""
==(ca₁::CircularArc3, ca₂::CircularArc3)
