export StraightSkeleton2,
       # Access Functions
       defining_contour_edge,
       degree,
       face,
       faces,
       halfedge,
       halfedges,
       id,
       next,
       opposite,
       point,
       prev,
       primary_bisector,
       size_of_faces,
       size_of_halfedges,
       size_of_vertices,
       slope,
       time,
       vertex,
       vertices,
       # Predicates
       has_infinite_time,
       has_null_segment,
       is_bisector,
       is_border,
       is_contour,
       is_inner_bisector,
       is_skeleton,
       is_split,
       is_valid,
       # Functions
       create_exterior_straight_skeleton_2,
       create_interior_straight_skeleton_2,
       create_offset_polygons_2

create_interior_straight_skeleton_2(ps::AbstractVector) =
    create_interior_straight_skeleton_2(collect(CxxRef{Point2}, CxxRef.(ps)))
@cxxdereference create_interior_straight_skeleton_2(p::Point2,
                                                    q::Point2,
                                                    r::Point2, ps...) =
    create_exterior_straight_skeleton_2([p, q, r, ps...])

create_interior_straight_skeleton_2(contour::AbstractVector,
                                    holes::AbstractVector) =
    create_interior_straight_skeleton_2(collect(CxxRef{Point2}, CxxRef.(contour)),
                                        collect(CxxRef{Polygon2}, CxxRef.(holes)))

@cxxdereference create_exterior_straight_skeleton_2(max_offset::Real,
                                                    poly::Polygon2) =
    create_exterior_straight_skeleton_2(convert(FT, max_offset), poly)
create_exterior_straight_skeleton_2(max_offset::Real, ps::AbstractVector) =
    create_exterior_straight_skeleton_2(convert(FT, max_offset),
                                        collect(CxxRef{Point2}, CxxRef.(ps)))
@cxxdereference create_exterior_straight_skeleton_2(max_offset::Real,
                                                    p::Point2,
                                                    q::Point2,
                                                    r::Point2, ps...) =
    create_exterior_straight_skeleton_2(max_offset, [p, q, r, ps...])

@cxxdereference create_offset_polygons_2(offset::Real, ss::StraightSkeleton2) =
    create_offset_polygons_2(convert(FT, offset), ss)
