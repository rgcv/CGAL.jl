if !iscxxtype(FT)
    Base.show(io::IO, x::CxxBaseRef{FT}) = show(io, x[])
end

foreach(methods(CGAL._tostring)) do r
    @eval Base.show(io::IO, x::$(r.sig.parameters[2])) = print(io, _tostring(x))
end
