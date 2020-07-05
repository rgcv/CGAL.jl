for T ∈ (:AffTransformation
       , :Bbox
       , :Circle
       , :Direction
       , :IsoRectangle2, :IsoCuboid3
       , :Line
       , :Plane3
       , :Point
       , :Ray
       , :Segment
       , :Sphere3
       , :Tetrahedron3
       , :Triangle
       , :Vector
       , :WeightedPoint), D ∈ (2, 3)
    AT = any(endswith.(string(T), string.((2,3)))) ? T : Symbol(T, D)
    P = reference_type_union(eval(AT))
    @eval _pointfor(::Type{<:$P}) = $(Symbol(:Point, D))
end

# points
convert(::Type{Point2}, p::Loc) =
    let q = in_world(p)
        Point2(cx(q), cy(q))
    end
convert(::Type{Point3}, p::Loc) =
    let q = in_world(p)
        Point3(cx(q), cy(q), cz(q))
    end

convert(::Type{Loc}, ::Origin) = u0(world_cs)
@cxxdereference convert(::Type{Loc}, p::Point2) =
    xy(float(x(p)), float(y(p)), world_cs)
@cxxdereference convert(::Type{Loc}, p::Point3) =
    xyz(float(x(p)), float(y(p)), float(z(p)), world_cs)
for WP ∈ (WeightedPoint2, WeightedPoint3)
    # lossy conversion
    @eval @cxxdereference convert(::Type{Loc}, wp::$WP) =
        convert(Loc, point(wp))
end

for P ∈ (Point2, Point3
       , WeightedPoint2, WeightedPoint3)
    @eval begin
        convert(::Type{$P}, p::Point) = convert($P, p.position)
        @cxxdereference convert(::Type{Point}, p::$P) =
            Khepri.point(convert(Loc, p))
    end
end

# directions/vectors
convert(T::Type{<:Union{Direction2,Vector2}}, u::Vec) =
    let v = in_world(u)
        T(cx(v), cy(v))
    end
convert(T::Type{<:Union{Direction3,Vector3}}, u::Vec) =
    let v = in_world(u)
        T(cx(v), cy(v), cz(v))
    end

convert(::Type{Vec}, ::NullVector) = vxy(0, 0, world_cs)
@cxxdereference convert(::Type{Vec}, u::Vector2) =
    vxy(float(x(u)), float(y(u)), world_cs)
@cxxdereference convert(::Type{Vec}, u::Vector3) =
    vxyz(float(x(u)), float(y(u)), float(z(u)), world_cs)
for D ∈ (Direction2, Direction3)
    @eval @cxxdereference convert(::Type{Vec}, d::$D) =
        convert(Vec, vector(d))
end

# circles
convert(::Type{Circle2}, c::Union{Circle,SurfaceCircle,Khepri.CircularPath}) =
    Circle2(convert(Point2, c.center), c.radius^2)
convert(::Type{Circle3}, c::Union{Circle,SurfaceCircle,Khepri.CircularPath}) =
    Circle3(convert(Point3, c.center), c.radius^2,
            convert(Vector3, vz(1, c.center.cs)))

@cxxdereference convert(::Type{Path}, c::Circle2) =
    circular_path(convert(Loc, center(c)), float(√squared_radius(c)))
@cxxdereference convert(::Type{Path}, c::Circle3) =
    let cₒ = convert(Loc, center(c)),
        n = convert(Vec, orthogonal_vector(supporting_plane(c)))
        circular_path(loc_from_o_vz(cₒ, n), float(√squared_radius(c)))
    end
for C ∈ (Circle2, Circle3)
    @eval begin
        @cxxdereference convert(::Type{Circle}, c::$C) =
            let cp = convert(Path, c)
                circle(cp.center, cp.radius)
            end
        @cxxdereference convert(::Type{Surface}, c::$C) =
            surface(convert(Circle, c))
        @cxxdereference convert(::Type{SurfacePath}, c::$C) =
            surface_path(convert(Path, c))
        @cxxdereference convert(::Type{SurfaceCircle}, c::$C) =
            let cp = convert(Path, c)
                surface_circle(cp.center, cp.radius)
            end
    end
end

# spheres
convert(::Type{Sphere3}, s::Sphere) =
    Sphere3(convert(Point3, s.center), s.radius^2)
@cxxdereference convert(::Type{Sphere}, s::Sphere3) =
    sphere(convert(Loc, center(s)), float(√squared_radius(s)))

# lines/rays/segments
for T ∈ (Line2, Line3
       , Ray2, Ray3
       , Segment2, Segment3)
    P = _pointfor(T)
    @eval convert(::Type{$T}, l::Union{Line,Khepri.PolygonalPath}) =
        $T(convert.($P, l.vertices[1:2])...)
end

for L ∈ (Line2, Line3)
    @eval @cxxdereference convert(::Type{Path}, l::$L) =
        polygonal_path(convert.(Loc, point.([l], [0, 1])))
end
for R ∈ (Ray2, Ray3)
    @eval @cxxdereference convert(::Type{Path}, r::$R) =
        let s = source(r)
            polygonal_path(convert.(Loc, [s, s + to_vector(r)]))
        end
