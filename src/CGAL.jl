module CGAL

include("mappings.jl") # early jl/c++ mappings

using CxxWrap
import CxxWrap.CxxWrapCore: CxxBaseRef
using libcgal_julia_jll
libcgal_julia() = haskey(ENV, "JLCGAL_EXACT_CONSTRUCTIONS") ?
                      libcgal_julia_exact :
                      libcgal_julia_inexact
@wrapmodule(get(ENV, "JLCGAL_LIBPATH", libcgal_julia()))

__init__() = @initcxx

include("origin.jl")
include("enum.jl")
include("kernel.jl")
include("algebra.jl")
include("global_kernel_functions.jl")
include("triangulation_2.jl")
include("voronoi_delaunay.jl")

include("visual.jl")

end # module CGAL
