module CGAL

if VERSION < v"1.3.0-rc4" # pre artifacts
    const depsfile = joinpath(dirname(@__DIR__), "deps", "deps.jl")
    if !isfile(depsfile)
        error("$depsfile not present, try rebuilding CGAL.jl")
    end
    include(depsfile)
else
    using libcgal_julia_jll
end

struct Origin end; const ORIGIN = Origin()
struct NullVector end; const NULL_VECTOR = NullVector()

struct IdentityTransformation end; const IDENTITY = IdentityTransformation()
struct Reflection end; const REFLECTION = Reflection()
struct Rotation end; const ROTATION = Rotation()
struct Scaling end; const SCALING = Scaling()
struct Translation end; const TRANSLATION = Translation()

using CxxWrap

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
