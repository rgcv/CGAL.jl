# CGAL.jl - [CGAL][1] meets [Julia](https://julialang.org)

[![Build Status](https://github.com/rgcv/Euclide.jl/workflows/CI/badge.svg)](https://github.com/rgcv/Euclide.jl/actions)

A package exposing a series of types, constructs, functions, predicates, and
algorithms from [CGAL][1] (Computational Geometry Algorithms Library), a
powerful, reliable, and efficient C++ library

This package is supported by a C++ wrapper around CGAL in the form of
[libcgal-julia][2], itself powered by
[JlCxx](https://github.com/JuliaInterop/libcxxwrap-julia).

## Usage

Since the kernel is being fixed on the C++ side, the usual `typedefs` you see
in CGAL's examples aren't as common.  Here's [one of CGAL's
examples](https://doc.cgal.org/latest/Kernel_23/Kernel_23_2points_and_segment_8cpp-example.html)
in a side-by-side comparison with a Julia translation using this package:

<table>
<tr>
<th>C++</th>
<th>Julia</th>
</tr>
<tr>
<td>

```cpp
// points_and_segment.cpp
#include <iostream>
#include <CGAL/Simple_cartesian.h>

typedef CGAL::Simple_cartesian<double> Kernel;
typedef Kernel::Point_2 Point_2;
typedef Kernel::Segment_2 Segment_2;

int main()
{
  Point_2 p(1,1), q(10,10);

  std::cout << "p = " << p << std::endl;
  std::cout << "q = " << q.x() << " " << q.y() << std::endl;

  std::cout << "sqdist(p,q) = "
            << CGAL::squared_distance(p,q) << std::endl;

  Segment_2 s(p,q);
  Point_2 m(5, 9);

  std::cout << "m = " << m << std::endl;
  std::cout << "sqdist(Segment_2(p,q), m) = "
            << CGAL::squared_distance(s,m) << std::endl;

  std::cout << "p, q, and m ";
  switch (CGAL::orientation(p,q,m)){
  case CGAL::COLLINEAR:
    std::cout << "are collinear\n";
    break;
  case CGAL::LEFT_TURN:
    std::cout << "make a left turn\n";
    break;
  case CGAL::RIGHT_TURN:
    std::cout << "make a right turn\n";
    break;
  }

  std::cout << " midpoint(p,q) = " << CGAL::midpoint(p,q) << std::endl;
  return 0;
}
```

</td>
<td>

```julia
# points_and_segment.jl
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

</td>
</tr>
</table>

## Installation

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

## Using a different kernel

Currently, two different binary libraries are made available in
[libcgal-julia][2]: one compiled with the
`Exact_predicates_inexact_constructions_kernel`, and another one with
`Exact_predicates_exact_constructions_kernel_with_sqrt` (i.e. using `doubles`
=> `Float64`, and `CORE::Expr` => `FieldType`).  By default, this package uses
the inexact variant, trading better performance for minor, even sometimes
negligible, dare I say, inexact results.

There are two different ways of loading a custom library, both of which come
in the form of defining environment variables.  One of the glaring downsides
of this approach is the package must be rebuilt in order to pick up the
change before loading the module due to precompilation.

On the julia side of things, this distinction is made based on the existence
of a `FieldType` type mapped from the C++ side.  Take a look inside
`kernel.jl` to see how this is handled.

### Switching between inexact/exact kernels

In order to use a kernel with exact constructions, one must define the
`JLCGAL_EXACT_CONSTRUCTIONS` environment variable.  The variable's value is
ignored. It only needs to exist. For example,

```sh
$ export JLCGAL_EXACT_CONSTRUCTIONS="I'm willing to pay for some performance penalties"
$ julia
julia> build CGAL
...
julia> using CGAL
...
julia> FT
FieldType # numeric type from CGAL. when using inexact constructions => Float64
```

### Loading a custom wrapper library

The full path to an alternative version of the wrapper library can be specified
by defining the `JLCGAL_LIBPATH` environment variable. This will override the
`JLCGAL_EXACT_CONSTRUCTIONS` definition since the former is more specific than
the latter.

[1]: https://www.cgal.org
[2]: https://github.com/rgcv/libcgal-julia
