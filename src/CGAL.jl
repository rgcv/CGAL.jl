module CGAL

# We need to import these so they can be overwritten in c++, per se
import Base: ==, <, <=, >=, >, +, -, *, /,
             angle, min, max

using CxxWrap

const depsfile = joinpath(dirname(@__DIR__), "deps", "deps.jl")
if !isfile(depsfile)
    error("$depsfile not present, try rebuilding CGAL.jl")
end
include(depsfile)
@wrapmodule(libcgal_julia)

function __init__()
    @initcxx
    # References to these constants are nullified when the module's loaded
    # despite the constants themselves having been compiled in during
    # pre-compilation. As a workaround, we wrap the value within a function and
    # define the references to the constants inside the `__init__` function on
    # Julia's side of things.
    #
    # see https://github.com/JuliaInterop/libcxxwrap-julia/issues/23#issuecomment-478019042
    global IDENTITY_TRANSFORMATION = IdentityTransformation()
    global NULL_VECTOR = NullVector()
    global ORIGIN = Origin()
    global ROTATION = Rotation()
    global SCALING = Scaling()
    global TRANSLATION = Translation()
end

include("origin.jl")
include("enum.jl")
include("kernel.jl")
include("global_kernel_functions.jl")

include("visual.jl")

end # CGAL
