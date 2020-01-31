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

# useful for development: indicate full path to wrapper lib using the
# JLCGAL_LIBPATH environment variable before loading the module
@wrapmodule(get(ENV, "JLCGAL_LIBPATH", libcgal_julia))

__init__() = @initcxx

include("origin.jl")
include("enum.jl")
include("kernel.jl")
include("algebra.jl")
include("global_kernel_functions.jl")

include("visual.jl")

end # CGAL
