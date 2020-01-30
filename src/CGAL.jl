module CGAL

struct Origin end; const ORIGIN = Origin()
struct NullVector end; const NULL_VECTOR = NullVector()

struct IdentityTransformation end; const IDENTITY = IdentityTransformation()
struct Reflection end; const REFLECTION = Reflection()
struct Rotation end; const ROTATION = Rotation()
struct Scaling end; const SCALING = Scaling()
struct Translation end; const TRANSLATION = Translation()

using CxxWrap

const depsfile = joinpath(dirname(@__DIR__), "deps", "deps.jl")
if !isfile(depsfile)
    error("$depsfile not present, try rebuilding CGAL.jl")
end
include(depsfile)
@wrapmodule(libcgal_julia)

__init__() = @initcxx

include("origin.jl")
include("enum.jl")
include("kernel.jl")
include("algebra.jl")
include("global_kernel_functions.jl")

include("visual.jl")

end # CGAL
