for T ∈ (FieldType,
        #RingType,
         AffTransformation2,
         BBox2,
         Circle2,
         Direction2,
         IsoRectangle2,
         Line2,
         Point2,
         Ray2,
         Segment2,
         Triangle2,
         Vector2,
         WeightedPoint2,
        )
    @eval Base.show(io::IO, x::$T) = print(io, repr(x))
end

for T ∈ (:IdentityTransformation,
         :Origin,
         :NullVector,
         :Rotation,
         :Scaling,
         :Translation)
   C = uppercase(replace(string(T), r"([A-Z]+)" => s"_\1"))[2:end]
   @eval Base.show(io::IO, ::$T) = print(io, "$(@__MODULE__).$($C)")
end