end
for S ∈ (Segment2, Segment3)
    @eval @cxxdereference convert(::Type{Path}, s::$S) =
        polygonal_path(convert.(Loc, [source(s), target(s)]))
end

for T ∈ (Line2, Line3
       , Ray2, Ray3
       , Segment2, Segment3)
    @eval @cxxdereference convert(::Type{Line}, t::$T) =
        let p = convert(Path, t)
            line(p.vertices)
        end
end

# bbox2/rectangle
convert( ::Type{IsoRectangle2},
        r::Union{Rectangle,SurfaceRectangle,Khepri.RectangularPath}) =
    let p = convert(Point2, r.corner),
        q = convert(Point2, p + Vector2(r.dx, r.dy))

        IsoRectangle2(p, q)
    end
convert( ::Type{Bbox2},
        r::Union{Rectangle,SurfaceRectangle,Khepri.RectangularPath}) =
    bbox(convert(IsoRectangle2, r))

@cxxdereference convert(::Type{Path}, ir::IsoRectangle2) =
    let bl = min(ir),
        Δtr = convert(Vec, max(ir) - bl)
        rectangular_path(convert(Loc, bl), Δtr.x, Δtr.y)
    end
@cxxdereference convert(::Type{Rectangle}, ir::IsoRectangle2) =
    let rp = convert(Path, ir)
        rectangle(rp.corner, rp.dx, rp.dy)
    end
@cxxdereference convert(::Type{Surface}, ir::IsoRectangle2) =
    surface(convert(Rectangle, ir))
@cxxdereference convert(::Type{SurfacePath}, ir::IsoRectangle2) =
    surface_path(convert(Path, ir))
@cxxdereference convert(::Type{SurfaceRectangle}, ir::IsoRectangle2) =
    let rp = convert(Path, ir)
        surface_rectangle(rp.corner, rp.dx, rp.dy)
    end
@cxxdereference convert(T::Type{<:Union{Path,Rectangle,SurfacePath,
                                        SurfaceRectangle}}, b::Bbox2) =
    convert(T, IsoRectangle2(b))

# bbox3/box/cuboid
convert(::Type{Bbox3}, c::Union{Box,Cuboid}) = bbox(convert(IsoCuboid3, c))
convert(::Type{IsoCuboid3}, c::Cuboid) =
    bounding_box(convert.(Point3, [c.b0, c.b1, c.b2, c.b3,
                                   c.t0, c.t1, c.t2, c.t3]))
convert(::Type{IsoCuboid3}, b::Box) =
    let p = convert(Point3, b.c),
        q = convert(Point3, p + vxyz(b.dx, b.dy, b.dz))
        IsoCuboid3(p, q)
    end
@cxxdereference convert(T::Type{<:Union{Box,Cuboid}}, b::Bbox3) =
    convert(T, IsoCuboid3(b))
@cxxdereference convert(::Type{Box}, ic::IsoCuboid3) =
    box(convert(Loc, min(ic)), convert(Loc, max(ic)))
@cxxdereference convert(::Type{Cuboid}, ic::IsoCuboid3) =
    cuboid(convert.(Loc, vertex.(ic, 0:7))...)

# triangles
convert(T::Type{<:Union{Triangle2,Triangle3}},
        p::Union{Polygon,SurfacePolygon,SurfaceRegularPolygon,
                 Khepri.ClosedPolygonalPath}) =
    T(convert.(_pointfor(T), p.vertices[1:3])...)
convert(T::Type{<:Union{Triangle2,Triangle3}}, sp::SurfacePath) =
    convert(T, sp.path)
for T ∈ (Triangle2, Triangle3)
    @eval begin
        @cxxdereference convert(::Type{Path}, t::$T) =
            closed_polygonal_path(convert.(Loc, vertex.([t], 0:2)))
        @cxxdereference convert(::Type{Polygon}, t::$T) =
            polygon(path_vertices(convert(Path, t)))
        @cxxdereference convert(::Type{Surface}, t::$T) =
            surface(convert(Polygon, t))
        @cxxdereference convert(::Type{SurfacePath}, t::$T) =
            surface_path(convert(Path, t))
        @cxxdereference convert(::Type{SurfacePolygon}, t::$T) =
            surface_polygon(path_vertices(convert(Path, t)))
    end
end

# tetrahedron
convert( ::Type{Tetrahedron3},
        p::Union{Polygon,SurfacePolygon,Khepri.ClosedPolygonalPath}) =
    Tetrahedron3(convert.(Point3, p.vertices[1:4])...)
convert(::Type{Tetrahedron3}, sp::SurfacePath) =
    convert(Tetrahedron3, sp.path)
@cxxdereference convert(::Type{Path}, t::Tetrahedron3) =
    closed_polygonal_path(convert.(Loc, vertex.([t], 0:3)))
@cxxdereference convert(::Type{Polygon}, t::Tetrahedron3) =
    polygon(path_vertices(convert(Path, t)))
@cxxdereference convert(::Type{Surface}, t::Tetrahedron3) =
    surface(convert(Polygon, t))
@cxxdereference convert(::Type{SurfacePath}, t::Tetrahedron3) =
    surface_path(convert(Path, t))
@cxxdereference convert(::Type{SurfacePolygon}, t::Tetrahedron3) =
    surface_polygon(path_vertices(convert(Path, t)))
