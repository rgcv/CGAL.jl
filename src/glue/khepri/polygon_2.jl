convert(::Type{Polygon2},
        poly::Union{ClosedLine,Line,Polygon,SurfacePolygon,
                    Khepri.ClosedPolygonalPath}) =
    Polygon2(convert.(Point2, poly.vertices))
convert(::Type{Polygon2}, sp::SurfacePath) = convert(Polygon2, sp.path)
@cxxdereference convert(::Type{Path}, poly::Polygon2) =
    closed_polygonal_path(convert.(Loc, vertices(poly)))
@cxxdereference convert(::Type{ClosedLine}, poly::Polygon2) =
    closed_line(path_vertices(convert(Path, poly)))
@cxxdereference convert(::Type{Line}, poly::Polygon2) =
    line(path_vertices(convert(Path, poly)))
@cxxdereference convert(::Type{Polygon}, poly::Polygon2) =
    polygon(path_vertices(convert(Path, poly)))
@cxxdereference convert(::Type{Surface}, poly::Polygon2) =
    surface(convert(Polygon, poly))
@cxxdereference convert(::Type{SurfacePolygon}, poly::Polygon2) =
    surface_polygon(path_vertices(convert(Path, poly)))
@cxxdereference convert(::Type{SurfacePath}, poly::Polygon2) =
    surface_path(convert(Path, poly))

convert(::Type{PolygonWithHoles2},
        v::AbstractVector{<:Union{ClosedLine,Line,Polygon,
                                  Khepri.ClosedPolygonalPath}}) =
    length(v) > 1 ?
        PolygonWithHoles2(convert(Polygon2, first(v)),
                          convert.(Polygon2, v[2:end])) :
        PolygonWithHoles2(convert(Polygon2, first(v)))

@cxxdereference convert(P::Type{<:Union{ClosedLine,Line,Path,Polygon}},
                        poly::PolygonWithHoles2) =
    convert(P, outer_boundary(poly))
@cxxdereference convert(::Type{Surface}, poly::PolygonWithHoles2) =
    subtraction(convert(Surface, outer_boundary(poly)),
                convert.(Surface, holes(poly)))
