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
    @eval Base.show(io::IO, x::CxxWrap.CxxBaseRef{$T}) = show(io, x[])
end

for (T, N) ∈ ((IdentityTransformation, :IDENTITY),
              (Origin,                 :ORIGIN),
              (NullVector,             :NULL_VECTOR),
              (Rotation,               :ROTATION),
              (Scaling,                :SCALING),
              (Translation,            :TRANSLATION),
             )
    @eval Base.show(io::IO, ::$T) = print(io, $(string(N)))
end
