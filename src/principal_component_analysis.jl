export barycenter,
       centroid,
       bounding_box

"""
    barycenter(ps::Vector{<:WeightedPoint23})
    barycenter(ps::Vector{<:Point23}, ws::Vector{<:FT})
    barycenter(ps::Vector{<:Point23}, ws::Vector{<:Real})

Computes the barycenter of a non-empty set of 2D or 3D weighted points.

Returns [`Point2`](@ref) or [`Point3`](@ref) depending on the dimension of the
input values.

!!! info "Precondition"

    `length(ps) > 1`, and the sum of the weights is non-zero.
"""
barycenter(ps::Vector{<:WeightedPoint23})

barycenter(wps::Vector{<:WeightedPoint23}) = barycenter(CxxRef.(wps))

barycenter(ps::Vector{<:Point23}, ws::Vector{<:FT}) =
    barycenter(CxxRef.(ps), (iscxxtype(FT) ? CxxRef : identity).(ws))
barycenter(ps::Vector{<:Point23}, ws::Vector{<:Real}) =
    barycenter(ps, convert.(FT, ws))
bounding_box(ps::Vector{<:Point23}) = bounding_box(CxxRef.(ps))

"""
    bounding_box(ps::Vector{<:Point23})

Computes the bounding box of a non-empty set of 2D or 3D points.

Returns [`IsoRectangle2`](@ref) or [`IsoCuboid3`](@ref) depending on the
dimension of the input values.

!!! info "Precondition"

    `length(ps) > 1`
"""
bounding_box(ps::Vector{<:Point23})

"""
    centroid(xs::Vector{T})

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
centroid(o::Vector{<:Union{Point23,Segment23,Triangle23,IsoBox23,Tetrahedron3,Circle2,Sphere3}})

for T ∈ (Point23
       , Segment23
       , Triangle23
       , IsoBox23
       , Circle2, Sphere3
       , Tetrahedron3
      )
    @eval centroid(ts::Vector{<:$T}) = centroid(CxxRef.(ts))
end
