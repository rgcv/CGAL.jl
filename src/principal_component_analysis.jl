export barycenter,
       centroid,
       bounding_box

"""
    barycenter(wps::AbstractVector{WeightedPoint23})
    barycenter(wp₁::WeightedPoint23, wp₂::WeightedPoint23, wps::WeightedPoint23...)
    barycenter(ps::AbstractVector{Point23}, ws::AbstractVector{Real})

Computes the barycenter of a non-empty set of 2D or 3D weighted points.

Returns [`Point2`](@ref) or [`Point3`](@ref) depending on the dimension of the
input values.

!!! info "Precondition"

    `length(ps) > 1`, and the sum of the weights is non-zero.
"""
barycenter(wps::AbstractVector{WeightedPoint23})

barycenter(ps::AbstractVector) =
    length(ps) > 1 ?
        barycenter(CxxRef.(ps)) :
        error("length(ps) ≯ 1")

for D ∈ 2:3
    P = Symbol(:Point, D)
    WP = Symbol(:Weighted, P)
    @eval begin
        @cxxdereference barycenter(wp₁::$WP, wp₂::$WP,
                                   wps::reference_type_union($WP)...) =
            barycenter(CxxRef.([wp₁, wp₂, wps...]))
        @cxxdereference barycenter(p₁::$P, p₂::$P,
                                   ps::reference_type_union($P)...) =
            barycenter(CxxRef.($WP.([p₁, p₂, ps...], 1)))
    end
end

barycenter(ps::AbstractVector, ws::AbstractVector) =
    length(ws) > 1 && length(ps) > 1 ?
        let f = iscxxtype(FT) ? CxxRef : identity
            barycenter(CxxRef.(ps), f.(convert.(FT, ws)))
        end : barycenter(ps)

"""
    bounding_box(ps::AbstractVector{Point23})
    bounding_box(p::Point23, q::Point23, ps::Point23...)

Computes the bounding box of a non-empty set of 2D or 3D points.

Returns [`IsoRectangle2`](@ref) or [`IsoCuboid3`](@ref) depending on the
dimension of the input values.

!!! info "Precondition"

    `length(ps) > 1`
"""
bounding_box(ps::AbstractVector{Point23})

bounding_box(ps::AbstractVector) =
    length(ps) > 1 ?
        bounding_box(collect(CxxRef{_pointfor(ps[1])}, CxxRef.(ps))) :
        error("length(ps) ≯ 1")

for P ∈ (Point2, Point3)
    @eval @cxxdereference bounding_box(p::$P, q::$P,
                                       ps::reference_type_union($P)...) =
        bounding_box(CxxRef.([p, q, ps...]))
end

const _centroid_T = Union{Point23
                        , Segment23
                        , Triangle23
                        , IsoBox23
                        , Tetrahedron3
                        , Circle2
                        , Sphere3}
"""
    centroid(xs::AbstractVector{T})
    centroid(x::T, xs::T...)

Computes the centroid of a non-empty set of 2D or 3D objects.

Returns [`Point2`](@ref) or [`Point3`](@ref) dependencing on the dimension of
the input objects.

For two dimensional inputs, `T` must be either [`Point2`](@ref),
[`Segment2`](@ref), [`Triangle2`](@ref), [`IsoRectangle2`](@ref), or
[`Circle2`](@ref).

For three dimensional inputs, `T` must be either [`Point3`](@ref),
[`Segment3`](@ref), [`Triangle3`](@ref), [`IsoCuboid3`](@ref),
[`Sphere3`](@ref), or [`Tetrahedron3`](@ref).

!!! info "Precondition"

    `!isempty(xs)`
"""
centroid(xs::AbstractVector{_centroid_T})

centroid(xs::AbstractVector) =
    !isempty(xs) ?
        centroid(CxxRef.(xs)) :
        error("isempty(xs)")

for T ∈ (:Segment2, :Segment3
       , :IsoRectangle2, :IsoCuboid3
       , :Circle2, :Sphere3)
    @eval @cxxdereference centroid(x::$T,
                                   xs::reference_type_union($T)...) =
        centroid(CxxRef.([x, xs...]))
end
for T ∈ (:Triangle2, :Triangle3, :Tetrahedron3)
    @eval @cxxdereference centroid(x::$T, y::$T,
                                   xs::reference_type_union($T)...) =
        centroid(CxxRef.([x, y, xs...]))
end
for P ∈ (:Point2, :Point3)
    @eval @cxxdereference centroid(a::$P, b::$P, c::$P, d::$P, e::$P,
                                   xs::reference_type_union($P)...) =
        centroid(CxxRef.([a, b, c, d, e, xs...]))
end