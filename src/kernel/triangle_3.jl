@doc raw"""
    Triangle3

An object `t` of the type [`Triangle3`](@ref) is a triangle in the
three-dimensional Euclidean space ``Ε^2``.

As the triangle is not a full-dimensional object, there is only a test whether
a point lies on the triangle or not.
"""
Triangle3

"""
    Triangle3(p::Point3, q::Point3, r::Point3)

Introduces a triangle `t` with vertices `p`, `q` and `r`.
"""
Triangle3(p::Point3, q::Point3, r::Point3)

"""
    ==(t₁::Triangle3, t₂::Triangle3)

Test for equality: two triangles `t₁` and `t₂` are equal, iff there exists a
cyclic permutation of the vertices of `t₂`, such that  they are equal to the
vertices of `t₁`.
"""
==(t₁::Triangle3, t₂::Triangle3)

"""
    vertex(t::Triangle3, i::Integer)

Returns the `i`ᵗʰ vertex modulo 3 of `t`.
"""
vertex(t::Triangle3, i::Integer)

"""
    supporting_plane(t::Triangle3)

Returns the supporting plane of `t`, with same orientation.
"""
supporting_plane(t::Triangle3)

"""
    is_degenerate(t::Triangle3)

Triangle `t` is degenerate, if the vertices are collinear.
"""
is_degenerate(t::Triangle3)

"""
    squared_area(t::Triangle3)

Returns a square of the area of `t`.
"""
squared_area(t::Triangle3)

"""
    bbox(t::Triangle3)

Returns a bounding box containing `t`.
"""
bbox(t::Triangle3)

"""
    transform(t::Triangle3, at::AffTransformation3)

Returns the triangle obtained by applying `at` on the three vertices of `t`.
"""
transform(t::Triangle3, at::AffTransformation3)
