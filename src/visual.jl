for (name, T) ∈ ((:ft, FieldType         ),
                #(:rt, RingType          ),
                 (:at, AffTransformation2),
                 (:bb, BBox2             ),
                 (:c,  Circle2           ),
                 (:d,  Direction2        ),
                 (:ir, IsoRectangle2     ),
                 (:l,  Line2             ),
                 (:p,  Point2            ),
                 (:r,  Ray2              ),
                 (:s,  Segment2          ),
                 (:t,  Triangle2         ),
                 (:v,  Vector2           ),
                 (:wp, WeightedPoint2    ))
   @eval Base.show(io::IO, $name::$T) = print(io, repr($name))
end

for C ∈ ((IDENTITY_TRANSFORMATION,
          ORIGIN,
          NULL_VECTOR,
          ROTATION,
          SCALING,
          TRANSLATION))
   @eval Base.show(io::IO, ::$T) = print(io, "$(@__MODULE__).$($C)")
end
