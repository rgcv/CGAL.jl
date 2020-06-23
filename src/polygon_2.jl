export Polygon2,
       PolygonWithHoles2

export area,
       bbox,
       bottom_vertex,
       bounded_side,
       edges,
       has_on_boundary,
       has_on_bounded_side,
       has_on_negative_side,
       has_on_positive_side,
       has_on_unbounded_side,
       holes,
       is_clockwise_oriented,
       is_collinear_oriented,
       is_convex,
       is_counterclockwise_oriented,
       is_simple,
       left_vertex,
       orientation,
       oriented_side,
       outer_boundary,
       right_vertex,
       top_vertex,
       transform,
       vertices

"""
    Polygon2

The type [`Polygon2`](@ref) represents polygons.
"""
Polygon2

"""
    Polygon2()

Creates an empty polygon.
"""
Polygon2()

"""
    Polygon2(polygon::Polygon2)

Copy constructor.
"""
Polygon2(polygon::Polygon2)

"""
    Polygon2(ps::Vector{Point2})

Creates a polygon with vertices from the sequence defined by the vector `ps`.
"""
Polygon2(ps::Vector{<:Point2}) = Polygon2(CxxRef.(ps))

Polygon2(ps::Vector) = isempty(ps) ? Polygon2() : Polygon2(CxxRef.(ps))
@cxxdereference Polygon2(p::Point2, ps...) = Polygon2([p, ps...])

"""
    ==(p₁::Polygon2, p₂::Polygon2)

Test for equality: two polygons are equal iff there exists a cyclic permutation
of the vertices of `p₂` such that they are equal to the vertices of `p₁`.
"""
==(p₁::Polygon2, p₂::Polygon2)

"""
    transform(t::AffTransformation2, p::Polygon2)

Returns the image of the polygon `p` under the transformation `t`.
"""
transform(t::AffTransformation2, p::Polygon2)

"""
    push!(p::Polygon2, q::Point2)

Inserts the vertex `q` at the end of polygon `p`.
"""
push!(p::Polygon2, x::Point2)

"""
    empty!(p::Polygon2)

Erases the polygon `p`'s vertices.
"""
empty!(p::Polygon2)

"""
    reverse(p::Polygon2)

Reverses the orientation of the polygon.

The first vertex remains the same.
"""
reverse(p::Polygon2)

"""
    reverse!(p::Polygon2)

In-place version of [`reverse!`](@ref).
"""
reverse!(p::Polygon2)

"""
    vertices(p::Polygon2)

Returns the polygon's vertices.
"""
vertices(p::Polygon2)

"""
    edges(p::Polygon2)

Returns the polygon's edges.
"""
edges(p::Polygon2)

"""
    is_simple(p::Polygon2)

Returns whether `p` is a simple polygon.
"""
is_simple(p::Polygon2)

"""
    is_convex(p::Polygon2)

Returns whether `p` is convex.
"""
is_convex(p::Polygon2)

"""
    orientation(p::Polygon2)

Returns the orientation.

If the number of vertices `size(p) < 3` then [`COLLINEAR`](@ref) is returned.

!!! info "Precondition"

    `is_simple(p)`
"""
orientation(p::Polygon2)

"""
    oriented_side(p::Polygon2, q::Point2)

Returns [`ON_POSITIVE_SIDE`](@ref), [`ON_NEGATIVE_SIDE`](@ref), or
[`ON_ORIENTED_BOUNDARY`](@ref), depending on where point `q` is.

!!! info "Precondition"

    `is_simple(p)`
"""
oriented_side(p::Polygon2, q::Point2)

"""
    bounded_side(p::Polygon2, q::Point2)

Returns [`ON_BOUNDED_SIDE`](@ref), [`ON_BOUNDARY`](@ref), or
[`ON_UNBOUNDED_SIDE`](@ref), depending on where point `q` is.

!!! info "Precondition"

    `is_simple(p)`
"""
bounded_side(p::Polygon2, q::Point2)

