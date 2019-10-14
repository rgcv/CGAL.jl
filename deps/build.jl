using BinaryProvider # requires BinaryProvider 0.5.0 or later
using CxxWrap

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))

const gh = "https://github.com"
const dependencies = [
    "$gh/benlorenz/boostBuilder/releases/download/v1.69.0-1/build_boost.v1.69.0.jl",
    "$gh/JuliaPackaging/Yggdrasil/releases/download/GMP-v6.1.2-1/build_GMP.v6.1.2.jl",
    "$gh/JuliaPackaging/Yggdrasil/releases/download/MPFR-v4.0.2-1/build_MPFR.v4.0.2.jl",
    "$gh/rgcv/CGALBuilder/releases/download/v4.14.1-1/build_CGAL.v4.14.1.jl",
    "$gh/rgcv/libcgal-julia/releases/download/v0.1.2/build_libcgal-julia.v0.1.2.jl"
]

products = Product[]
for dependency in dependencies
    file = joinpath(@__DIR__, basename(dependency))

    # BinaryProvider's `download` supports proxies.
    # See: https://github.com/JuliaWeb/LibCURL.jl/issues/69
    isfile(file) || BinaryProvider.download(dependency, file)

    # Build dependencies
    # N.B.: It is a bit faster to run builds in an anonymous module instead of
    # starting a new julia process
    m = Module()
    append!(products, Core.eval(m, :(Base.include($m, $file); products)))
end

# Write out a deps.jl file that will contain mappings for our products
write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)
