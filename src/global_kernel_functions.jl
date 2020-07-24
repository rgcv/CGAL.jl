export angle,
       approximate_angle,
       approximate_dihedral_angle,
       area,
       are_ordered_along_line, are_strictly_ordered_along_line,
       barycenter,
       bisector,
       centroid,
       circumcenter,
       collinear_are_ordered_along_line,
       collinear_are_strictly_ordered_along_line,
       collinear,
       compare_dihedral_angle,
       compare_distance_to_point,
       compare_lexicographically,
       compare_signed_distance_to_line,
       compare_signed_distance_to_plane,
       compare_slope,
       compare_squared_distance,
       compare_squared_radius,
       compare_x, compare_y, compare_xy, compare_yx, compare_xyz,
       compare_x_at_y, compare_y_at_x,
       coplanar,
       coplanar_orientation,
       coplanar_side_of_bounded_circle,
       cross_product,
       determinant,
       do_intersect,
       has_larger_distance_to_point,
       has_larger_signed_distance_to_line,
       has_larger_signed_distance_to_plane,
       has_smaller_distance_to_point,
       has_smaller_signed_distance_to_line,
       has_smaller_signed_distance_to_plane,
       intersection,
       l_infinity_distance,
       left_turn,
       lexicographically_xy_larger, lexicographically_xy_larger_or_equal,
       lexicographically_xy_smaller, lexicographically_xy_smaller_or_equal,
       lexicographically_xyz_smaller, lexicographically_xyz_smaller_or_equal,
       max_vertex,
       midpoint,
       min_vertex,
       normal,
       orientation,
       orthogonal_vector,
       parallel,
       radical_line,
       radical_plane,
       rational_rotation_approximation,
       right_turn,
       scalar_product,
       side_of_bounded_circle,
       side_of_bounded_sphere,
       side_of_oriented_circle,
       side_of_oriented_sphere,
       squared_area,
       squared_distance,
       squared_radius,
       unit_normal,
       volume,
       x_equal,
       y_equal,
       z_equal,
       do_overlap

"""
    angle(u::Vector23, v::Vector23)

Returns [`OBTUSE`](@ref), [`RIGHT`](@ref) or [`ACUTE`](@ref) depending on the
angle formed by the two vectors `u` and `v`.
"""
angle(u::Vector23, v::Vector23)

"""
    angle(p::Point23, q::Point23, r::Point23)

Returns [`OBTUSE`](@ref), [`RIGHT`](@ref) or [`ACUTE`](@ref) depending on the
angle formed by the three points `p`, `q`, `r` (`q` being the vertex of the
angle).

The returned value is the same as `angle(p - q, r - q)`.
"""
angle(p::Point23, q::Point23, r::Point23)

"""
    angle(p::Point23, q::Point23, r::Point23, s::Point23)

Returns [`OBTUSE`](@ref), [`RIGHT`](@ref) or [`ACUTE`](@ref) depending on the
angle formed by the two vectors `pq`, `rs`.

The returned value is the same as `angle(q - p, s - r)`.
"""
angle(p::Point23, q::Point23, r::Point23, s::Point23)

"""
    angle(p::Point3, q::Point3, r::Point3, v::Vector3)

Returns [`OBTUSE`](@ref), [`RIGHT`](@ref) or [`ACUTE`](@ref) depending on the
angle formed by the normal of the triangle `pqr` and the vector `v`.
"""
angle(p::Point3, q::Point3, r::Point3, v::Vector3)


"""
    approximate_angle(p::Point3, q::Point3, r::Point3)

Returns an approximation of the angle between `p - q` and `r - q`.

The angle is given in degrees.

!!! info "Precondition"

    `p` and `r` are not equal to `q`.
"""
approximate_angle(p::Point3, q::Point3, r::Point3)

"""
    approximate_angle(u::Vector3, v::Vector3)

Returns an approximation of the angle between `u` and `v`.

The angle is given in degrees.

!!! info "Precondition"

    `u` and `v` are not equal to the null vector.
"""
approximate_angle(u::Vector3, v::Vector3)


"""
    approximate_dihedral_angle(p::Point3, q::Point3, r::Point3, s::Point3)

Returns an approximation of the signed dihedral angle in the tetrahedron `pqrs`
of edge `pq`.

The sign is negative if `orientation(p,q,r,s)` is `NEGATIVE` and positive
otherwise.  The angle is given in degrees.

!!! info "Precondition"
    `p`,`q`,`r` and `p`,`q`,`s` are not collinear.
"""
approximate_dihedral_angle(p::Point3, q::Point3, r::Point3, s::Point3)


"""
    area(p::Point2, q::Point2, r::Point2)

Returns the signed area of the triangle defined by the points `p`, `q` and `r`.
"""
area(p::Point2, q::Point2, r::Point2)


"""
    are_ordered_along_line(p::Point23, q::Point23, r::Point23)

Returns `true`, iff the three points are collinear and `q` lies between `p` and
`r`.

Note that `true` is returned, if `q==p` or `q==r`.
"""
are_ordered_along_line(p::Point23, q::Point23, r::Point23)


"""
    are_strictly_ordered_along_line(p::Point23, q::Point23, r::Point23)

Returns `true`, iff the three points are collinear and `q` lies strictly between
`p` and `r`.

Note that `false` is returned, if `q==p` or `q==r`.
"""
are_strictly_ordered_along_line(p::Point23, q::Point23, r::Point23)


"""
    barycenter(p₁::Point23, w₁::Real, p₂::Point23)

Compute the barycenter of the points `p₁` and `p₂` with corresponding weights
`w₁` and `1-w₁`.
"""
barycenter(p₁::Point23, w₁::Real, p₂::Point23)

"""
    barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real)

Compute the barycenter of the points `p₁` and `p₂` with corresponding weights
`w₁` and `w₂`.
"""
barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real)

"""
    barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real, p₃::Point23)

Compute the barycenter of the points `p₁`,`p₂` and `p₃` with corresponding
weights `w₁,w₂` and `1-w₁-w₂`.
"""
barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real, p₃::Point23)

"""
    barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real,
               p₃::Point23, w₃::Real)

Compute the barycenter of the points `p₁`,`p₂` and `p₃` with corresponding
weights `w₁,w₂` and `w₃`.
"""
barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real, p₃::Point23, w₃::Real)

"""
    barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real,
               p₃::Point23, w₃::Real, p₄::Point23)

Compute the barycenter of the points `p₁`,`p₂`, `p₃` and `p₄` with corresponding
weights `w₁,w₂,w₃` and `1-w₁-w₂-w₃`.
"""
barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real, p₃::Point23, w₃::Real,
           p₄::Point23)

"""
    barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real,
               p₃::Point23, w₃::Real, p4::Point23, w4::Real)

Compute the barycenter of the points `p₁`,`p₂`, `p₃` and `p₄` with corresponding
weights `w₁,w₂,w₃` and `w₄`.
"""
barycenter(p₁::Point23, w₁::Real, p₂::Point23, w₂::Real, p₃::Point23, w₃::Real,
           p₄::Point23, w₄::Real)

for P ∈ (:Point2, :Point3)
    @eval begin
        @cxxdereference barycenter(p₁::$P, w₁::Real, p₂::$P) =
            barycenter(p₁, convert(FT, w₁), p₂)
        @cxxdereference barycenter(p₁::$P, w₁::Real, p₂::$P, w₂::Real) =
            barycenter(p₁, convert(FT, w₁), p₂, convert(FT, w₂))
        @cxxdereference barycenter(p₁::$P, w₁::Real, p₂::$P, w₂::Real, p₃::$P) =
            barycenter(p₁, convert(FT, w₁), p₂, convert(FT, w₂), p₃)
        @cxxdereference barycenter(p₁::$P, w₁::Real, p₂::$P, w₂::Real, p₃::$P, w₃::Real) =
            barycenter(p₁, convert(FT, w₁), p₂, convert(FT, w₂), p₃, convert(FT, w₃))
        @cxxdereference barycenter(p₁::$P, w₁::Real, p₂::$P, w₂::Real, p₃::$P, w₃::Real, p₄::$P) =
            barycenter(p₁, convert(FT, w₁), p₂, convert(FT, w₂), p₃, convert(FT, w₃), p₄)
        @cxxdereference barycenter(p₁::$P, w₁::Real, p₂::$P, w₂::Real, p₃::$P, w₃::Real, p₄::$P, w₄::Real) =
            barycenter(p₁, convert(FT, w₁), p₂, convert(FT, w₂), p₃, convert(FT, w₃), p₄, convert(FT, w₄))
    end
