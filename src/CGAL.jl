module CGAL

struct Origin end; const ORIGIN = Origin()
struct NullVector end; const NULL_VECTOR = NullVector()

struct IdentityTransformation end; const IDENTITY = IdentityTransformation()
struct Reflection end; const REFLECTION = Reflection()
struct Rotation end; const ROTATION = Rotation()
struct Scaling end; const SCALING = Scaling()
struct Translation end; const TRANSLATION = Translation()

using CxxWrap
using libcgal_julia_jll

# N.B.: Currently, to use another library, the package must be reubilt before
# being used. This is yet one of the disadvantages of not mapping the various
# kernels
# By default, use inexact constructions. The user can choose to use exact
# constructions by defining the JLCGAL_EXACT_CONSTRUCTIONS environment variable
const libcgal_julia = haskey(ENV, "JLCGAL_EXACT_CONSTRUCTIONS") ?
                      libcgal_julia_exact :
                      libcgal_julia_inexact

# Indicate full path to an alternative wrapper lib using the JLCGAL_LIBPATH
# environment variable to override provided the provided lib artifact. Since it
# is more specific, it overrides the existence/absence of the
# JLCGAL_EXACT_CONSTRUCTIONS variable
@wrapmodule(get(ENV, "JLCGAL_LIBPATH", libcgal_julia))

__init__() = @initcxx

include("origin.jl")
include("enum.jl")
include("kernel.jl")
include("algebra.jl")
include("global_kernel_functions.jl")
include("voronoi_delaunay.jl")

include("visual.jl")

end # CGAL
