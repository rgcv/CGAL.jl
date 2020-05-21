if FieldType === Float64
    Base.show(io::IO, x::Ref{FT}) = show(io, x[])
end

foreach(methods(CGAL.repr)) do r
    @eval Base.show(io::IO, x::$(r.sig.parameters[2])) = print(io, repr(x))
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
