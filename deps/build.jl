using BinaryProvider # requires BinaryProvider 0.5.0 or later
using CxxWrap

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))

const vBoost = v"1.71"
const vGMP = v"6.1.2"
const vMPFR = v"4.0.2"
const vCGAL = v"5"
const vCGALjl = v"0.4"

const gh = "https://github.com"
const dependencies = [
    "$gh/benlorenz/boostBuilder/releases/download/v$vBoost-1/build_boost.v$vBoost.jl",
    "$gh/JuliaPackaging/Yggdrasil/releases/download/GMP-v$vGMP-1/build_GMP.v$vGMP.jl",
    "$gh/JuliaPackaging/Yggdrasil/releases/download/MPFR-v$vMPFR-1/build_MPFR.v$vMPFR.jl",
    "$gh/rgcv/CGALBuilder/releases/download/v$vCGAL-2/build_CGAL.v$vCGAL.jl",
    "$gh/rgcv/libcgal-julia/releases/download/v$vCGALjl/build_libcgal-julia.v$vCGALjl.jl"
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
