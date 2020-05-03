import CxxWrap: CxxRef

export VoronoiDiagram,
       DelaunayTriangulation

export all_edges,
       degree,
       dual,
       edges,
       finite_edges,
       halfedge,
       has_source,
       has_target,
       incident_halfedges,
       is_bisector,
       is_halfedge_on_ccb,
       is_incident_edge,
       is_incident_face,
       is_unbounded,
       is_ray,
       is_segment,
       is_valid,
       locate,
       next,
       number_of_faces,
       number_of_halfedges,
       number_of_vertices,
       point,
       points,
       previous,
       segment,
       sites,
       source,
       target,
       triangle,
       vertices

@cxxdereference Base.insert!(dt::DelaunayTriangulation, ps::Vector{<:Point2}) = insert!(dt, CxxRef.(ps))
@cxxdereference Base.insert!(vd::VoronoiDiagram, ps::Vector{<:Point2}) = insert!(vd, CxxRef.(ps))
# verbose is a boolean. weirdly, CxxWrap maps it to an Integer
@cxxdereference is_valid(dt::DelaunayTriangulation, verbose::Integer = false, level::Integer = 0) =
    is_valid(dt, verbose, level)
