for T ∈ (FieldType,
        #RingType,
         AffTransformation2,
         Bbox2, Bbox3,
         Circle2, Circle3,
         Direction2, Direction3,
         IsoRectangle2, IsoCuboid3,
         Line2, Line3,
         Plane3,
         Point2, Point3,
         Ray2, Ray3,
         Segment2, Segment3,
         Sphere3,
         Tetrahedron3,
         Triangle2, Triangle3,
         Vector2, Vector3,
         WeightedPoint2, WeightedPoint3
        )
    if T === FieldType === Float64
        Base.show(io::IO, x::Ref{FT}) = show(io, x[])
        continue
    end
    @eval @cxxdereference Base.show(io::IO, x::$T) = print(io, repr(x))
end

# HACK: see https://github.com/CGAL/cgal/issues/4698
@cxxdereference Base.show(io::IO, t::AffTransformation3) =
    let ((m00, m01, m02, m03),
         (m10, m11, m12, m13),
         (m20, m21, m22, m23)) = map(i->map(j->m(t, i, j), 0:3), 0:3)

        println(io, "Aff_transformationC3($m00 $m01 $m02 $m03" )
        println(io, "                     $m10 $m11 $m12 $m13" )
        println(io, "                     $m20 $m21 $m22 $m23)")
    end
