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
       # TODO: more 3D + other circular intersections
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
       parallel,
       radical_line,
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

const Pt  = Union{Point2,Point3}
const Vec = Union{Vector2,Vector3}

# =====================================
# = angle
# =====================================

"""
    angle(u::Vector2, v::Vector2)
    angle(u::Vector3, v::Vector3)

Returns [`OBTUSE`](@ref), [`RIGHT`](@ref) or [`ACUTE`](@ref) depending on the
angle formed by the two vectors `u` and `v`.
"""
angle(u::Vec, v::Vec)

"""
    angle(p::Point2, q::Point2, r::Point2)
    angle(p::Point3, q::Point3, r::Point3)

Returns [`OBTUSE`](@ref), [`RIGHT`](@ref) or [`ACUTE`](@ref) depending on the
angle formed by the three points `p`, `q`, `r` (`q` being the vertex of the
angle).

The returned value is the same as `angle(p - q, r - q)`.
"""
angle(p::Pt, q::Pt, r::Pt)

"""
    angle(p::Point2, q::Point2, r::Point2, s::Point2)
    angle(p::Point3, q::Point3, r::Point3, s::Point3)

Returns [`OBTUSE`](@ref), [`RIGHT`](@ref) or [`ACUTE`](@ref) depending on the
angle formed by the two vectors `pq`, `rs`.

The returned value is the same as `angle(q - p, s - r)`.
"""
angle(p::Pt, q::Pt, r::Pt, s::Pt)

"""
    angle(p::Point3, q::Point3, r::Point3, v::Vector3)

Returns [`OBTUSE`](@ref), [`RIGHT`](@ref) or [`ACUTE`](@ref) depending on the
angle formed by the normal of the triangle `pqr` and the vector `v`.
"""
angle(p::Point3, q::Point3, r::Point3, v::Vector3)


# =====================================
# = approximate_angle
# =====================================

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


# =====================================
# = approximate_dihedral_angle
# =====================================

"""
    approximate_dihedral_angle(p::Point3, q::Point3, r::Point3, s::Point3)

Returns an approximation of the signed dihedral angle in the tetrahedron `pqrs`
of edge `pq`.

The sign is negative if `orientation(p,q,r,s)` is `NEGATIVE` and positive
otherwise. The angle is given in degrees.

!!! info "Precondition"
    `p`,`q`,`r` and `p`,`q`,`s` are not collinear.
"""
approximate_dihedral_angle(p::Point3, q::Point3, r::Point3, s::Point3)


# =====================================
# = area
# =====================================

"""
    area(p::Point2, q::Point2, r::Point2)

Returns the signed area of the triangle defined by the points `p`, `q` and `r`.
"""
area(p::Point2, q::Point2, r::Point2)


# =====================================
# = are_ordered_along_line
# =====================================

"""
    are_ordered_along_line(p::Point2, q::Point2, r::Point2)
    are_ordered_along_line(p::Point3, q::Point3, r::Point3)

Returns `true`, iff the three points are collinear and `q` lies between `p` and
`r`.

Note that `true` is returned, if `q==p` or `q==r`.
"""
are_ordered_along_line(p::Pt, q::Pt, r::Pt)


# =====================================
# = are_strictly_ordered_along_line
# =====================================

"""
    are_strictly_ordered_along_line(p::Point2, q::Point2, r::Point2)
    are_strictly_ordered_along_line(p::Point3, q::Point3, r::Point3)

Returns `true`, iff the three points are collinear and `q` lies strictly between
`p` and `r`.

Note that `false` is returned, if `q==p` or `q==r`.
"""
are_strictly_ordered_along_line(p::Pt, q::Pt, r::Pt)


# =====================================
# = barycenter
# =====================================

"""
    barycenter(p1::Point2, w1::FT, p2::Point2)
    barycenter(p1::Point2, w1::Real, p2::Point2)
    barycenter(p1::Point3, w1::FT, p2::Point3)
    barycenter(p1::Point3, w1::Real, p2::Point3)

Compute the barycenter of the points `p1` and `p2` with corresponding weights
`w1` and `1-w1`.
"""
barycenter(p1::Pt, w1, p2::Pt)

"""
    barycenter(p1::Point2, w1::FT, p2::Point2, w2::FT)
    barycenter(p1::Point2, w1::Real, p2::Point2, w2::Real)
    barycenter(p1::Point3, w1::FT, p2::Point3, w2::FT)
    barycenter(p1::Point3, w1::Real, p2::Point3, w2::Real)

Compute the barycenter of the points `p1` and `p2` with corresponding weights
`w1` and `w2`.
"""
barycenter(p1::Pt, w1, p2::Pt, w2)

"""
    barycenter(p1::Point2, w1::FT, p2::Point2, w2::FT, p3::Point2)
    barycenter(p1::Point2, w1::Real, p2::Point2, w2::Real, p3::Point2)
    barycenter(p1::Point3, w1::FT, p2::Point3, w2::FT, p3::Point3)
    barycenter(p1::Point3, w1::Real, p2::Point3, w2::Real, p3::Point3)

Compute the barycenter of the points `p1`,`p2` and `p3` with corresponding weights
`w1,w2` and `1-w1-w2`.
"""
barycenter(p1::Pt, w1, p2::Pt, w2, p3::Pt)

