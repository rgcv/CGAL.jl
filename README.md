# CGAL.jl - [CGAL][1] meets [Julia](https://julialang.org)

:warning: **DISCLAIMER** :warning: As it stands, this package is terribly
experimental. See [libcgal-julia][2] for more information.

---

A package exposing a series of types, constructs, functions, and predicates from
[CGAL][1] (Computational Geometry Algorithms Library), a powerful, reliable, and
efficient C++ library

This package is supported by a C++ wrapper around CGAL in the form of
[libcgal-julia][2], itself powered by
[JlCxx](https://github.com/JuliaInterop/libcxxwrap-julia).

# Usage

Since the kernel is being fixed on the C++ side, the usual `typedefs` you see in
CGAL's examples aren't as common. Here's [one of CGAL's
examples](https://doc.cgal.org/latest/Kernel_23/Kernel_23_2points_and_segment_8cpp-example.html)
translated to Julia using this package:

```julia
# points_and_segments.jl
using CGAL

p, q = Point2(1, 1), Point2(10, 10)

println("p = $p")
println("q = $(x(q)) $(y(q))")

println("sqdist(p,q) = $(squared_distance(p, q))")

s = Segment2(p, q)
m = Point2(5, 9)

println("m = $m")
println("sqdist(Segment2(p,q), m) = $(squared_distance(s, m))")

print("p, q, and m ")
let o = orientation(p, q, m)
    if     o == COLLINEAR  println("are collinear")
    elseif o == LEFT_TURN  println("make a left turn")
    elseif o == RIGHT_TURN println("make a right turn")
    end
end

println(" midpoint(p,q) = $(midpoint(p, q))")
```

# Installation

Until it some day makes its way to the official Julia package registry, you can
add it directly from this repo right here! Drop into a REPL and type de
following:

```julia
julia> import Pkg; Pkg.add("https://github.com/rgcv/CGAL.jl")
```

Alternatively, in a blank REPL, after hitting `]`,

```julia
pkg> add https://github.com/rgcv/CGAL.jl
```

[1]: https://www.cgal.org
[2]: https://github.com/rgcv/libcgal-julia
