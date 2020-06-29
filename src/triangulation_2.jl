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
_triangulation_point(::Type{RegularTriangulation2}) = WeightedPoint2

for T ∈ (Triangulation2,
         DelaunayTriangulation2,
         RegularTriangulation2)
    F = nameof(T)
    @eval begin
        local P = _triangulation_point($T)
        $F(ps::Vector) = isempty(ps) ? $F() : $F(CxxRef.(ps))
        $F(ps::reference_type_union(P)...) = $F(collect(ps))
    end
end

RegularTriangulation2(ps::reference_type_union(Point2)...) =
    RegularTriangulation2(collect(WeightedPoint2.(ps, 1)))

# DelaunayTriangulation2's are subtypes of respective Triangulation2's
for T ∈ (Triangulation2,
         ConstrainedTriangulation2,
         RegularTriangulation2)
    @eval begin
        local P = _triangulation_point($T)
        @cxxdereference Base.insert!(t::$T, ps::Vector) =
            isempty(ps) ? t : insert!(t, CxxRef.(ps))
        @cxxdereference is_valid(dt::$T,
                                 verbose::Bool = false,
                                 level::Integer = 0) =
            is_valid(dt, verbose, level)
    end
end

@cxxdereference insert_constraint(t::ConstrainedTriangulation2, ps::Vector) =
    isempty(ps) ? nothing : insert_constraint(t, CxxRef.(ps))

@cxxdereference Base.insert!(t::RegularTriangulation2, ps::Vector) =
    isempty(ps) ? t : insert!(t, CxxRef.(ps))
@cxxdereference Base.push!(t::RegularTriangulation2, p::Point2) =
    push!(t, WeightedPoint2(p, 1))