end


"""
    bisector(p::Point2, q::Point2)

Constructs the bisector line of two points `p` and `q`.

The bisector is oriented in such a way that `p` lies on its positive side.

!!! info "Precondition"

    `p` and `q` are not equal.
"""
bisector(p::Point2, q::Point2)

"""
    bisector(l₁::Line2, l₂::Line2)

Constructs the bisector of the two lines `l₁` and `l₂`.

In the general case, the bisector has the direction of the vector which is the
sum of the normalized directions of the two lines, and which passes through the
intersection of `l₁` and `l₂`.  If `l₁` and `l₂` are parallel, then the bisector
is defined as the line which has the same direction as `l₁`, and which is at the
same distance from `l₁` and `l₂`.  This function requires that [`RT`](@ref)
supports the [`sqrt()`](@ref) operation.
"""
bisector(l₁::Line2, l₂::Line2)

"""
    bisector(p::Point3, q::Point3)

Constructs the bisector plane of the two points `p` and `q`.

The bisector is oriented in such a way that `p` lies on its positive side.

!!! info "Precondition"

    `p` and `q` are not equal.
"""
bisector(p::Point3, q::Point3)

"""
    bisector(h₁::Plane3, h₂::Plane3)

Constructs the bisector of the two planes `h₁` and `h₂`.

In the general case, the bisector has a normal vector which has the same
direction as the sum of the normalized normal vectors of the two planes, and
passes through the intersection of `h₁` and `h₂`.  If `h₁` and `h₂` are parallel,
then the bisector is defined as the plane which has the same oriented normal
vector as `l₁`, and which is at the same distance from `h₁` and `h₂`.  This
function requires that [`RT`](@ref) supports the [`sqrt()`](@ref) operation.
"""
bisector(h₁::Plane3, h₂::Plane3)


"""
    centroid(p::Point23, q::Point23, r::Point23)

Compute the centroid of the points `p`, `q`, and `r`.
"""
centroid(p::Point23, q::Point23, r::Point23)

"""
    centroid(p::Point23, q::Point23, r::Point23, s::Point23)

Compute the centroid of the points `p`, `q`, `r`, and `s`.
"""
centroid(p::Point23, q::Point23, r::Point23, s::Point23)

"""
    centroid(t::Triangle23)

Compute the centroid of the triangle `t`.
"""
centroid(t::Triangle23)

"""
    centroid(t::Tetrahedron3)

Compute the centroid of the tetrahedron `t`.
"""
centroid(t::Tetrahedron3)


"""
    circumcenter(p::Point23, q::Point23)

Compute the center of the smallest circle passing through the points `p` and
`q`.

Note: this is the same as `midpoint(p, q)` but is provided for homogeneity.
"""
circumcenter(p::Point23, q::Point23)

"""
    circumcenter(p::Point23, q::Point23, s::Point23)

Compute the center of the circle passing through the points `p`, `q`, and `r`.

!!! info "Precondition"

    `p`, `q`, and `r` are not collinear.
"""
circumcenter(p::Point23, q::Point23, r::Point23)

"""
    circumcenter(t::Triangle23)

Compute the center of the circle passing through the vertices of `t`.

!!! info "Precondition"

    `t` is not degenerate.
"""
circumcenter(t::Triangle23)

"""
    circumcenter(t::Tetrahedron3)

Compute the center of the sphere passing through the vertices of `t`.
"""
circumcenter(t::Tetrahedron3)


"""
    collinear_are_ordered_along_line(p::Point23, q::Point23, r::Point23)

Returns `true`, iff `q` lies between `p` and `r`.

!!! info "Precondition"

    `p`, `q` and `r` are collinear.
"""
collinear_are_ordered_along_line(p::Point23, q::Point23)


"""
    collinear_are_strictly_ordered_along_line(p::Point23, q::Point23, r::Point23)

Returns `true`, iff `q` lies strictly between `p` and `r`.

!!! info "Precondition"

    `p`, `q` and `r` are collinear.
"""
collinear_are_strictly_ordered_along_line(p::Point23, q::Point23)


"""
    collinear(p::Point23, q::Point23, r::Point23)

Returns `true`, iff `p`, `q`, and `r` are collinear.
"""
collinear(p::Point23, q::Point23, r::Point23)


@doc raw"""
    compare_dihedral_angle(a₁::Point3, b₁::Point3, c₁::Point3, d₁::Point3, cosine::Real)

Compares the dihedral angles ``θ_1`` and ``θ_2``, where ``θ_1`` is the dihedral
angle, in ``[0, π]``, of the tetrahedron `(a₁, b₁, c₁, d₁)` at the edge `(a₁,
b₁)`, and ``θ_2`` is the angle, in ``[0, π]``, such that ``cos(θ_2) = cosine``.

!!! info "Precondition"

    `a₁`, `b₁`, `c₁` are not collinear, and `a₁`, `b₁`, `d₁` are not collinear.
"""
compare_dihedral_angle(a₁::Point3, b₁::Point3, c₁::Point3, d₁::Point3, cosine::Real)

@cxxdereference compare_dihedral_angle(a₁::Point3, b₁::Point3, c₁::Point3, d₁::Point3, cosine::Real) =
    compare_dihedral_angle(a₁, b₁, c₁, d₁, convert(FT, cosine))

@doc raw"""
    compare_dihedral_angle(a₁::Point3, b₁::Point3, c₁::Point3, d₁::Point3,
                           a₂::Point3, b₂::Point3, c₂::Point3, d₂::Point3)

Compares the dihedral angles ``θ_1`` and ``θ_2``, where ``θ_i`` is the dihedral
angle in the tetrahedron `(aᵢ, bᵢ, cᵢ, dᵢ)` at the edge `(aᵢ, bᵢ)`.

These two angles are computed in ``[0, π]``.  The result is the same as
`compare_dihedral_angle(b₁-a₁, c₁-a₁, d₁-a₁, b₂-a₂, c₂-a₂, d₂-a₂)`.

!!! info "Precondition"

    For ``i ∈ {1, 2}``, `aᵢ`, `bᵢ`, `cᵢ` are not collinear, and `aᵢ`,
    `bᵢ`, `dᵢ` are not collinear.
"""
compare_dihedral_angle(a₁::Point3, b₁::Point3, c₁::Point3, d₁::Point3,
                       a₂::Point3, b₂::Point3, c₂::Point3, d₂::Point3)


@doc raw"""
    compare_dihedral_angle(u₁::Vector3, v₁::Vector3, w₁::Vector3, cosine::Real)

Compares the dihedral angles ``θ_1`` and ``θ_2``, where ``θ_1`` is the dihedral
angle, in ``[0, π]``, between the vectorial planes defined by `(u₁, v₁)` and
`(u₁, w₁)`, and ``θ_2`` is the angle, in ``[0, π]``, such that ``cos(θ_2) =
cosine`.

!!! info "Precondition"

    `u₁` and `v₁` are not collinear, and `u₁` and `w₁` are not collinear.
"""
compare_dihedral_angle(u₁::Vector3, v₁::Vector3, w₁::Vector3, cosine::Real)

@cxxdereference compare_dihedral_angle(u₁::Vector3, v₁::Vector3, w₁::Vector3, cosine) =
    compare_dihedral_angle(u₁, v₁, w₁, convert(FT, cosine))

@doc raw"""
    compare_dihedral_angle(u₁::Vector3, v₁::Vector3, w₁::Vector3,
                           u₂::Vector3, v₂::Vector3, w₂::Vector3)

Compares the dihedral angles ``θ_1`` and ``θ_2``, where ``θ_i`` is the dihedral
angle between the vectorial planes defined by `(uᵢ, vᵢ)` and `(uᵢ, wᵢ)`.

These two angles are computed in ``[0, π]``.

!!! info "Precondition"

    For ``i ∈ {1, 2}``, `uᵢ` and `vᵢ` are not collinear, and `uᵢ` and `wᵢ` are
    not collinear.
"""
compare_dihedral_angle(u₁::Vector3, v₁::Vector3, w₁::Vector3,
                       u₂::Vector3, v₂::Vector3, w₂::Vector3)


"""
    compare_distance_to_point(p::Point23, q::Point23, r::Point23)

Compares the distances of points `q` and `r` to `p`.

Returns [`SMALLER`](@ref), iff `q` is closer to `p` than `r`, [`LARGER`](@ref)
iff `r` is closer to `p` than `q`, and [`EQUAL`](@ref) otherwise.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point`()](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
compare_distance_to_point(p::Point23, q::Point23, r::Point23)


"""
    compare_lexicographically(p::Point2, q::Point2)

