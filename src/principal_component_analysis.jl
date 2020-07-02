export barycenter,
       centroid,
       bounding_box

"""
    barycenter(wps::Vector{<:WeightedPoint23})
    barycenter(wp₁::WeightedPoint23, wp₂::WeightedPoint23, wps::WeightedPoint23...)
    barycenter(ps::Vector{<:Point23}, ws::Vector{<:FT})
    barycenter(ps::Vector{<:Point23}, ws::Vector{<:Real})
    barycenter(p₁::Point23, p₂::Point23, ps::Point23...)

Computes the barycenter of a non-empty set of 2D or 3D weighted points.

Returns [`Point2`](@ref) or [`Point3`](@ref) depending on the dimension of the
input values.

!!! info "Precondition"

    `length(ps) > 1`, and the sum of the weights is non-zero.
"""
barycenter(wps::Vector{WeightedPoint23})

barycenter(ps::Vector) =
    length(ps) > 1 ?
        barycenter(CxxRef.(ps)) :
        error("length(ps) ≯ 1")

for D ∈ 2:3
    P = Symbol(:Point, D)
    WP = Symbol(:WeightedPoint, D)
    @eval begin
        @cxxdereference barycenter(wp₁::$WP, wp₂::$WP,
                                   wps::reference_type_union($WP)...) =
            barycenter([wp₁, wp₂, wps...])
        @cxxdereference barycenter(p₁::$P, p₂::$P,
                                   ps::reference_type_union($P)...) =
            barycenter($WP.([p₁, p₂, ps...], 1))
    end
end

barycenter(ps::Vector, ws::Vector{<:Real}) =
    length(ws) > 1 && length(ps) > 1 ?
        let f = iscxxtype(FT) ? CxxRef : identity
            barycenter(CxxRef.(ps), f.(convert.(FT, ws)))
        end : barycenter(ps)

"""
    bounding_box(ps::Vector{<:Point23})
    bounding_box(p::Point23, q::Point23, ps::Point23...)

Computes the bounding box of a non-empty set of 2D or 3D points.

Returns [`IsoRectangle2`](@ref) or [`IsoCuboid3`](@ref) depending on the
dimension of the input values.

!!! info "Precondition"

    `length(ps) > 1`
"""
bounding_box(ps::Vector{Point23})

bounding_box(ps::Vector) = length(ps) > 1 ?
    bounding_box(CxxRef.(ps)) :
    error("length(ps) ≯ 1")

for P ∈ (Point2, Point3)
    @eval begin
        local UP = reference_type_union($P)
        bounding_box(ps::Vector{<:UP}) = bounding_box(CxxRef.(ps))
        @cxxdereference bounding_box(p::$P, q::$P, ps::UP...) =
            bounding_box([p, q, ps...])
     end
end

const _centroid_T = Union{Point23
                        , Segment23
                        , Triangle23
                        , IsoBox23
                        , Tetrahedron3
                        , Circle2
                        , Sphere3}
"""
    centroid(xs::Vector{T})
    centroid(x::T, y::T, xs::T...)

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

    `length(xs) > 1`
"""
centroid(xs::Vector{_centroid_T})

centroid(xs::Vector) =
    length(xs) > 1 ?
        centroid(CxxRef.(xs)) :
        error("length(xs) ≯ 1")
for T ∈ (Point2, Point3
       , Segment2, Segment3
       , Triangle2, Triangle3
       , IsoRectangle2, IsoCuboid3
       , Circle2, Sphere3
       , Tetrahedron3)
    @eval @cxxdereference centroid(x::$T, y::$T,
                                   xs::reference_type_union($T)...) =
        centroid([x, y, xs...])
end
