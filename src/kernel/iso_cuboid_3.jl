@doc raw"""
    IsoCuboid3

An object `c` of the data type [`IsoCuboid3`](@ref) is a rectangle in the
Euclidean space ``Ε^3`` with edges parallel to the ``x``, ``y`` and ``z`` axis
of the coordinate system.

Although they are represented in a canonical form by only two vertices, namely
the lower left and the upper right vertex with respect to Cartesian ``xyz``
coordinates, we provide functions for "accessing" the other vertices as well.

Iso-oriented cuboids and bounding boxes are quite similar. The difference
however is that bounding boxes have always double coordinates, whereas the
coordinate type of an iso-oriented cuboid is chosen by the user.
"""
IsoCuboid3

"""
    IsoCuboid3(p::Point3, q::Point3)

Introduces an iso-oriented cuboid `c` with diagonal opposite vertices `p` and
`q`.

Note that the object is brought in the canonical form.
"""
IsoCuboid3(p::Point3, q::Point3)

"""
    IsoCuboid3(p::Point3, q::Point3, ::Integer)

Introduces an iso-oriented cuboid `c` with diagonal opposite vertices `p` and
`q`.

Note that the object is brought in the canonical form.
"""
IsoCuboid3(p::Point3, q::Point3, ::Integer)

@doc raw"""
    IsoCuboid3(left::Point3, right::Point3, bottom::Point3, top::Point3,
               far::Point3, close::Point3)

Introduces an iso-oriented cuboid `c` whose minimal ``x`` coordinate is the
one of `left`, the maximal ``x`` coordinate is the one of `right`, the minimal
``y`` coordinate is the one of `bottom`, the maximal ``y`` coordinate is the one
of ``top``, the minimal ``z`` coordinate is the one of ``far``, the maximal
``z`` coordinate is the one of ``close``.
"""
IsoCuboid3(left::Point3, right::Point3, bottom::Point3, top::Point3,
           far::Point3, close::Point3)

"""
    IsoCuboid3(min_hx::Real, min_hy::Real, min_hz::Real,
               max_hx::Real, max_hy::Real, max_hz::Real, hw::Real = 1)

Introduces an iso-oriented cuboid `c` with diagonal opposite vertices
`(min_hx/hw, min_hy/hw, min_hz/hw)` and `(max_hx/hw, max_hy/hw, max_hz/hw)`.

!!! info "Precondition"

    `hw` ``≠`` `0`.
"""
IsoCuboid3(min_hx::Real, min_hy::Real, min_hz::Real,
           max_hx::Real, max_hy::Real, max_hz::Real, hw::Real = 1) =
    IsoCuboid3(convert.(FT, (min_hx, min_hy, min_hz,
                             max_hx, max_hy, max_hz, hw))...)

"""
    IsoCuboid3(bbox::Bbox3)

If [`RT`](@ref) is constructible from `Float64`, introduces an iso-oriented
cuboid from `bbox`.
"""
IsoCuboid3(bbox::Bbox3)

"""
    ==(c₁::IsoCuboid3, c₂::IsoCuboid3)

Test for equality: two iso-oriented cuboids are equal, iff their lower left and
upper right vertices are equal.
"""
==(c₁::IsoCuboid3, c₂::IsoCuboid3)

"""
    vertex(r::IsoCuboid3, i::Integer)

Returns the `i`ᵗʰ vertex modulo 8 of `c`.
"""
vertex(c::IsoCuboid3, i::Integer)

"""
    min(c::IsoCuboid3)

Returns the smallest vertex of `c` (= `vertex(c, 0)`).
"""
min(c::IsoCuboid3)

"""
    max(c::IsoCuboid3)

Returns the largest vertex of `c` (= `vertex(c, 7)`).
"""
max(c::IsoCuboid3)

"""
    xmin(c::IsoCuboid3)

Returns smallest Cartesian ``x``-coordinate in `c`.
"""
xmin(c::IsoCuboid3)

"""
    ymin(c::IsoCuboid3)

Returns smallest Cartesian ``y``-coordinate in `c`.
"""
ymin(c::IsoCuboid3)

"""
    zmin(c::IsoCuboid3)

Returns smallest Cartesian ``z``-coordinate in `c`.
"""
zmin(c::IsoCuboid3)

"""
    xmax(c::IsoCuboid3)

Returns largest Cartesian ``x``-coordinate in `c`.
"""
xmax(c::IsoCuboid3)

"""
    ymax(c::IsoCuboid3)

Returns largest Cartesian ``y``-coordinate in `c`.
"""
ymax(c::IsoCuboid3)

"""
    zmax(c::IsoCuboid3)

Returns largest Cartesian ``z``-coordinate in `c`.
"""
zmax(c::IsoCuboid3)

"""
    min_coord(c::IsoCuboid3, i::Integer)

Returns `i`ᵗʰ Cartesian coordinate of the smallest vertex of `c`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``
"""
min_coord(c::IsoCuboid3, i::Integer)

"""
    max_coord(c::IsoCuboid3, i::Integer)

Returns `i`ᵗʰ Cartesian coordinate of the largest vertex of `c`.

!!! info "Precondition"

    ``0 ≤ i ≤ 2``
"""
max_coord(r::IsoCuboid3, i::Integer)

"""
    is_degenerate(c::IsoCuboid3)

`c` is degenerate, if all vertices are coplanar.
"""
is_degenerate(c::IsoCuboid3)

"""
    bounded_side(c::IsoCuboid3, p::Point3)

Returns either [`ON_UNBOUNDED_SIDE`](@ref), [`ON_BOUNDED_SIDE`](@ref), or the
constant [`ON_BOUNDARY`](@ref), depending on where point `p` is.
"""
bounded_side(c::IsoCuboid3, p::Point3)

"""
    has_on_boundary(c::IsoCuboid3, p::Point3)

Returns `true`, iff `p` lies on the boundary of `r`.
"""
has_on_boundary(c::IsoCuboid3, p::Point3)

"""
    has_on_bounded_side(c::IsoCuboid3, p::Point3)

Returns `true`, iff `p` lies properly inside of `r`.
"""
has_on_bounded_side(c::IsoCuboid3, p::Point3)

"""
    has_on_unbounded_side(c::IsoCuboid3, p::Point3)

Returns `true`, iff `p` lies properly outside of `r`.
"""
has_on_unbounded_side(c::IsoCuboid3, p::Point3)

"""
    volume(c::IsoCuboid3)

Returns the volume of `c`.
"""
volume(c::IsoCuboid3)

"""
    bbox(c::IsoCuboid3)

Returns a bounding box containing `c`.
"""
bbox(c::IsoCuboid3)

@doc raw"""
    transform(c::IsoCuboid3, t::AffTransformation2)

Returns the iso-oriented cuboid obtained by applying `t` on the smallets
and largest corner of `c`.

!!! info "Precondition"

    The angle at a rotation must be a multiple of ``π \over 2``, otherwise the
    resulting cuboid does not have the same size. Note that rotating about an
    arbitrary angle can even result in a degenerate iso-oriented cuboid.
"""
transform(c::IsoCuboid3, t::AffTransformation2)