Compares the Cartesian coordinates of points `p` and `q` lexicographically in
``xy`` order: first ``x``-coordinates are compared, if they are equal,
``y``-coordinates are compared.

This is the same function as `compare_xy`.
"""
compare_lexicographically(p::Point2, q::Point2)

"""
    compare_lexicographically(p::Point3, q::Point3)

Compares the Cartesian coordinates of points `p` and `q` lexicographically in
``xyz`` order: first ``x``-coordinates are compared, if they are equal,
``y``-coordinates are compared, and if both ``x``- and ``y``- coordinate are
equal, ``z``-coordinates are compared.

This is the same function as `compare_xyz`.
"""
compare_lexicographically(p::Point3, q::Point3)


"""
    compare_signed_distance_to_line(l::Line2, p::Point2, q::Point2)

Returns [`LARGER`](@ref) iff the signed distance of `p` and `l` is larger than
the signed distance of `q` and `l`, [`SMALLER`](@ref), iff it is smaller, and
[`EQUAL`](@ref) iff both are equal.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
compare_signed_distance_to_line(l::Line2, p::Point2, q::Point2)

"""
    compare_signed_distance_to_line(p::Point2, q::Point2, r::Point2, s::Point2)

Returns [`LARGER`](@ref) iff the signed distance of `r` and `l` is larger than
the signed distance of `s` and `l`, [`SMALLER`](@ref), iff it is smaller, and
[`EQUAL`](@ref) iff both are equal, where `l` is the directed line through `p`
and `q`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
compare_signed_distance_to_line(p::Point2, q::Point2, r::Point2, s::Point2)


"""
    compare_signed_distance_to_plane(h::Plane3, p::Point3, q::Point3)

Returns [`LARGER`](@ref) iff the signed distance of `p` and `h` is larger than
the signed distance of `q` and `h`, [`SMALLER`](@ref), iff it is smaller, and
[`EQUAL`](@ref) iff both are equal.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
compare_signed_distance_to_plane(h::Plane3, p::Point3, q::Point3)

"""
    compare_signed_distance_to_plane(p::Point3, q::Point3, r::Point3, s::Point3, t::Point3)

Returns [`LARGER`](@ref) iff the signed distance of `s` and `h` is larger than
the signed distance of `t` and `h`, [`SMALLER`](@ref), iff it is smaller, and
[`EQUAL`](@ref) iff both are equal, where `h` is the oriented plane through `p`,
`q` and `r`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
compare_signed_distance_to_plane(p::Point3, q::Point3, r::Point3, s::Point3, t::Point3)


"""
    compare_slope(l₁::Line2, l₂::Line2)

Compares the slopes of the lines `l₁` and `l₂`.
"""
compare_slope(l₁::Line2, l₂::Line2)

"""
    compare_slope(s₁::Segment2, s₂::Segment2)

Compares the slopes of the segments `s₁` and `s₂`, where the slope is the
variation of the ``y``-coordinate from the left to the right endpoint of the
segments.
"""
compare_slope(s₁::Segment2, s₂::Segment2)

"""
    compare_slope(p::Point3, q::Point3, r::Point3, s::Point3)

Compares the slopes of the segments `(p, q)` and `(r, s)`, where the slope is
the variation of the ``z``-coordinate from the first to the second Point23 of the
segment divided by the length of the segment.
"""
compare_slope(p::Point3, q::Point3, r::Point3, s::Point3)


"""
    compare_squared_distance(p::Point23, q::Point23, d²::Real)

Compares the squared distance of points `p` and `q` to `d²`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
compare_squared_distance(p::Point23, q::Point23, d²::Real)

compare_squared_distance(p, q, d²::Real) =
    compare_squared_distance(p, q, convert(FT, d²))


"""
    compare_squared_radius(p::Point3, r²::Real)

Compares the squared radius of the sphere of radius 0 center at `p` to `r²`.

This returns the opposite sign of `r²`.
"""
compare_squared_radius(p::Point3, r²::Real)

"""
    compare_squared_radius(p::Point3, q::Point3, r²::Real)

Compares the squared radius of the sphere defined by the points `p` and `q` to
`r²`.
"""
compare_squared_radius(p::Point3, q::Point3, r²::Real)

"""
    compare_squared_radius(p::Point3, q::Point3, r::Point3, r²::Real)

Compares the squared radius of the sphere defined by the points `p`, `q`, and
`r` to `r²`.
"""
compare_squared_radius(p::Point3, q::Point3, r::Point3, r²::Real)

"""
    compare_squared_radius(p::Point3, q::Point3, r::Point3, s::Point3, r²::Real)

Compares the squared radius of the sphere defined by the points `p`, `q`, `r`,
and `s` to `r²`.
"""
compare_squared_radius(p::Point3, q::Point3, r::Point3, s::Point3, r²::Real)

@cxxdereference compare_squared_radius(p::Point3, r²::Real) =
    compare_squared_radius(p, convert(FT, r²))
@cxxdereference compare_squared_radius(p::Point3, q::Point3, r²::Real) =
    compare_squared_radius(p, q, convert(FT, r²))
@cxxdereference compare_squared_radius(p::Point3, q::Point3, r::Point3, r²::Real) =
    compare_squared_radius(p, q, r, convert(FT, r²))
@cxxdereference compare_squared_radius(p::Point3, q::Point3, r::Point3, s::Point3, r²::Real) =
    compare_squared_radius(p, q, r, s, convert(FT, r²))


"""
    compare_x(p::Point23, q::Point23)

Compares the ``x``-coordinates of `p` and `q`.

See also: [`compare_xy()`](@ref), [`compare_xyz()`](@ref),
[`compare_x_at_y()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_x(p::Point23, q::Point23)

"""
    compare_x(p::Point2, l₁::Line2, l₂::Line2)

Compares the ``x``-coordinates of `p` and the intersection of lines `l₁` and
`l₂`.

