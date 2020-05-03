@doc raw"""
    Triangle2

An object `t` of the type [`Triangle2`](@ref) is a triangle in the
two-dimensional Euclidean plane ``Ε^2``.

Triangle `t` is oriented, i.e., its boundary has clockwise or
counterclockwise orientation. We call the side to the left of the boundary the
positive side and the side to the right of the boundary the negative side.

The boundary of a triangle splits the plane in two open regions, a bounded one
and an unbounded one.
"""
Triangle2

"""
    Triangle2(p::Point2, q::Point2, r::Point2)

Introduces a triangle `t` with vertices `p`, `q` and `r`.
"""
Triangle2(p::Point2, q::Point2, r::Point2)

"""
    ==(t::Triangle2, t2::Triangle2)

Test for equality: two triangles are equal, iff there exists a cyclic
permutation of the vertices of ``t2``, such that they are equal to the vertices
of `t`.
"""
==(t::Triangle2, t2::Triangle2)

"""
    vertex(t::Triangle2, i::Integer)

Returns the `i`ᵗʰ vertex module 3 of `t`.
"""
vertex(t::Triangle2, i::Integer)

"""
    is_degenerate(t::Triangle2)

Triangle `t` is degenerate, if the vertices are collinear.
"""
is_degenerate(t::Triangle2)

"""
    orientation(t::Triangle2)

Returns the orientation of `t`.
"""
orientation(t::Triangle2)

"""
    oriented_side(t::Triangle2, p::Point2)

Returns [`ON_ORIENTED_BOUNDARY`](@ref), or [`POSITIVE_SIDE`](@ref), or the
constant [`ON_NEGATIVE_SIDE`](@ref), determined by the position of point `p`.

!!! info "Precondition"

    `t` is not degenerate.
"""
oriented_side(t::Triangle2, p::Point2)

"""
    bounded_side(t::Triangle2, p::Point2)

Returns [`ON_BOUNDARY`](@ref), [`ON_BOUNDED_SIDE`](@ref), or else
[`ON_UNBOUNDED_SIDE`](@ref), depending on where point `p` is.

!!! info "Precondition"

    `t` is not degenerate.
"""
bounded_side(t::Triangle2, p::Point2)

"""
    has_on_positive_side(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies on the positive side of `t`.
"""
has_on_positive_side(t::Triangle2, p::Point2)

"""
    has_on_negative_side(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies on the negative side of `t`.
"""
has_on_negative_side(t::Triangle2, p::Point2)

"""
    has_on_boundary(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies on the boundary of `t`.
"""
has_on_boundary(t::Triangle2, p::Point2)

"""
    has_on_bounded_side(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies properly inside of `t`.
"""
has_on_bounded_side(t::Triangle2, p::Point2)

"""
    has_on_unbounded_side(t::Triangle2, p::Point2)

Returns `true`, iff `p` lies properly outside of `t`.
"""
has_on_unbounded_side(t::Triangle2, p::Point2)

"""
    opposite(t::Triangle2)

Returns a triangle where the boundary is oriented the other way round (this
flips the positive and negative side, but not the bounded and unbounded side).
"""
opposite(t::Triangle2)

"""
    area(t::Triangle2)

Returns the signed area of `t`.
"""
area(t::Triangle2)

"""
    bbox(t::Triangle2)

Returns a bounding box containing `t`.
"""
bbox(t::Triangle2)

"""
    transform(t::Triangle2, at::AffTransformation2)

Returns the triangle obtained by applying `at` on the three vertices of `t`.
"""
transform(t::Triangle2, at::AffTransformation2)
