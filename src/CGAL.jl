module CGAL
__precompile__(false)

include("mappings.jl") # early jl/c++ mappings

using CxxWrap
using libcgal_julia_jll
libcgal_julia() = haskey(ENV, "JLCGAL_EXACT_CONSTRUCTIONS") ?
                      libcgal_julia_exact :
                      libcgal_julia_inexact
@wrapmodule(get(ENV, "JLCGAL_LIBPATH", libcgal_julia()))

__init__() = @initcxx

import CxxWrap.CxxWrapCore: CxxBaseRef, IsCxxType, cpp_trait_type

iscxxtype(T::Type) = _iscxxtype(cpp_trait_type(T))
_iscxxtype(::Type) = false
_iscxxtype(::Type{IsCxxType}) = true

include("origin.jl")
include("enum.jl")
include("kernel.jl")
include("algebra.jl")
include("global_kernel_functions.jl")
include("principal_component_analysis.jl")
include("polygon_2.jl")
include("triangulation_2.jl")
include("voronoi_delaunay.jl")

include("visual.jl")

end # module CGAL