See also: [`compare_xy()`](@ref), [`compare_xyz()`](@ref),
[`compare_x_at_y()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_x(p::Point2, l₁::Line2, l₂::Line2)

"""
    compare_x(l::Line2, h₁::Line2, h₂::Line2)

Compares the ``x``-coordinates of the intersection of line `l` with of line `h₁`
and with line `h₂`.

See also: [`compare_xy()`](@ref), [`compare_xyz()`](@ref),
[`compare_x_at_y()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_x(l::Line2, h₁::Line2, h₂::Line2)

"""
    compare_x(l₁::Line2, l₂::Line2, h₁::Line2, h₂::Line2)

Compares the ``x``-coordinates of the intersection of lines `l₁` and `l₂` and
the intersection of lines `h₁` and `h₂`.

See also: [`compare_xy()`](@ref), [`compare_xyz()`](@ref),
[`compare_x_at_y()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_x(l₁::Line2, l₂::Line2, h₁::Line2, h₂::Line2)


"""
    compare_xy(p::Point23, q::Point23)

Compares the Cartesian coordinates of points `p` and `q` lexicographically in
``xy`` order: first ``x``-coordinates are compared, if they are equal,
``y``-coordinates are compared.

See also: [`compare_x()`](@ref), [`compare_xyz()`](@ref),
[`compare_x_at_y()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_xy(p::Point23, q::Point23)


"""
    compare_x_at_y(p::Point2, h::Line2)

Compares the ``x``-coordinates of `p` and the horizontal projection of `p` on
`h`.

!!! info "Precondition"

    `h` is not horizontal.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_x_at_y(p::Point2, h::Line2)

"""
    compare_x_at_y(p::Point2, h₁::Line2, h₂::Line2)

This function compares the ``x``-coordinates of the horizontal projection of `p`
on `h₁` and on `h₂`.

!!! info "Precondition"

    `h₁` and `h₂` are not horizontal.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_x_at_y(p::Point2, h₁::Line2, h₂::Line2)

"""
    compare_x_at_y(l₁::Line2, l₂::Line2, h::Line2)

Let `p` be the intersection of lines `l₁` and `l₂`.

This function compares the ``x``-coordinates of `p` and the horizontal
projection of `p` on `h`.

!!! info "Precondition"

    `l₁` and `l₂` intersect and are not horizontal; `h` is not horizontal.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_x_at_y(l₁::Line2, l₂::Line2, h::Line2)


"""
    compare_x_at_y(l₁::Line2, l₂::Line2, h₁::Line2, h₂::Line2)

Let `p` be the intersection of lines `l₁` and `l₂`.

This function compares the ``x`-coordinates of the horizontal projects of `p`
on `h₁` and on `h₂`.

!!! info "Precondition"

    `l₁` and `l₂` intersect and are not horizontal; `h₁` and `h₂` are not
    horizontal.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_x_at_y(l₁::Line2, l₂::Line2, h₁::Line2, h₂::Line2)


"""
    compare_y_at_x(p::Point2, h::Line2)

Compares the ``y``-coordinates of `p` and the vertical projection of `p` on `h`.

!!! info "Precondition"

    `h` is not vertical.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_y()`](@ref),
[`compare_yx()`](@ref), [`compare_z()`](@ref).
"""
compare_y_at_x(p::Point2, h::Line2)

"""
    compare_x_at_y(p::Point2, h₁::Line2, h₂::Line2)

This function compares the ``y``-coordinates of the vertical projection of `p`
on `h₁` and on `h₂`.

!!! info "Precondition"

    `h₁` and `h₂` are not vertical.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_y()`](@ref),
[`compare_yx()`](@ref), [`compare_z()`](@ref).
"""
compare_y_at_x(p::Point2, h₁::Line2, h₂::Line2)

"""
    compare_y_at_x(l₁::Line2, l₂::Line2, h::Line2)

Let `p` be the intersection of lines `l₁` and `l₂`.

This function compares the ``y``-coordinates of `p` and the vertical projection
of `p` on `h`.

!!! info "Precondition"

    `l₁`, `l₂` intersect and `h` is not vertical.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_y()`](@ref),
[`compare_yx()`](@ref), [`compare_z()`](@ref).
"""
compare_y_at_x(l₁::Line2, l₂::Line2, h::Line2)


"""
    compare_y_at_x(l₁::Line2, l₂::Line2, h₁::Line2, h₂::Line2)

Let `p` be the intersection of lines `l₁` and `l₂`.

This function compares the ``y`-coordinates of the vertical projects of `p` on
`h₁` and on `h₂`.

!!! info "Precondition"

    `l₁` and `l₂` intersect; `h₁` and `h₂` are not vertical.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_y()`](@ref),
[`compare_yx()`](@ref), [`compare_z()`](@ref).
"""
compare_y_at_x(l₁::Line2, l₂::Line2, h₁::Line2, h₂::Line2)

"""
    compare_y_at_x(p::Point2, s::Segment2)

Compares the ``y``-coordinates of `p` and the vertical projection of `p` on `s`.

If `s` is vertical, then return [`EQUAL`](@ref) when `p` lies on `s`,
[`SMALLER`](@ref) when `p` lies under `s`, and [`LARGER`](@ref) otherwise.

!!! info "Precondition"

    `p` is withing the x range of `s`.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_y()`](@ref),
[`compare_yx()`](@ref), [`compare_z()`](@ref).
"""
compare_y_at_x(p::Point2, s::Segment2)

"""
    compare_y_at_x(p::Point2, s₁::Segment2, s₂::Segment2)

Compares the ``y``-coordinates of `p` and the vertical projection of `p` on
`s₁` and on `s₂`.

If `s₁` or `s₂` is vertical, then return [`EQUAL`](@ref) if they intersect,
otherwise return [`SMALLER`](@ref) if `s₁` lies below `s₂`, and return
[`LARGER`](@ref) otherwise.

!!! info "Precondition"

    `p` is withing the x range of `s₁` and `s₂`.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_y()`](@ref),
[`compare_yx()`](@ref), [`compare_z()`](@ref).
"""
compare_y_at_x(p::Point2, s₁::Segment2, s₂::Segment2)


"""
    compare_y(p::Point23, q::Point23)

Compares the ``y``-coordinates of `p` and `q`.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_y(p::Point23, q::Point23)

"""
    compare_y(p::Point2, l₁::Line2, l₂::Line2)

Compares the ``y``-coordinates of `p` and the intersection of lines `l₁` and
`l₂`.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_y(p::Point2, l₁::Line2, l₂::Line2)

"""
    compare_y(l::Line2, h₁::Line2, h₂::Line2)

Compares the ``y``-coordinates of the intersection of line `l` with of line `h₁`
and with line `h₂`.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_y(l::Line2, h₁::Line2, h₂::Line2)

"""
    compare_y(l₁::Line2, l₂::Line2, h₁::Line2, h₂::Line2)

Compares the ``y``-coordinates of the intersection of lines `l₁` and `l₂` and
the intersection of lines `h₁` and `h₂`.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_y(l₁::Line2, l₂::Line2, h₁::Line2, h₂::Line2)


"""
    compare_xyz(p::Point3, q::Point3)

Compares the Cartesian coordinates of points `p` and `q` lexicographically in
``xyz`` order: first ``x``-coordinates are compared, if they are equal,
``y``-coordinates are compared, and if both ``x``- and ``y``- coordinates are
equal, ``z``-coordinates are compared.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_x_at_y()`](@ref), [`compare_y()`](@ref), [`compare_yx()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_xyz(p::Point3, q::Point3)


"""
    compare_z(p::Point3, q::Point3)

Compares the ``z``-coordinates of `p` and `q`.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_y()`](@ref),
[`compare_yx()`](@ref), [`compare_y_at_x()`](@ref).
"""
compare_z(p::Point3, q::Point3)


"""
    compare_yx(p::Point2, q::Point2)

Compares the Cartesian coordinates of points `p` and `q` lexicographically in
``yx`` order: first ``y``-coordinates are compared, if they are equal,
``x``-coordinates are compared.

See also: [`compare_x()`](@ref), [`compare_xy()`](@ref),
[`compare_xyz()`](@ref), [`compare_x_at_y()`](@ref), [`compare_y()`](@ref),
[`compare_y_at_x()`](@ref), [`compare_z()`](@ref).
"""
compare_yx(p::Point2, q::Point2)


"""
    coplanar(p::Point3, q::Point3, r::Point3, s::Point3)

Returns `true`, if `p`, `q`, `r`, and `s` are coplanar.
"""
coplanar(p::Point3, q::Point3, r::Point3, s::Point3)


"""
    coplanar_orientation(p::Point3, q::Point3, r::Point3, s::Point3)

Let `P` be the plane defined by the points `p`, `q`, and `r`.

Note that the order defined the orientation of `P`.  The function computes the
orientation of points `p`, `q`, and `s` in `P`: Iff `p`, `q`, `s` are collinear,
[`COLLINEAR`](@ref) is returned.  Iff `P` and the plane defined by `p`, `q`, and
`s` have the same orientation, [`POSITIVE`](@ref) is returned; otherwise
[`NEGATIVE`](@ref) is returned.

!!! info "Precondition"

    `p`, `q`, `r`, and `s` are coplanar and `p`, `q`, and `r` are not collinear.
"""
coplanar_orientation(p::Point3, q::Point3, r::Point3, s::Point3)

"""
    coplanar_orientation(p::Point3, q::Point3, r::Point3)

If `p`, `q`, `r` are collinear, then [`COLLINEAR`](@ref) is returned.

If not, then `p`, `q`, `r` define a plane `P`.  The return value, in this case,
is either [`POSITIVE`](@ref) or [`NEGATIVE`](@ref), but we don't specify it
explicitly.  However, we guarantee that all calls to this predicate over 3 points
in `P` will return a coherent orientation if considered a 2D orientation in `P`.
"""
coplanar_orientation(p::Point3, q::Point3, r::Point3)


"""
    coplanar_side_of_bounded_circle(p::Point3, q::Point3, r::Point3, s::Point3)

Returns the bounded side of the circle defined by `p`, `q`, and `r` on which `s`
lies.


!!! info "Precondition"

    `p`, `q`, `r`, and `s` are coplanar and `p`, `q`, and `r` are not collinear.
"""
coplanar_side_of_bounded_circle(p::Point3, q::Point3, r::Point3, s::Point3)


"""
    cross_product(v::Vector3, u::Vector3)

Returns the cross product of `u` and `v`.
"""
cross_product(v::Vector3, u::Vector3)


"""
    determinant(v::Vector2, w::Vector2)

Returns the determinant of `v` and `w`.
"""
determinant(v::Vector2, w::Vector2)

"""
    determinant(u::Vector3, v::Vector3, w::Vector3)

Returns the determinant of `u`, `v`, and `w`.
"""
determinant(u::Vector3, v::Vector3, w::Vector3)


"""
    do_intersect(obj₁::Type1, obj₂::Type2)

Checks whether `obj₁` and `obj₂` intersect.

Two objects `obj₁` and `obj₂` intersect if there is a Point23 `p` that is
part of both `obj₁` and `obj₂`.  The intersection region of those two objects
is defined as the set of all points `p` that are part of both `obj₁` and
`obj₂`.  Note that for objects like triangles and polygons that enclose a
bounded region, this region is part of the object.

The types `Type1` and `Type2` can be any of the following:

- [`Point2`](@ref)
- [`Line2`](@ref)
- [`Ray2`](@ref)
- [`Segment2`](@ref)
- [`Triangle2`](@ref)
- [`IsoRectangle2`](@ref)

Also, `Type1` and `Type2` can be respectively of types

- [`Circle2`](@ref) and [`CircularArc2`](@ref) (or the contrary)
- [`Circle2`](@ref) and [`Line2`](@ref) (or the contrary)
- [`Circle2`](@ref) and [`Segment2`](@ref) (or the contrary)
- [`CircularArc2`](@ref) and [`Line2`](@ref) (or the contrary)
- [`CircularArc2`](@ref) and [`Segment2`](@ref) (or the contrary)

In three-dimensional space, the types `Type1` and `Type2` can be any of the
following:

- [`Bbox3`](@ref)
- [`IsoCuboid3`](@ref)
- [`Line3`](@ref)
- [`Plane3`](@ref)
- [`Point3`](@ref)
- [`Ray3`](@ref)
- [`Segment3`](@ref)
- [`Sphere3`](@ref)
- [`Tetrahedron3`](@ref)
- [`Triangle3`](@ref)

Also, `Type1` and `Type2` can be both of type

- [`Circle3`](@ref)
- [`CircularArc3`](@ref)

Furthermore, `Type1` and `Type2` can be interchangeably of types

- [`Circle3`](@ref) and [`Line3`](@ref)
- [`Circle3`](@ref) and [`Plane3`](@ref)
- [`Circle3`](@ref) and [`Sphere3`](@ref)
- [`CircularArc3`](@ref) and [`Plane3`](@ref)

See also: [`intersection`](@ref).
"""
do_intersect(obj₁, obj₂)

"""
    do_intersect(obj₁::Type1, obj₂::Type2, obj₃::Type3)

Checks whether `obj₁`, `obj₂`, and `obj₃` intersect.

The types `Type1`, `Type2` and `Type3` can be respectively of types

- [`Sphere3`](@ref), [`Sphere3`](@ref), and [`Plane3`](@ref)
- [`Plane3`](@ref), [`Sphere3`](@ref), and [`Sphere3`](@ref)
- [`Plane3`](@ref), [`Plane3`](@ref), and [`Sphere3`](@ref)
- [`Sphere3`](@ref), [`Plane3`](@ref), and [`Plane3`](@ref)
"""
do_intersect(obj₁, obj₂, obj₃)

"""
    has_larger_distance_to_point(p::Point23, q::Point23, r::Point23)

Returns `true` iff the distance between `q` and `p` is larger than the distance
between `r` and `p`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_larger_distance_to_point(p::Point23, q::Point23, r::Point23)


"""
    has_larger_signed_distance_to_line(l::Line2, p::Point2, q::Point2)

Returns `true` iff the signed distance of `p` and `l` is larger than the signed
distance of `q` and `l`

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_larger_signed_distance_to_line(l::Line2, p::Point2, q::Point2)

"""
    has_larger_signed_distance_to_line(p::Point2, q::Point2, r::Point2, s::Point2)

Returns `true` iff the signed distance of `r` and `l` is larger than the signed
distance of `s` and `l`, where `l` is the directed line through points `p` and
`q`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_larger_signed_distance_to_line(p::Point2, q::Point2, r::Point2, s::Point2)


"""
    has_larger_signed_distance_to_plane(h::Plane3, p::Point3, q::Point3)

Returns `true` iff the signed distance of `p` and `h` is larger than
the signed distance of `q` and `h`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_larger_signed_distance_to_plane(h::Plane3, p::Point3, q::Point3)

"""
    has_larger_signed_distance_to_plane(p::Point3, q::Point3, r::Point3, s::Point3, t::Point3)

Returns `true` iff the signed distance of `s` and `h` is larger than the signed
distance of `t` and `h`, where `h` is the oriented plane through `p`, `q`, and
`r`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_larger_signed_distance_to_plane(p::Point3, q::Point3, r::Point3, s::Point3, t::Point3)


"""
    has_smaller_distance_to_point(p::Point23, q::Point23, r::Point23)

Returns `true` iff the distance between `q` and `p` is smaller than the distance
between `r` and `p`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_smaller_distance_to_point(p::Point23, q::Point23, r::Point23)


"""
    has_smaller_signed_distance_to_line(l::Line2, p::Point2, q::Point2)

Returns `true` iff the signed distance of `p` and `l` is larger than the signed
distance of `q` and `l`

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_smaller_signed_distance_to_line(l::Line2, p::Point2, q::Point2)

"""
    has_smaller_signed_distance_to_line(p::Point2, q::Point2, r::Point2, s::Point2)

Returns `true` iff the signed distance of `r` and `l` is smaller than the signed
distance of `s` and `l`, where `l` is the directed line through points `p` and
`q`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_smaller_signed_distance_to_line(p::Point2, q::Point2, r::Point2, s::Point2)


"""
    has_smaller_signed_distance_to_plane(h::Plane3, p::Point3, q::Point3)

Returns `true` iff the signed distance of `p` and `h` is smaller than
the signed distance of `q` and `h`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_smaller_signed_distance_to_plane(h::Plane3, p::Point3, q::Point3)

"""
    has_smaller_signed_distance_to_plane(p::Point3, q::Point3, r::Point3, s::Point3, t::Point3)

Returns `true` iff the signed distance of `s` and `h` is smaller than the signed
distance of `t` and `h`, where `h` is the oriented plane through `p`, `q`, and
`r`.

See also: [`compare_squared_distance()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
has_smaller_signed_distance_to_plane(p::Point3, q::Point3, r::Point3, s::Point3, t::Point3)


"""
    intersection(obj₁::Type1, obj₂::Type2)

Two objects `obj₁` and `obj₂` intersect if there is a Point23 `p` that is
part of both `obj₁` and `obj₂`.

The intersection region of those two objects is defined as the set of all points
`p` that are part of both `obj₁` and `obj₂`.  Note that for objects like
triangles and polygons that enclose a bounded region, this region is considered
part of the object.  If a segment lies completely inside a triangle, then those
two objects intersect and the intersection region is the complete segment.

The return type is `Union{T...,Nothing}`, the last column in the table providing
the template parameter pack.

The following tables give the possible values for `Type1` and `Type2`.

### 2D Intersections

|          Type1          |          Type2          |                                       Return Type: T...                                      |
|:------------------------|:------------------------|:---------------------------------------------------------------------------------------------|
| [`Circle2`](@ref)       | [`Circle2`](@ref)       | [`Point2`](@ref), [`Vector{Point2}`](@ref), or [`Circle2`](@ref)                             |
| [`Circle2`](@ref)       | [`CircularArc2`](@ref)  | [`Point2`](@ref), [`Vector{Point2}`](@ref), or [`CircularArc2`](@ref)                        |
| [`Circle2`](@ref)       | [`Line2`](@ref)         | [`Point2`](@ref), or [`Vector{Point2}`](@ref)                                                |
| [`Circle2`](@ref)       | [`Segment2`](@ref)      | [`Point2`](@ref), or [`Vector{Point2}`](@ref)                                                |
| [`CircularArc2`](@ref)  | [`CircularArc2`](@ref)  | [`Point2`](@ref), [`Vector{Point2}`](@ref), or [`CircularArc2`](@ref)                        |
| [`CircularArc2`](@ref)  | [`Line2`](@ref)         | [`Point2`](@ref), or [`Vector{Point2}`](@ref)                                                |
| [`CircularArc2`](@ref)  | [`Segment2`](@ref)      | [`Point2`](@ref), or [`Vector{Point2}`](@ref)                                                |
| [`IsoRectangle2`](@ref) | [`IsoRectangle2`](@ref) | [`IsoRectangle2`](@ref)                                                                      |
| [`IsoRectangle2`](@ref) | [`Line2`](@ref)         | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`IsoRectangle2`](@ref) | [`Ray2`](@ref)          | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`IsoRectangle2`](@ref) | [`Segment2`](@ref)      | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`IsoRectangle2`](@ref) | [`Triangle2`](@ref)     | [`Point2`](@ref), or [`Segment2`](@ref), or [`Triangle2`](@ref), or [`Vector{Point2}`](@ref) |
| [`Line2`](@ref)         | [`Line2`](@ref)         | [`Point2`](@ref), or [`Line2`](@ref)                                                         |
| [`Line2`](@ref)         | [`Ray2`](@ref)          | [`Point2`](@ref), or [`Ray2`](@ref)                                                          |
| [`Line2`](@ref)         | [`Segment2`](@ref)      | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`Line2`](@ref)         | [`Triangle2`](@ref)     | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`Ray2`](@ref)          | [`Ray2`](@ref)          | [`Point2`](@ref), or [`Segment2`](@ref), or [`Ray2`](@ref)                                   |
| [`Ray2`](@ref)          | [`Segment2`](@ref)      | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`Ray2`](@ref)          | [`Triangle2`](@ref)     | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`Segment2`](@ref)      | [`Segment2`](@ref)      | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`Segment2`](@ref)      | [`Triangle2`](@ref)     | [`Point2`](@ref), or [`Segment2`](@ref)                                                      |
| [`Triangle2`](@ref)     | [`Triangle2`](@ref)     | [`Point2`](@ref), or [`Segment2`](@ref), or [`Triangle2`](@ref), or [`Vector{Point2}`](@ref) |

**3D Intersections**

|         Type1          |         Type2          |                                      Return Type: T...                                       |
|:-----------------------|:-----------------------|:---------------------------------------------------------------------------------------------|
| [`Circle3`](@ref)      | [`Circle3`](@ref)      | [`Point3`](@ref), [`Circle3`](@ref), or [`Vector{Point3}`](@ref)                             |
| [`Circle3`](@ref)      | [`Line3`](@ref)        | [`Point3`](@ref), [`Vector{Point3}`](@ref)                                                   |
| [`Circle3`](@ref)      | [`Plane3`](@ref)       | [`Point3`](@ref), [`Circle3`](@ref), or [`Vector{Point3}`](@ref)                             |
| [`Circle3`](@ref)      | [`Sphere3`](@ref)      | [`Point3`](@ref), [`Circle3`](@ref), or [`Vector{Point3}`](@ref)                             |
| [`CircularArc3`](@ref) | [`CircularArc3`](@ref) | [`Point3`](@ref), [`Circle3`](@ref), or [`CircularArc3`](@ref), or [`Vector{Point3}`](@ref)  |
| [`CircularArc3`](@ref) | [`Plane3`](@ref)       | [`Point3`](@ref), [`CircularArc3`](@ref), or [`Vector{Point3}`](@ref)                        |
| [`Line3`](@ref)        | [`Line3`](@ref)        | [`Point3`](@ref), or [`Line3`](@ref)                                                         |
| [`Line3`](@ref)        | [`Line3`](@ref)        | [`Point3`](@ref), or [`Line3`](@ref)                                                         |
| [`Line3`](@ref)        | [`Plane3`](@ref)       | [`Point3`](@ref), or [`Line3`](@ref)                                                         |
| [`Line3`](@ref)        | [`Ray3`](@ref)         | [`Point3`](@ref), or [`Ray3`](@ref)                                                          |
| [`Line3`](@ref)        | [`Segment3`](@ref)     | [`Point3`](@ref), or [`Segment3`](@ref)                                                      |
| [`Line3`](@ref)        | [`Triangle3`](@ref)    | [`Point3`](@ref), or [`Segment3`](@ref)                                                      |
| [`Plane3`](@ref)       | [`Plane3`](@ref)       | [`Line3`](@ref), or [`Segment3`](@ref)                                                       |
| [`Plane3`](@ref)       | [`Ray3`](@ref)         | [`Point3`](@ref), or [`Ray3`](@ref)                                                          |
| [`Plane3`](@ref)       | [`Segment3`](@ref)     | [`Point3`](@ref), or [`Segment3`](@ref)                                                      |
| [`Plane3`](@ref)       | [`Sphere3`](@ref)      | [`Point3`](@ref), or [`Circle3`](@ref)                                                       |
| [`Plane3`](@ref)       | [`Triangle3`](@ref)    | [`Point3`](@ref), or [`Segment3`](@ref), or [`Triangle3`](@ref)                              |
| [`Ray3`](@ref)         | [`Ray3`](@ref)         | [`Point3`](@ref), or [`Ray3`](@ref), or [`Segment3`](@ref)                                   |
| [`Ray3`](@ref)         | [`Segment3`](@ref)     | [`Point3`](@ref), or [`Segment3`](@ref)                                                      |
| [`Ray3`](@ref)         | [`Triangle3`](@ref)    | [`Point3`](@ref), or [`Segment3`](@ref)                                                      |
| [`Segment3`](@ref)     | [`Segment3`](@ref)     | [`Point3`](@ref), or [`Segment3`](@ref)                                                      |
| [`Segment3`](@ref)     | [`Triangle3`](@ref)    | [`Point3`](@ref), or [`Segment3`](@ref)                                                      |
| [`Segment3`](@ref)     | [`Sphere3`](@ref)      | [`Point3`](@ref), or [`Circle3`](@ref), or [`Sphere3`](@ref)                                 |
| [`Triangle3`](@ref)    | [`Triangle3`](@ref)    | [`Point3`](@ref), or [`Segment3`](@ref), or [`Triangle3`](@ref), or [`Vector{Point3}`](@ref) |

# Examples

The following examples demonstrate the most common use of
[`intersection()`](@ref) functions.

In the first two examples we intersect a segment and a line.

```julia-repl
julia> seg = Segment2(Point2(0,0), Point2(2,2))
Segment_2(PointC2(0, 0), PointC2(2, 2))

julia> lin = Line2(1,-1,0)
Line_2(0, 0, 0)

julia> result = intersection(seg, lin)
Segment_2(PointC2(0, 0), PointC2(2, 2))
```
"""
intersection(obj₁, obj₂)


"""
    intersection(obj₁::Type1, obj₂::Type2, obj₃::Type3)

Computes the intersection of the three given objects.

The return type is `Union{Circle3,Plane3,Sphere3,Vector{Point3},Nothing}`.

The following table gives the possible types for `Type1`, `Type2`, and `Type3`.

|         Type1          |         Type2          |         Type3          |
|:-----------------------|:-----------------------|:-----------------------|
| [`Sphere3`](@ref)      | [`Sphere3`](@ref)      | [`Sphere3`](@ref)      |
| [`Sphere3`](@ref)      | [`Sphere3`](@ref)      | [`Plane3`](@ref)       |
| [`Plane3`](@ref)       | [`Sphere3`](@ref)      | [`Sphere3`](@ref)      |
| [`Plane3`](@ref)       | [`Plane3`](@ref)       | [`Sphere3`](@ref)      |
| [`Sphere3`](@ref)      | [`Plane3`](@ref)       | [`Plane3`](@ref)       |
"""
intersection(obj₁, obj₂, obj₃)


"""
    l_infinity_distance(p::Point23, q::Point23)

Returns the distance between `p` and `q` in the L-infinity metric.
"""
l_infinity_distance(p::Point23, q::Point23)


"""
    left_turn(p::Point2, q::Point2, r::Point2)

Returns `true` iff `p`, `q`, and `r` form a left turn.

See also: [`collinear()`](@ref), [`orientation()`](@ref), [`right_turn`](@ref).
"""
left_turn(p::Point2, q::Point2, r::Point2)


"""
    lexicographically_xy_larger(p::Point2, q::Point2)

Returns `true` iff `p` is lexicographically larger than `q` with respect to
``xy`` order.

See also: [`compare_xy()`](@ref),
[`lexicographically_xy_larger_or_equal()`](@ref),
[`lexicographically_xy_smaller()`](@ref),
[`lexicographically_xy_smaller_or_equal()`](@ref).
"""
lexicographically_xy_larger(p::Point2, q::Point2)


"""
    lexicographically_xy_larger_or_equal(p::Point2, q::Point2)


Returns `true` iff `p` is lexicographically not smaller than `q` with respect to
``xy`` order.

See also: [`compare_xy()`](@ref),
[`lexicographically_xy_larger()`](@ref),
[`lexicographically_xy_smaller()`](@ref),
[`lexicographically_xy_smaller_or_equal()`](@ref).
"""
lexicographically_xy_larger_or_equal(p::Point2, q::Point2)


"""
    lexicographically_xy_smaller(p::Point2, q::Point2)

Returns `true` iff `p` is lexicographically smaller than `q` with respect to
``xy`` order.

See also: [`compare_xy()`](@ref),
[`lexicographically_xy_larger()`](@ref),
[`lexicographically_xy_larger_or_equal()`](@ref),
[`lexicographically_xy_smaller_or_equal()`](@ref).
"""
lexicographically_xy_smaller(p::Point2, q::Point2)


"""
    lexicographically_xy_smaller_or_equal(p::Point2, q::Point2)


Returns `true` iff `p` is lexicographically not larger than `q` with respect to
``xy`` order.

See also: [`compare_xy()`](@ref),
[`lexicographically_xy_larger()`](@ref),
[`lexicographically_xy_larger_or_equal()`](@ref),
[`lexicographically_xy_smaller()`](@ref).
"""
lexicographically_xy_smaller_or_equal(p::Point2, q::Point2)


"""
    lexicographically_xyz_smaller(p::Point3, q::Point3)

Returns `true` iff `p` is lexicographically smaller than `q` with respect to
``xyz`` order.

See also: [`compare_xyz()`](@ref),
[`lexicographically_xyz_smaller_or_equal()`](@ref).
"""
lexicographically_xyz_smaller(p::Point3, q::Point3)


"""
    lexicographically_xyz_smaller_or_equal(p::Point3, q::Point3)


Returns `true` iff `p` is lexicographically not larger than `q` with respect to
``xyz`` order.

See also: [`compare_xyz()`](@ref),
[`lexicographically_xyz_smaller()`](@ref).
"""
lexicographically_xyz_smaller_or_equal(p::Point3, q::Point3)


"""
    max_vertex(ir::IsoRectangle2)

Computes the vertex with the lexicographically largest coordinates of the iso
rectangle `ir`.
"""
max_vertex(ir::IsoRectangle2)

"""
    max_vertex(ic::IsoCuboid3)

Computes the vertex with the lexicographically largest coordinates of the iso
cuboid `ic`.
"""
max_vertex(ic::IsoCuboid3)


"""
    midpoint(p::Point23, q::Point23)

Computes the midpoint of the segment `pq`.
"""
midpoint(p::Point23, q::Point23)


"""
    min_vertex(ir::IsoRectangle2)

Computes the vertex with the lexicographically smallest coordinates of the iso
rectangle `ir`.
"""
min_vertex(ir::IsoRectangle2)

"""
    min_vertex(ic::IsoCuboid3)

Computes the vertex with the lexicographically smallest coordinates of the iso
cuboid `ic`.
"""
min_vertex(ic::IsoCuboid3)


"""
    normal(p::Point3, q::Point3, r::Point3)

Computes the normal vector for the vectors `q-p` and `r-p`.

!!! info "Precondition"

    The points `p`, `q`, and `r` must not be collinear.
"""
normal(p::Point3, q::Point3, r::Point3)


"""
    orientation(p::Point2, q::Point2, r::Point2)

Returns [`LEFT_TURN`](@ref), if `r` lies to the left of the oriented line `l`
defined by `p` and `q`, returns [`RIGHT_TURN`](@ref) if `r` lies to the right
of `l`, and returns [`COLLINEAR`](@ref) if `r` lies on `l`.

See also: [`collinear()`](@ref), [`left_turn()`](@ref), [`right_turn()`](@ref).
"""
orientation(p::Point2, q::Point2, r::Point2)

"""
    orientation(u::Vector2, v::Vector2, w::Vector2)

Returns [`LEFT_TURN`](@ref), if `u` and `v` form a left turn, returns
[`RIGHT_TURN`](@ref) if `u` and `v` form a right turn, and returns
[`COLLINEAR`](@ref) if `u` and `v` are collinear.

See also: [`collinear()`](@ref), [`left_turn()`](@ref), [`right_turn()`](@ref).
"""
orientation(u::Vector2, v::Vector2, w::Vector2)

"""
    orientation(p::Point3, q::Point3, r::Point3, s::Point3)

Returns [`POSITIVE`](@ref), if `s` lies on the positive side of the oriented
plane `h` defined by `p`, `q`, and `r`, returns [`NEGATIVE`](@ref) if if `s`
lies on the negative side of `h`, and returns [`COPLANAR`](@ref) if `s` lies on
`h`.

See also: [`collinear()`](@ref), [`left_turn()`](@ref), [`right_turn()`](@ref).
"""
orientation(p::Point3, q::Point3, r::Point3, s::Point3)

"""
    orientation(u::Vector3, v::Vector3, w::Vector3)

Returns [`NEGATIVE`](@ref) if `u`, `v` and `w` are negatively oriented,
[`POSITIVE`](@ref) if `u`, `v` and `w` are positively oriented, and
[`COPLANAR`](@ref) if `u`, `v` and `w` are coplanar.

See also: [`collinear()`](@ref), [`left_turn()`](@ref), [`right_turn()`](@ref).
"""
orientation(u::Vector3, v::Vector3, w::Vector3)


"""
    orthogonal_vector(p::Point3, q::Point3, r::Point3)

Computes an orthogonal vector of the plane defined by `p`, `q` and `r`,  which
is directed to the positive side of this plane.
"""
orthogonal_vector(p::Point3, q::Point3, r::Point3)


for (T, t) ∈ ((:Line23, :l)
            , (:Ray23, :r)
            , (:Segment23, :s)
            , (:Plane3, :h))
    t1, t2 = string.(t, ("₁", "₂"))
    args = join(join.(([t1, T], [t2, T]), "::"), ", ")
    @eval begin
        """
            parallel($($args))

        Returns `true`, if `$($t1)` and `$($t2)` are parallel or if one of those
        (or both) is degenerate.
        """
        parallel($t1::$T, $t2::$T)
    end
end


"""
    radical_line(c₁::Circle2, c₂::Circle2)

Returns the radical line of the two circles.

!!! info "Precondition"

    `c₁` and `c₂` are not concentric.
"""
radical_line(c₁::Circle2, c₂::Circle2)


"""
    radical_plane(s₁::Sphere3, s₂::Sphere3)

Returns the radical plane of the two spheres.

!!! info "Precondition"

    `s₁` and `s₂` are not concentric.
"""
radical_plane(s₁::Sphere3, s₂::Sphere3)


"""
    rational_rotation_approximation(dirx::Real, diry::Real
                                   ;num_eps::Real = eps(Float64),
                                    den_eps::Real = 1)

Returns integers `sin_num`, `cos_num` and `denom`, such that `sin_num`/`denom`
approximates the sine of direction `(dirx,diry)`.

The difference between the sine and the approximating rational is bounded by
`num_eps`/`den_eps`.

!!! info "Precondition"

    `num_eps` ``≠ 0``.

**Implementation**

The approximation is based on Farey sequences as described in the rational
rotation method presented by Canny and Ressler at the 8th SoCG 1992. The authors
of the implementation use a slower version which needs no division operation in
the approximation.

See also: [`AffTransformation2`](@ref)
"""
rational_rotation_approximation(dirx::Real, diry::Real
                               ;num_eps::Real=eps(Float64), den_eps::Real=1) =
    iszero(num_eps) ? error("num_eps = 0") :
    let (sin_num, cos_num, denom) = Ref{RT}.((0, 0, 0)),
        res = rational_rotation_approximation(
                  convert(RT, dirx), convert(RT, diry),
                  sin_num, cos_num, denom,
                  convert(RT, num_eps), convert(RT, den_eps))

        sin_num[], cos_num[], denom[]
    end


"""
    right_turn(p::Point2, q::Point2, r::Point2)

Returns `true` iff `p`, `q`, and `r` form a right turn.

See also: [`collinear()`](@ref), [`left_turn()`](@ref), [`orientation()`](@ref).
"""
right_turn(p::Point2, q::Point2, r::Point2)


"""
    scalar_product(u::Vector23, v::Vector23)

Returns the scalar product of `u` and `v`.
"""
scalar_product(u::Vector23, v::Vector23)


"""
    side_of_bounded_circle(p::Point2, q::Point2, r::Point2, t::Point2)

Returns the relative position of point `t` to the circle defined by `p`, `q` and
`r`.

The order of the points `p`, `q`, and `r` does not matter.

!!! info "Precondition"

    `p`, `q`, and `r` are not collinear.

See also: [`coplanar_side_of_bounded_circle()`](@ref),
[`side_of_oriented_circle()`](@ref).
"""
side_of_bounded_circle(p::Point2, q::Point2, r::Point2, t::Point2)

"""
    side_of_bounded_circle(p::Point2, q::Point2, t::Point2)

Returns the position of the point `t` relative to the circle that has `pq` as
its diameter.

See also: [`coplanar_side_of_bounded_circle()`](@ref),
[`side_of_oriented_circle()`](@ref).
"""
side_of_bounded_circle(p::Point2, q::Point2, t::Point2)


"""
    side_of_bounded_sphere(p::Point3, q::Point3, r::Point3, s::Point3, t::Point3)

Returns the relative position of point `t` to the sphere defined by `p`, `q`,
`r`, and `s`.

The order of the points `p`, `q`, `r`, and `s` does not matter.

!!! info "Precondition"

    `p`, `q`, `r` and `s` are not coplanar.

See also: [`side_of_oriented_sphere()`](@ref).
"""
side_of_bounded_sphere(p::Point3, q::Point3, r::Point3, s::Point3, t::Point3)

"""
    side_of_bounded_sphere(p::Point3, q::Point3, r::Point3, t::Point3)

Returns the position of the point `t` relative to the sphere passing through
`p`, `q`, and `r` and whose center is in the plane defined by these three
points.

See also: [`side_of_oriented_sphere()`](@ref).
"""
side_of_bounded_sphere(p::Point3, q::Point3, r::Point3, t::Point3)

"""
    side_of_bounded_sphere(p::Point3, q::Point3, t::Point3)

Returns the position of the point `t` relative to the sphere that has `pq` as
its diameter.

See also: [`side_of_oriented_sphere()`](@ref).
"""
side_of_bounded_sphere(p::Point3, q::Point3, t::Point3)


"""
    side_of_oriented_circle(p::Point2, q::Point2, r::Point2, test::Point2)

Returns the relative position of point `test` to the oriented circle defined by
`p`, `q` and `r`.

The order of the points `p`, `q` and `r` is important, since it determines the
orientation of the implicitly constructed circle.

If `p`, `q` and `r` are collinear, the circle degenerates in a line.
[`ON_ORIENTED_BOUNDARY`](@ref) is returned if `test` is also collinear or if two
points are identical, otherwise, `side_of_oriented_circle(r, q, test, p)` is
returned.

See also: [`side_of_bounded_circle()`](@ref)
"""
side_of_oriented_circle(p::Point2, q::Point2, r::Point2, test::Point2)


"""
    side_of_oriented_sphere(p::Point3, q::Point3, r::Point3, s::Point3, test::Point3)

Returns the relative position of point `test` to the oriented circle defined by
`p`, `q`, `r` and `s`.

The order of the points `p`, `q`, `r` and `s` is important, since it determines
the orientation of the implicitly constructed sphere. If the points `p`, `q`,
`r` and `s` are positively oriented, positive side is the bounded interior of
the sphere.

In case of degeneracies, [`ON_ORIENTED_BOUNDARY`](@ref) is returned if all
points are coplanar. Otherwise, there is a cyclic permutation of the five points
that puts four non coplanar points first, it is used to answer the predicate:
e.g. `side_of_oriented_sphere(q, r, s, test, p)` is returned if `q`, `r`, `s`
and `test` are non coplanar.

See also: [`side_of_bounded_sphere()`](@ref)
"""
side_of_oriented_sphere(p::Point3, q::Point3, r::Point3, s::Point3, test::Point3)


"""
    squared_area(p::Point3, q::Point3, r::Point3)

Returns the squared area of the triangle defined by the points `p`, `q` and `r`.
"""
squared_area(p::Point3, q::Point3, r::Point3)


"""
    squared_distance(obj₁::Type1, obj₂::Type2)

Computes the square of the Euclidean distance between two geometric objects.

For arbitrary geometric objects `obj₁` and `obj₂`, the squared distance is
defined as the minimal `squared_distance(p₁, p₂)`, where `p₁` is a point of
`obj₁` and `p₂` is a point of `obj₂`. Note that for objects that have an inside
(a bounded region), this inside is part of the object. So, the squared distance
from a point inside is zero, not the squared distance to the closest point on
the boundary.

In 2D, the types `Type2` and `Type2` can be any of the following:

- [`Point2`](@ref)
- [`Line2`](@ref)
- [`Ray2`](@ref)
- [`Segment2`](@ref)
- [`Triangle2`](@ref).

In 3D, the types `Type1` and `Type2` can be any of the following:

- [`Point3`](@ref)
- [`Line3`](@ref)
- [`Ray3`](@ref)
- [`Segment3`](@ref)
- [`Plane3`](@ref).

See also: [`compare_distance_to_point()`](@ref),
[`compare_signed_distance_to_line()`](@ref),
[`compare_signed_distance_to_plane()`](@ref),
[`has_larger_distance_to_point()`](@ref),
[`has_larger_signed_distance_to_line()`](@ref),
[`has_larger_signed_distance_to_plane()`](@ref),
[`has_smaller_distance_to_point()`](@ref),
[`has_smaller_signed_distance_to_line()`](@ref),
[`has_smaller_signed_distance_to_plane()`](@ref).
"""
squared_distance(obj₁, obj₂)


"""
    squared_radius(p::Point2, q::Point2, r::Point2)

Compute the squared radius of the circle passing through the points `p`, `q`,
and `r`.

!!! info "Precondition"

    `p`, `q`, and `r` are not collinear.
"""
squared_radius(p::Point2, q::Point2, r::Point2)

"""
    squared_radius(p::Point23, q::Point23)

Compute the squared radius of the smallest circle passing through `p`, and `q`,
i.e. one fourth of the squared distance between `p` and `q`.
"""
squared_radius(p::Point23, q::Point23)

"""
    squared_radius(p::Point23)

Computes the squared radius of the smallest circle passing through `p`, i.e.
``0``.
"""
squared_radius(p::Point23)

"""
    squared_radius(p::Point3, q::Point3, r::Point3, s::Point3)

Computes the squared radius of the sphere passing through the points `p`, `q`,
`r` and `s`.

!!! info "Precondition"

    `p`, `q`, `r`, and `s` are not coplanar.
"""
squared_radius(p::Point3, q::Point3, r::Point3, s::Point3)

"""
    squared_radius(p::Point3, q::Point3, r::Point3)

Computes the squared radius of the sphere passing through the points `p`, `q`,
and `r` and whose center is in the same plane as those three points.
"""
squared_radius(p::Point3, q::Point3, r::Point3)


"""
    unit_normal(p::Point3, q::Point3, r::Point3)

Computes the unit normal vector for the vectors `q-p` and `r-p`.

!!! info "Precondition"

    The points `p`, `q`, and `r` must not be collinear.
"""
unit_normal(p::Point3, q::Point3, r::Point3)


"""
    volume(p₀::Point3, p₁::Point3, p₂::Point3, p₃::Point3)

Computes the signed volume of the tetrahedron defined by the four points `p₀`,
`p₁`, `p₂` and `p₃`.
"""
volume(p₀::Point3, p₁::Point3, p₂::Point3, p₃::Point3)


"""
    x_equal(p::Point23, q::Point23)

Returns `true`, iff `p` and `q` have the same x-coordinate.

See also: [`compare_x()`](@ref), [`y_equal()`](@ref), [`z_equal()`](@ref).
"""
x_equal(p::Point23, q::Point23)


"""
    y_equal(p::Point23, q::Point23)

Returns `true`, iff `p` and `q` have the same y-coordinate.

See also: [`compare_y()`](@ref), [`x_equal()`](@ref), [`z_equal()`](@ref).
"""
y_equal(p::Point23, q::Point23)


"""
    z_equal(p::Point3, q::Point3)

Returns `true`, iff `p` and `q` have the same z-coordinate.

See also: [`compare_z()`](@ref), [`x_equal()`](@ref), [`y_equal()`](@ref).
"""
z_equal(p::Point3, q::Point3)


"""
    +(p::Point23, v::Vector23)

Returns the point obtained by translating `p` by the vector `v`.
"""
+(p::Point23, v::Vector23)


"""
    -(p::Point23, v::Vector23)

Returns the point obtained by translating `p` by the vector -`v`.
"""
-(p::Point23, v::Vector23)


"""
    *(v::Vector23, s::Real)

Multiplication with a scalar from the right.
"""
*(v::Vector23, s::Real)

"""
    *(s::Real, v::Vector23)

Multiplication with a scalar from the left.
"""
*(s::Real, v::Vector23)

for V ∈ (:Vector2, :Vector3)
    @eval begin
        @cxxdereference Base.:*(v::$V, s::Real) = v * convert(RT, s)
        @cxxdereference Base.:*(s::Real, v::$V) = convert(RT, s) * v
    end
end


"""
    do_overlap(bb₁::Bbox23, bb₂::Bbox23)

Returns `true` iff `bb₁` and `bb₂` overlap, i.e., iff their intersection is
non-empty.
"""
do_overlap(bb₁::Bbox23, bb₂::Bbox23)
