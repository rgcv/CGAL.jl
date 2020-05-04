"""
    Tetrahedron3

An object `t` of type [`Tetrahedron3`](@ref) is an oriented tetrahedron in the
three-dimensional Euclidean space ``Ε^3``.

It is defined by four vertices ``p_0``, ``p_1``, ``p_2`` and ``p_3``. The
orientation of a tetrahedron is the orientation of its four vertices. That means
it is positive when ``p_3`` is on the positive side of the plane defined by
``p_0``, ``p_1`` and ``p_2``.

The tetrahedron itself splits the space ``Ε^3`` in a *positive* and a *negative*
side.

The boundary of a tetrahedron splits the space in two open regions, a bounded
one and an unbounded one.
"""
Tetrahedron3

"""
    Tetrahedron3(p₀::Point3, p₁::Point3, p₂::Point3, p₃::Point3)

Introduces a tetrahedron `t` with vertices `p₀`, `p₁`, `p₂` and `p₃`.
"""
Tetrahedron3(p₀::Point3, p₁::Point3, p₂::Point3, p₃::Point3)

"""
    ==(t₁::Tetrahedron3, t₂::Tetrahedron3)

Test for equality: two tetrahedra `t₁` and `t₂` are equal, iff `t₁` and `t₂`
have the same orientation and their sets (not sequences) of vertices are equal.
"""
==(t₁::Tetrahedron3, t₂::Tetrahedron3)

"""
    vertex(t::Tetrahedron3, i::Integer)

Returns the `i`ᵗʰ vertex modulo 4 of `t`.
"""
vertex(t::Tetrahedron3, i::Integer)

"""
    is_degenerate(t::Tetrahedron3)

Tetrahedron `t` is degenerate, if the vertices are coplanar.
"""
is_degenerate(t::Tetrahedron3)

"""
    orientation(t::Tetrahedron3)

Returns the orientation of `t`.
"""
orientation(t::Tetrahedron3)

"""
    oriented_side(t::Tetrahedron3, p::Point2)

Returns [`ON_ORIENTED_BOUNDARY`](@ref), or [`POSITIVE_SIDE`](@ref), or the
constant [`ON_NEGATIVE_SIDE`](@ref), determined by the position of point `p`.

!!! info "Precondition"

    `t` is not degenerate.
"""
oriented_side(t::Tetrahedron3, p::Point2)

"""
    bounded_side(t::Tetrahedron3, p::Point2)

Returns [`ON_BOUNDARY`](@ref), [`ON_BOUNDED_SIDE`](@ref), or else
[`ON_UNBOUNDED_SIDE`](@ref), depending on where point `p` is.

!!! info "Precondition"

    `t` is not degenerate.
"""
bounded_side(t::Tetrahedron3, p::Point2)

"""
    has_on_positive_side(t::Tetrahedron3, p::Point2)

Returns `true`, iff `p` lies on the positive side of `t`.
"""
has_on_positive_side(t::Tetrahedron3, p::Point2)

"""
    has_on_negative_side(t::Tetrahedron3, p::Point2)

Returns `true`, iff `p` lies on the negative side of `t`.
"""
has_on_negative_side(t::Tetrahedron3, p::Point2)

"""
    has_on_boundary(t::Tetrahedron3, p::Point2)

Returns `true`, iff `p` lies on the boundary of `t`.
"""
has_on_boundary(t::Tetrahedron3, p::Point2)

"""
    has_on_bounded_side(t::Tetrahedron3, p::Point2)

Returns `true`, iff `p` lies properly inside of `t`.
"""
has_on_bounded_side(t::Tetrahedron3, p::Point2)

"""
    has_on_unbounded_side(t::Tetrahedron3, p::Point2)

Returns `true`, iff `p` lies properly outside of `t`.
"""
has_on_unbounded_side(t::Tetrahedron3, p::Point2)

"""
    volume(t::Tetrahedron3)

Returns the signed volume of `t`.
"""
volume(t::Tetrahedron3)

"""
    bbox(t::Tetrahedron3)

Returns a bounding box containing `t`.
"""
bbox(t::Tetrahedron3)

"""
    transform(t::Tetrahedron3, at::AffTransformation3)

Returns the tetrahedron obtained by applying `at` on the four vertices of `t`.
"""
transform(t::Tetrahedron3, at::AffTransformation3)
