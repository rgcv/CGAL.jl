@doc raw"""
    IsoRectangle2

An object `r` of the data type [`IsoRectangle2`](@ref) is a rectangle in the
Euclidean plane ``Ε^2`` with sides parallel to the ``x`` and ``y`` axis
of the coordinate system.

Although they are represented in a canonical form by only two vertices, namely
the lower left and the upper right vertex, we provide functions for "accessing"
the other vertices as well. The vertices are returned in counterclockwise order.

Iso-oriented rectangles and bounding boxes are quite similar. The difference
however is that bounding boxes have always double coordinates, whereas the
coordinate type of an iso-oriented rectangle is chosen by the user.
"""
IsoRectangle2

"""
    IsoRectangle2(p::Point2, q::Point2)

Introduces an iso-oriented rectangle `r` with diagonal opposite vertices `p` and
`q`.

Note that the object is brought in the canonical form.
"""
IsoRectangle2(p::Point2, q::Point2)

"""
    IsoRectangle2(p::Point2, q::Point2, ::Integer)

Introduces an iso-oriented rectangle `r` with diagonal opposite vertices `p` and
`q`.

Note that the object is brought in the canonical form.
"""
IsoRectangle2(p::Point2, q::Point2, ::Integer)

@doc raw"""
    IsoRectangle(left::Point2, right::Point2, bottom::Point2, top::Point2)

Introduces an iso-oriented rectangle `r` whose minimal ``x`` coordinate is the
one of `left`, the maximal ``x`` coordinate is the one of `right`, the minimal
``y`` coordinate is the one of `bottom`, the maximal ``y`` coordinate is the one
of ``top``.
"""
IsoRectangle2(left::Point2, right::Point2, bottom::Point2, top::Point2)

"""
    IsoRectangle(min_hx::RT, min_hy::RT, max_hx::RT, max_hy::RT, hw::RT = RT(1))
    IsoRectangle(min_hx::Real, min_hy::Real, max_hx::Real, max_hy::Real, hw::Real = 1)

Introduces an iso-oriented rectangle `r` with diagonal opposite vertices
`(min_hx/hw, min_hy/hw)` and `(max_hx/hw, max_hy/hw)`.

!!! info "Precondition"

    `hw` ``≠`` `0`.
"""
IsoRectangle2(min_hx, min_hy, max_hx, max_hy, hw = 1)

IsoRectangle2(min_hx::Real, min_hy::Real, max_hx::Real, max_hy::Real, hw::Real = 1) =
    IsoRectangle2(convert.(FT, (min_hx, min_hy, max_hx, max_hy, hw))...)

"""
    IsoRectangle2(bbox::Bbox2)

If [`RT`](@ref) is constructible from `Float64`, introduces an iso-oriented
rectangle from `bbox`.
"""
IsoRectangle2(bbox::Bbox2)

"""
    ==(r::IsoRectangle2, r2::IsoRectangle2)

Test for equality: two iso-oriented rectangles are equal, iff their lower left
and upper right vertices are equal.
"""
==(r::IsoRectangle2, r2::IsoRectangle2)

"""
    vertex(r::IsoRectangle2, i::Integer)

Returns the `i`ᵗʰ vertex modulo 4 of `r` in counterclockwise order, starting
with the lower left vertex.
"""
vertex(r::IsoRectangle2, i::Integer)

"""
    min(r::IsoRectangle2)

Returns the lower left vertex of `r` (= `vertex(r, 0)`).
"""
min(r::IsoRectangle2)

"""
    max(r::IsoRectangle2)

Returns the upper right vertex of `r` (= `vertex(r, 2)`).
"""
max(r::IsoRectangle2)

"""
    xmin(r::IsoRectangle2)

Returns the ``x`` coordinate of the lower left vertex of `r`.
"""
xmin(r::IsoRectangle2)

"""
    ymin(r::IsoRectangle2)

Returns the ``y`` coordinate of the lower left vertex of `r`.
"""
ymin(r::IsoRectangle2)

"""
    xmax(r::IsoRectangle2)

Returns the ``x`` coordinate of the upper right vertex of `r`.
"""
xmax(r::IsoRectangle2)

"""
    ymax(r::IsoRectangle2)

Returns the ``y`` coordinate of the upper right vertex of `r`.
"""
ymax(r::IsoRectangle2)

"""
    min_coord(r::IsoRectangle2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of the lower left vertex of `r`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``
"""
min_coord(r::IsoRectangle2, i::Integer)

"""
    max_coord(r::IsoRectangle2, i::Integer)

Returns the `i`ᵗʰ Cartesian coordinate of the upper right vertex of `r`.

!!! info "Precondition"

    ``0 ≤ i ≤ 1``
"""
max_coord(r::IsoRectangle2, i::Integer)

"""
    is_degenerate(r::IsoRectangle2)

`r` is degenerate, if all vertices are collinear.
"""
is_degenerate(r::IsoRectangle2)

"""
    bounded_side(r::IsoRectangle2, p::Point2)

Returns either [`ON_UNBOUNDED_SIDE`](@ref), [`ON_BOUNDED_SIDE`](@ref), or the
constant [`ON_BOUNDARY`](@ref), depending on where point `p` is.
"""
bounded_side(r::IsoRectangle2, p::Point2)

"""
    has_on_boundary(r::IsoRectangle2, p::Point2)

Returns `true`, iff `p` lies on the boundary of `r`.
"""
has_on_boundary(c::IsoRectangle2, p::Point2)

"""
    has_on_bounded_side(r::IsoRectangle2, p::Point2)

Returns `true`, iff `p` lies properly inside of `r`.
"""
has_on_bounded_side(c::IsoRectangle2, p::Point2)

"""
    has_on_unbounded_side(r::IsoRectangle2, p::Point2)

Returns `true`, iff `p` lies properly outside of `r`.
"""
has_on_unbounded_side(c::IsoRectangle2, p::Point2)

"""
    area(r::IsoRectangle2)

Returns the area of `r`.
"""
area(r::IsoRectangle2)

"""
    bbox(r::IsoRectangle2)

Returns a bounding box containing `r`.
"""
bbox(r::IsoRectangle2)

@doc raw"""
    transform(r::IsoRectangle2, t::AffTransformation2)

Returns the iso-oriented rectangle obtained by applying `t` on the lower left
and upper right corner of `r`.

!!! info "Precondition"

    The angle at a rotation must be a multiple of ``π \over 2``, otherwise the
    resulting rectangle does not have the same side length. Note that rotating
    about an arbitrary angle can even result in a degenerate iso-oriented
    rectangle.
"""
transform(r::IsoRectangle2, t::AffTransformation2)
