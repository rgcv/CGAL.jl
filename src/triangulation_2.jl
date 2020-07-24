export Triangulation2,
       ConstrainedTriangulation2,
       ConstrainedDelaunayTriangulation2,
       DelaunayTriangulation2,
       RegularTriangulation2

export all_edges,
       all_faces,
       all_vertices,
       constrained_edges,
       degree,
       dimension,
       dual,
       edges,
       faces,
       finite_vertices,
       hidden_vertices,
       inexact_locate,
       insert_constraint,
       is_valid,
       line_walk,
       locate,
       mirror_edge,
       nearest_power_vertex,
       nearest_vertex,
       neighbor,
       number_of_faces,
       number_of_vertices,
       points,
       segment,
       swap,
       vertex,
       vertices

_triangulation_point(::Type) = Point2
_triangulation_point(::Type{<:reference_type_union(RegularTriangulation2)}) = WeightedPoint2

for T ∈ (:Triangulation2
       , :DelaunayTriangulation2
       , :RegularTriangulation2)
    @eval begin
        local P = _triangulation_point($T)
        $T(ps::AbstractVector) = $T(collect(CxxRef{P}, CxxRef.(ps)))
        $T(ps::reference_type_union(P)...) = $T(collect(CxxRef.(ps)))
    end
end

RegularTriangulation2(ps::reference_type_union(Point2)...) =
    RegularTriangulation2(collect(WeightedPoint2.(ps, 1)))

# DelaunayTriangulation2's are subtypes of respective Triangulation2's
for T ∈ (Triangulation2
       , ConstrainedTriangulation2
       , RegularTriangulation2)
    @eval begin
        local P = _triangulation_point($T)
        @cxxdereference Base.insert!(t::$T, ps::AbstractVector) =
            insert!(t, collect(CxxRef{P}, CxxRef.(ps)))
        @cxxdereference is_valid(dt::$T,
                                 verbose::Bool = false,
                                 level::Integer = 0) =
            is_valid(dt, verbose, level)
    end
end

@cxxdereference insert_constraint(t::ConstrainedTriangulation2,
                                  ps::AbstractVector) =
    insert_constraint(t, collect(CxxRef{Point2}, CxxRef.(ps)))

@cxxdereference Base.push!(t::RegularTriangulation2, p::Point2) =
    push!(t, WeightedPoint2(p, 1))