"""
    bbox(p::Polygon2)

Returns the smallest bounding box containing this polygon.
"""
bbox(p::Polygon2)

"""
    area(p::Polygon2)

Returns the signed area of the polygon.

This means that the area is positive for counter clockwise polygons and negative
for clockwise polygons.
"""
area(p::Polygon2)

"""
    left_vertex(p::Polygon2)

Returns the leftmost vertex of the polygon with the smallest x-coordinate.
"""
left_vertex(p::Polygon2)

"""
    right_vertex(p::Polygon2)

Returns the rightmost vertex of the polygon with the largest x-coordinate.
"""
right_vertex(p::Polygon2)

"""
    top_vertex(p::Polygon2)

Returns the topmost vertex of the polygon with the largest y-coordinate.
"""
top_vertex(p::Polygon2)

"""
    bottom_vertex(p::Polygon2)

Returns the bottommost vertex of the polygon with the smallest y-coordinate.
"""
bottom_vertex(p::Polygon2)

for name ∈ (:counterclockwise, :clockwise, :collinear)
    fname = Symbol("is_$(name)_oriented")
    NAME = uppercase(string(name))
    @eval begin
        """
            $($fname)(p::Polygon2)

        Returns `orientation(p) == $($NAME)`.
        """
        $fname(p::Polygon2)
    end
end

for (name, es) ∈ zip((:oriented, :bounded),
                     ((:positive_side, :negative_side)
                    , (:boundary, :bounded_side, :unbounded_side)))
    fdel = "$(name)_side"
    for e ∈ es
        CNAME = uppercase("on_$e")
        fname = Symbol("has_on_$e")
        @eval begin
            """
                $($fname)(p::Polygon2, q::Point2)

            Returns `$($fdel)(p, q) == $($CNAME)`.
            """
            $fname(p::Polygon2, q::Point2)
        end
    end
end

"""
    size(p::Polygon2)

Returns the number of vertices of the polygon.
"""
size(p::Polygon2)

"""
    isempty(p::Polygon2)

Returns `size(p) == 0`.
"""
isempty(p::Polygon2)

"""
resize!(p::Polygon2, sz::Integer)

Resizes the polygon.
"""
resize!(p::Polygon2, sz)

"""
    PolygonWithHoles2

The type [`PolygonWithHoles2`](@ref) represents a linear polygon with holes.
"""
PolygonWithHoles2

"""
    PolygonWithHoles2(pgn_boundary::Polygon2)

Constructor from a polygon.
"""
PolygonWithHoles2(pgn_boundary::Polygon2)

"""
    PolygonWithHoles2(pgn_boundary::Polygon2, ps::Vector{Polygon2})
    PolygonWithHoles2(pgn_boundary::Polygon2, ps::Polygon2...)

Constructor from a polygon (outer boundary) and hole polygons.
"""
PolygonWithHoles2(pgn_boundary::Polygon2, ps::Vector{<:Polygon2})

@cxxdereference PolygonWithHoles2(p::Polygon2, ps::Vector) =
    isempty(ps) ?
        PolygonWithHoles2(p) :
        PolygonWithHoles2(p, CxxRef.(ps))
@cxxdereference PolygonWithHoles2(p::Polygon2, ps::Vector{<:Polygon2}) =
    PolygonWithHoles2(p, CxxRef.(ps))
@cxxdereference PolygonWithHoles2(p::Polygon2, hole::Polygon2, ps...) =
    PolygonWithHoles2(p, [hole, ps...])

"""
    is_unbounded(p::PolygonWithHoles2)

Returns `true` if the outer boundary is empty, `false` otherwise.
"""
is_unbounded(p::PolygonWithHoles2)

"""
    outer_boundary(p::PolygonWithHoles2)

Returns the polygon that represents the outer boundary.

Note that this polygon is not necessarily a valid (simple) general polygon
because it may be relatively simple.
"""
outer_boundary(p::PolygonWithHoles2)

"""
    holes(p::PolygonWithHoles2)

Returns the polygon `p`'s hole polygons.
"""
holes(p::PolygonWithHoles2)