"""
    barycenter(p1::Point2, w1::FT, p2::Point2, w2::FT, p3::Point2, w3::FT)
    barycenter(p1::Point2, w1::Real, p2::Point2, w2::Real, p3::Point2, w3::Real)
    barycenter(p1::Point3, w1::FT, p2::Point3, w2::FT, p3::Point3, w3::FT)
    barycenter(p1::Point3, w1::Real, p2::Point3, w2::Real, p3::Point3, w3::Real)

Compute the barycenter of the points `p1`,`p2` and `p3` with corresponding weights
`w1,w2` and `w3`.
"""
barycenter(p1::Pt, w1, p2::Pt, w2, p3::Pt, w3)

"""
    barycenter(p1::Point2, w1::FT, p2::Point2, w2::FT, p3::Point2, w3::FT, p4::Point2)
    barycenter(p1::Point2, w1::Real, p2::Point2, w2::Real, p3::Point2, w3::Real, p4::Point2)
    barycenter(p1::Point3, w1::FT, p2::Point3, w2::FT, p3::Point3, w3::FT, p4::Point3)
    barycenter(p1::Point3, w1::Real, p2::Point3, w2::Real, p3::Point3, w3::Real, p4::Point3)

Compute the barycenter of the points `p1`,`p2`, `p3` and `p4` with corresponding
weights `w1,w2,w3` and `1-w1-w2-w3`.
"""
barycenter(p1::Pt, w1, p2::Pt, w2, p3::Pt, w3, p4::Pt)

"""
    barycenter(p1::Point2, w1::FT, p2::Point2, w2::FT, p3::Point2, w3::FT, p4::Point2, w4::FT)
    barycenter(p1::Point2, w1::Real, p2::Point2, w2::Real, p3::Point2, w3::Real, p4::Point2, w4::Real)
    barycenter(p1::Point3, w1::FT, p2::Point3, w2::FT, p3::Point3, w3::FT, p4::Point3, w4::FT)
    barycenter(p1::Point3, w1::Real, p2::Point3, w2::Real, p3::Point3, w3::Real, p4::Point3, w4::Real)

Compute the barycenter of the points `p1`,`p2`, `p3` and `p4` with corresponding
weights `w1,w2,w3` and `w4`.
"""
barycenter(p1::Pt, w1, p2::Pt, w2, p3::Pt, w3, p4::Pt, w4)

for P ∈ (Point2, Point3)
    @eval begin
        @cxxdereference barycenter(p1::$P, w1::Real, p2::$P) =
            barycenter(p1, convert(FT, w1), p2)
        @cxxdereference barycenter(p1::$P, w1::Real, p2::$P, w2::Real) =
            barycenter(p1, convert(FT, w1), p2, convert(FT, w2))
        @cxxdereference barycenter(p1::$P, w1::Real, p2::$P, w2::Real, p3::$P) =
            barycenter(p1, convert(FT, w1), p2, convert(FT, w2), p3)
        @cxxdereference barycenter(p1::$P, w1::Real, p2::$P, w2::Real, p3::$P, w3::Real) =
            barycenter(p1, convert(FT, w1), p2, convert(FT, w2), p3, convert(FT, w3))
        @cxxdereference barycenter(p1::$P, w1::Real, p2::$P, w2::Real, p3::$P, w3::Real, p4::$P) =
            barycenter(p1, convert(FT, w1), p2, convert(FT, w2), p3, convert(FT, w3), p4)
        @cxxdereference barycenter(p1::$P, w1::Real, p2::$P, w2::Real, p3::$P, w3::Real, p4::$P, w4::Real) =
            barycenter(p1, convert(FT, w1), p2, convert(FT, w2), p3, convert(FT, w3), p4, convert(FT, w4))
    end
end


# =====================================
# = bisector
# =====================================

"""
    bisector(p::Point2, q::Point2)

Constructs the bisector line of two points `p` and `q`.

The bisector is oriented in such a way that `p` lies on its positive side.

!!! info "Precondition"

    `p` and `q` are not equal.
"""
bisector(p::Point2, q::Point2)

"""
    bisector(l1::Line2, l2::Line2)

Constructs the bisector of the two lines `l1` and `l2`.

In the general case, the bisector has the direction of the vector which is the
sum of the normalized directions of the two lines, and which passes through the
intersection of `l1` and `l2`. If `l1` and `l2` are parallel, then the bisector
is defined as the line which has the same direction as `l1`, and which is at the
same distance from `l1` and `l2`. This function requires that [`RT`](@ref)
supports the [`sqrt()`](@ref) operation.
"""
bisector(l1::Line2, l2::Line2)

"""
    bisector(p::Point3, q::Point3)

Constructs the bisector plane of the two points `p` and `q`.

The bisector is oriented in such a way that `p` lies on its positive side.

!!! info "Precondition"

    `p` and `q` are not equal.
"""
bisector(p::Point3, q::Point3)

"""
    bisector(h1::Plane3, h2::Plane3)

Constructs the bisector of the two planes `h1` and `h2`.

In the general case, the bisector has a normal vector which has the same
direction as the sum of the normalized normal vectors of the two planes, and
passes through the intersection of `h1` and `h2`. If `h1` and `h2` are parallel,
then the bisector is defined as the plane which has the same oriented normal
vector as `l1`, and which is at the same distance from `h1` and `h2`. This
function requires that [`RT`](@ref) supports the [`sqrt()`](@ref) operation.
"""
bisector(h1::Plane3, h2::Plane3)
