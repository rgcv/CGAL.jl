export VoronoiDiagram2

export bounded_faces,
       bounded_halfedges,
       ccb,
       ccb_halfedges,
       degree,
       down,
       dual,
       face,
       faces,
       finite_edges,
       halfedge,
       halfedges,
       has_source,
       has_target,
       incident_halfedges,
       incident_halfedges,
       is_bisector,
       is_halfedge_on_ccb,
       is_incident_edge,
       is_incident_face,
       is_ray,
       is_segment,
       is_unbounded,
       is_valid,
       is_valid,
       left,
       locate,
       next,
       number_of_connected_components,
       number_of_faces,
       number_of_halfedges,
       number_of_vertices,
       opposite,
       previous,
       right,
       site,
       sites,
       source,
       swap,
       target,
       twin,
       unbounded_faces,
       unbounded_halfedges,
       up,
       vertices

VoronoiDiagram2{T}(ps::AbstractVector) where T =
    VoronoiDiagram2(collect(CxxRef{_triangulation_point(T)}, CxxRef.(ps)))
VoronoiDiagram2{T}(ps...) where T = VoronoiDiagram2(collect(ps))

@cxxdereference Base.insert!(vd::VoronoiDiagram2, ps::AbstractVector) =
    insert!(vd, collect(CxxRef{_triangulation_point(typeof(vd).parameters[1])},
                        CxxRef.(ps)))
@cxxdereference finite_edges(vd::VoronoiDiagram2) =
    let dg = dual(vd)
        dual.([dg], edges(dg))
    end
