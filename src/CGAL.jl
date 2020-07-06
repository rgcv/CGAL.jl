module CGAL

using CxxWrap
using libcgal_julia_jll
using Requires

import CxxWrap.CxxWrapCore:
    CxxBaseRef, IsCxxType, cpp_trait_type, reference_type_union

function __init__()
   @initcxx
   @require(Khepri="c487d830-b105-11e8-2c9d-150ba7e503f8",
            include("glue/khepri.jl"))
end

libcgal_julia() = haskey(ENV, "JLCGAL_EXACT_CONSTRUCTIONS") ?
                      libcgal_julia_exact :
                      libcgal_julia_inexact

iscxxtype(T::Type) = _iscxxtype(Base.invokelatest(cpp_trait_type, T))
_iscxxtype(::Type) = false
_iscxxtype(::Type{IsCxxType}) = true

macro singleton(name::Symbol, cname::Union{Symbol,Nothing}=nothing)
    if isnothing(cname)
        cname = Symbol(uppercase(replace(string(name), r"(?<!)(?=[A-Z])" => "_")))
    end

    quote
        struct $name end
        const $cname = $name()
        export $cname
    end |> esc
end

# Origin constants
@singleton Origin
@singleton NullVector

# Transformation tags
@singleton IdentityTransformation IDENTITY
@singleton Reflection
@singleton Rotation
@singleton Scaling
@singleton Translation

@wrapmodule(get(ENV, "JLCGAL_LIBPATH", libcgal_julia()))

include("origin.jl")
include("enum.jl")
include("kernel.jl")
include("algebra.jl")
include("global_kernel_functions.jl")
include("convex_hull_2.jl")
include("principal_component_analysis.jl")
include("polygon_2.jl")
include("triangulation_2.jl")
include("voronoi_delaunay.jl")

include("visual.jl")

end # module CGAL
