export # Convex Hull Functions
       ch_akl_toussaint,
       ch_bykat,
       ch_eddy,
       ch_graham_andrew,
       ch_jarvis,
       ch_melkman,
       convex_hull_2,
       # Convexity Checking
       is_ccw_strongly_convex_2,
       is_cw_strongly_convex_2,
       # Hull Subsequence Functions
       ch_graham_andrew_scan,
       ch_jarvis_march,
       lower_hull_points_2,
       upper_hull_points_2,
       # Extreme Point Functions
       ch_e_point,
       ch_n_point,
       ch_ns_point,
       ch_nswe_point,
       ch_s_point,
       ch_we_point,
       ch_w_point

@doc raw"""
    ch_akl_toussaint(ps::AbstractVector{Point2})
    ch_akl_toussaint(ps::Point2...)

Returns the counterclockwise sequence of extreme points of points in the vector
`ps`.

It is not specified at which point the cyclic sequence of extreme points is cut
into a linear sequence.

!!! info "Precondition"

    The vector `ps` does not contain the result.

### Implementation

This function uses the algorithm of Akl and Toussaint [^sga78] that requires
``O(n \log n)`` time for ``n`` input points.

[^sga78]: S. G. Akl and G. T. Toussaint. A fast convex hull algorithm. *Inform.
          Process. Lett.*, 7(5):219--222, 1978.

See also: [`ch_bykat()`](@ref), [`ch_eddy()`](@ref),
[`ch_graham_andrew()`](@ref), [`ch_jarvis()`](@ref), [`ch_melkman()`](@ref),
[`convex_hull_2()`](@ref)
"""
ch_akl_toussaint(ps::AbstractVector{Point2})

@doc raw"""
    ch_bykat(ps::AbstractVector{Point2})
    ch_bykat(ps::Point2...)

Returns the counterclockwise sequence of extreme points of points in the vector
`ps`.

It is not specified at which point the cyclic sequence of extreme points is cut
into a linear sequence.

!!! info "Precondition"

    The vector `ps` does not contain the result.

### Implementation

This function implements the non-recursive variation of Eddy's algorithm (see
[`ch_eddy()`](@ref)) described in [^kra78]. This algorithm requires ``O(nh)``
time in the worst case for ``n`` input points with ``h`` extreme points.

[^kra78]: K. R. Anderson. A reevaluation of an efficient algorithm for determining
          the convex hull of a finite planar set. *Inform. Process. Lett.*,
          7(1):53--55, 1978.

See also: [`ch_akl_toussaint()`](@ref), [`ch_eddy()`](@ref),
[`ch_graham_andrew()`](@ref), [`ch_jarvis()`](@ref), [`ch_melkman()`](@ref),
[`convex_hull_2()`](@ref)
"""
ch_bykat(ps::AbstractVector{Point2})

@doc raw"""
    ch_eddy(ps::AbstractVector{Point2})
    ch_eddy(ps::Point2...)

Returns the counterclockwise sequence of extreme points of points in the vector
`ps`.

It is not specified at which point the cyclic sequence of extreme points is cut
into a linear sequence.

!!! info "Precondition"

    The vector `ps` does not contain the result.

### Implementation

The function implements Eddy's algorithm [^wfe77], which is the two-dimensional
version of the quickhull algorithm [^cbb77].

This algorithm requires ``O(nh)`` time in the worst case for ``n`` input points
with ``h`` extreme points.

[^wfe77]: W. F. Eddy. A new convex hull algorithm for planar sets. *ACM Trans.
          Math. Softw.*, 3:398--403 and 411--412, 1977.

[^cbb96]: C. Bradford Barber, David P. Dobkin, and Hannu Huhdanpaa. The
          Quickhull algorithm for convex hulls. *ACM Trans. Math. Softw.*,
          22(4):469--483, December 1996.

See also: [`ch_akl_toussaint()`](@ref), [`ch_bykat()`](@ref),
[`ch_graham_andrew()`](@ref), [`ch_jarvis()`](@ref), [`ch_melkman()`](@ref),
[`convex_hull_2()`](@ref)
"""
ch_eddy(ps::AbstractVector{Point2})

@doc raw"""
    ch_graham_andrew(ps::AbstractVector{Point2})
    ch_graham_andrew(ps::Point2...)

Returns the counterclockwise sequence of extreme points of points in the vector
`ps`.

It is not specified at which point the cyclic sequence of extreme points is cut
into a linear sequence.

!!! info "Precondition"

    The vector `ps` does not contain the result.

### Implementation

This function implements Andrew's variant of the Graham scan algorithm
[^ama79] and follows the presentation of Mehlhorn [^km84]. This algorithm
requires ``O(n \log n)`` time in the worst case for ``n`` input points.

[^ama79]: A. M. Andrew. Another efficient algorithm for convex hulls in two
    dimensions. *Inform. Process. Lett.*, 9(5):216--219, 1979.

[^km84]: Kurt Mehlhorn. *Data Structures and Algorithms 3: Multi-dimensional
         Searching and Computational Geometry*, volume 3 of *EATCS Monographs
         on Theoretical Computer Science*. Springer-Verlag, Heidelberg,
         Germany, 1984.

See also: [`ch_akl_toussaint()`](@ref), [`ch_bykat()`](@ref),
[`ch_eddy()`](@ref), [`ch_graham_andrew_scan()`](@ref), [`ch_jarvis()`](@ref),
[`ch_melkman()`](@ref), [`convex_hull_2()`](@ref),
[`lower_hull_points_2`](@ref), [`upper_hull_points_2`](@ref)
"""
ch_graham_andrew(ps::AbstractVector{Point2})

@doc raw"""
    ch_jarvis(ps::AbstractVector{Point2})
    ch_jarvis(ps::Point2...)

Returns the counterclockwise sequence of extreme points of points in the vector
`ps`.

It is not specified at which point the cyclic sequence of extreme points is cut
into a linear sequence.

!!! info "Precondition"

    The vector `ps` does not contain the result.

### Implementation

This functions uses the Jarvis march (gift-wrapping) algorithm [^raj73]. This
algorithm requires ``O(nh)`` time in the worst case for ``n`` input points with
``h`` extreme points.

[^raj73]: R. A. Jarvis. On the identification of the convex hull of a finite
          set of points in the plane. *Inform. Process. Lett.*, 2:18--21, 1973.

See also: [`ch_akl_toussaint()`](@ref), [`ch_bykat()`](@ref),
[`ch_eddy()`](@ref), [`ch_graham_andrew()`](@ref), [`ch_jarvis_march()`](@ref),
[`ch_melkman()`](@ref), [`convex_hull_2()`](@ref)
"""
ch_jarvis(ps::AbstractVector{Point2})

@doc raw"""
    ch_melkman(ps::AbstractVector{Point2})
    ch_melkman(ps::Point2...)

Returns the counterclockwise sequence of extreme points of points in the vector
`ps`.

It is not specified at which point the cyclic sequence of extreme points is cut
into a linear sequence.

!!! info "Precondition"

    The vector `ps` does not contain the result.

### Implementation

It uses an implementation of Melkman's algorithm [^am87]. Running time of
this is linear.

[^am87] A. Melkman. On-line construction of the convex hull of a simple
        polyline. *Inform. Process. Lett.*, 25:11--12, 1987.

See also: [`ch_akl_toussaint()`](@ref), [`ch_bykat()`](@ref),
[`ch_eddy()`](@ref), [`ch_graham_andrew()`](@ref), [`ch_jarvis()`](@ref),
[`convex_hull_2()`](@ref)
"""
ch_melkman(ps::AbstractVector{Point2})

@doc raw"""
    convex_hull_2(ps::AbstractVector{Point2})
    convex_hull_2(ps::Point2...)

Returns the counterclockwise sequence of extreme points of points in the vector
`ps`.

It is not specified at which point the cyclic sequence of extreme points is cut
into a linear sequence.

!!! info "Precondition"

    The vector `ps` does not contain the result.

### Implementation

The ``O(n \log n)`` Akl and Toussaint [^sga78] algorithm is used.

See also: [`ch_akl_toussaint()`](@ref), [`ch_bykat()`](@ref),
[`ch_eddy()`](@ref), [`ch_graham_andrew()`](@ref), [`ch_jarvis()`](@ref),
[`ch_melkman()`](@ref)
"""
convex_hull_2(ps::AbstractVector{Point2})

"""
    is_ccw_strongly_convex_2(ps::AbstractVector{Point2})
    is_ccw_strongly_convex_2(ps::Point2...)

The function [`is_ccw_strongly_convex_2()`](@ref) determines if a given
sequence of points defines a counterclockwise-oriented, strongly convex polygon.

It returns `true`, iff the point elements in `ps` form a
counterclockwise-oriented strongly convex polygon.

A set of points is said to be strongly convex if it consists of only extreme
points (*i.e.*, vertices of the convex hull).

### Implementation

The algorithm requires ``O(n)`` time for a set of ``n`` input points.

See also: [`is_cw_strongly_convex_2()`](@ref)
"""
is_ccw_strongly_convex_2(ps::AbstractVector{Point2})

"""
    is_cw_strongly_convex_2(ps::AbstractVector{Point2})
    is_cw_strongly_convex_2(ps::Point2...)

The function [`is_cw_strongly_convex_2()`](@ref) determines if a given sequence
of points defines a clockwise-oriented, strongly convex polygon.

It returns `true`, iff the point elements in `ps` form a clockwise-oriented
strongly convex polygon.

A set of points is said to be strongly convex if it consists of only extreme
points (*i.e.*, vertices of the convex hull).

### Implementation

The algorithm requires ``O(n)`` time for a set of ``n`` input points.

See also: [`is_ccw_strongly_convex_2()`](@ref)
"""
is_cw_strongly_convex_2(ps::AbstractVector{Point2})

for F ∈ (:is_ccw_strongly_convex_2, :is_cw_strongly_convex_2)
    @eval begin
        $F(ps::AbstractVector) = $F(collect(CxxRef{Point2}, CxxRef.(ps)))
        $F(ps::reference_type_union(Point2)...) = $F(collect(CxxRef.(ps)))
    end
end

"""
    ch_graham_andrew_scan(ps::AbstractVector{Point2})
    ch_graham_andrew_scan(p::Point2, q::Point2, ps::Point2...)

Generates the counterclockwise sequence of extreme points from a given
sequence of input points that are not left of the line defined by the first and
last points in this sequence.

More precisely, it generates the counterclockwise sequence of extreme points
from a given sequence of input points that are not left of the line ``pq``
defined by the first (``p``) and last (``q``) points in the sequence (``p`` is
the value of `first(ps)` and ``q`` is the value of `last(ps)`).  The resulting
sequence is returned starting with ``p``; point ``q`` is omitted.

!!! info "Precondition"

    `ps` contains at least two different points.  The points in `ps` are sorted
    with respect to ``pq``, *i.e.*, the sequence of points in `ps` defines a
    counterclockwise polygon, for which the Graham-Sklansky-procedure [^js72]
    works.

### Implementation

This algorithm requires ``O(n)`` time in the worst case for ``n`` input points.

[^js72]: J. Sklansky. Measuring concavity on rectangular mosaic. *IEEE Trans.
         Comput.*, C-21:1355--1364, 1972.

See also: [`ch_graham_andrew()`](@ref), [`lower_hull_points_2()`](@ref),
[`upper_hull_points_2()`](@ref)
"""
ch_graham_andrew_scan(ps::AbstractVector{Point2})

@cxxdereference ch_graham_andrew_scan(ps::AbstractVector) =
    ch_graham_andrew_scan(collect(CxxRef{Point2}, CxxRef.(ps)))
@cxxdereference ch_graham_andrew_scan(p::Point2, q::Point2,
                                      ps::reference_type_union(Point2)...) =
    ch_graham_andrew_scan(CxxRef.([p, q, ps...]))

"""
    ch_jarvis_march(ps::AbstractVector{Point2}, p::Point2, q::Point2)
    ch_jarvis_march(p::Point2, q::Point2, ps::Point2...)

Generates the counterclockwise sequence of extreme points from a given set of
input points that line between two input points.

More precisely, it generates the counterclockwise subsequence of extreme points
between `p` and `q` of the points in `ps`.  Said sequence is returned starting
with point `p`.  The last point generated is the point preceding `q` in the
counterclockwise order of extreme points.

!!! info "Precondition"

    `p` and `q` are extreme points with respect to the points in `ps` and `q`
    belongs to `ps`.

### Implementation

The functions uses the Jarvis march (gift-wrapping) algorithm [^raj73]. This
algorithm requires ``O(nh)`` time in the worst case for ``n`` input points with
``h`` extreme points.

See also: [`ch_jarvis()`](@ref), [`lower_hull_points_2()`](@ref),
[`upper_hull_points_2()`](@ref)
"""
ch_jarvis_march(ps::AbstractVector{Point2}, p::Point2, q::Point2)

@cxxdereference ch_jarvis_march(ps::AbstractVector, p::Point2, q::Point2) =
    ch_jarvis_march(collect(CxxRef{Point2}, CxxRef.(ps)), p, q)
@cxxdereference ch_jarvis_march(p::Point2, q::Point2, ps::Point2...) =
    ch_jarvis_march(collect(ps), p, q)

@doc raw"""
    lower_hull_points_2(ps::AbstractVector{Point2})
    lower_hull_points_2(ps::Point2...)

Generates the counterclockwise sequence of extreme points on the lower hull of a
given set of input points.

More precisely, it generates the counterclockwise sequence of extreme points in
the lower hull of the points in `ps`.  The resulting sequence is returned,
starting with the leftmost point; the rightmost point is not included.  If there
is only one extreme point (*i.e.*, the leftmost and rightmost points are equal),
the extreme point is reported.

!!! info "Precondition"

    `ps` does not contain the result.

The different treatment by [`upper_hull_points_2()`](@ref) of the case that all
points are equal ensures that concatenation of lower and upper hull points gives
the sequence of extreme points.

### Implementation

This function uses Andrew's variant of Graham's scan algorithm [^ama79],
[^km84]. The algorithm has worst-case running time of ``O(n \log n)`` for
``n`` input points.

See also: [`ch_graham_andrew()`](@ref), [`ch_graham_andrew_scan()`](@ref),
[`upper_hull_points_2()`](@ref)
"""
lower_hull_points_2(ps::AbstractVector{Point2})

@doc raw"""
    upper_hull_points_2(ps::AbstractVector{Point2})
    upper_hull_points_2(ps::Point2...)

Generates the counterclockwise sequence of extreme points on the upper hull of a
given set of input points.

More precisely, it generates the counterclockwise sequence of extreme points in
the lower hull of the points in `ps`.  The resulting sequence is returned,
starting with the rightmost point; the leftmost point is not included.  If there
is only one extreme point (*i.e.*, the leftmost and rightmost points are equal),
the extreme point is reported.

!!! info "Precondition"

    `ps` does not contain the result.

The different treatment by [`lower_hull_points_2()`](@ref) of the case that all
points are equal ensures that concatenation of lower and upper hull points gives
the sequence of extreme points.

### Implementation

This function uses Andrew's variant of Graham's scan algorithm [^ama79],
[^km84]. The algorithm has worst-case running time of ``O(n \log n)`` for
``n`` input points.

See also: [`ch_graham_andrew()`](@ref), [`ch_graham_andrew_scan()`](@ref),
[`lower_hull_points_2()`](@ref)
"""
upper_hull_points_2(ps::AbstractVector{Point2})

for F ∈ (:ch_akl_toussaint
       , :ch_bykat
       , :ch_eddy
       , :ch_graham_andrew
       , :ch_jarvis
       , :ch_melkman
       , :convex_hull_2
       , :lower_hull_points_2
       , :upper_hull_points_2)
    @eval begin
        $F(ps::AbstractVector) = $F(collect(CxxRef{Point2}, CxxRef.(ps)))
        $F(ps::reference_type_union(Point2)...) = $F(collect(CxxRef.(ps)))
    end
end


@doc raw"""
    ch_e_point(ps::AbstractVector{Point2})
    ch_e_point(ps::Point2...)

The function [`ch_e_point()`](@ref) finds a point of a given set of input points
with maximal ``x`` coordinate.

It traverses `ps`. After execution, the returned value is the first point
``e`` such that ``∀p\! ∈\! ps\; e ≥_{xy} p``.

See also: [`ch_n_point()`](@ref), [`ch_nswe_point()`](@ref),
[`ch_ns_point()`](@ref), [`ch_s_point()`](@ref), [`ch_w_point()`](@ref),
[`ch_we_point()`](@ref)
"""
ch_e_point(ps::AbstractVector{Point2})

@doc raw"""
    ch_n_point(ps::AbstractVector{Point2})
    ch_n_point(ps::Point2...)

The function [`ch_n_point()`](@ref) finds a point of a given set of input points
with maximal ``y`` coordinate.

It traverses `ps`. After execution, the returned value is the first point
``n`` such that ``∀p\! ∈\! ps\; n ≥_{yx} p``.

See also: [`ch_e_point()`](@ref), [`ch_nswe_point()`](@ref),
[`ch_ns_point()`](@ref), [`ch_s_point()`](@ref), [`ch_w_point()`](@ref),
[`ch_we_point()`](@ref)
"""
ch_n_point(ps::AbstractVector{Point2})

@doc raw"""
    ch_ns_point(ps::AbstractVector{Point2})
    ch_ns_point(ps::Point2...)

The function [`ch_ns_point()`](@ref) finds two points of a given set of input
points with minimal and maximal ``y`` coordinate.

It traverses `ps`. After execution, the returned value is a tuple where the
first point ``n`` is such that ``∀p\! ∈\! ps\; n ≥_{yx} p``, and the second
point ``s`` is such that ``∀p\! ∈\! ps\; s ≤_{yx} p``.

See also: [`ch_e_point()`](@ref), [`ch_nswe_point()`](@ref),
[`ch_n_point()`](@ref), [`ch_s_point()`](@ref), [`ch_w_point()`](@ref),
[`ch_we_point()`](@ref)
"""
ch_ns_point(ps::AbstractVector{Point2})

@doc raw"""
    ch_nswe_point(ps::AbstractVector{Point2})
    ch_nswe_point(ps::Point2...)

The function [`ch_nswe_point()`](@ref) finds the four extreme points of a given
set of input points using a linear scan of the input points.

That is, it determines the points with maximal ``y``, minimal ``y``, minimal
``x``, and maximal ``x`` coordinates.

It traverses `ps`. After execution, the returned value is a tuple where the
first point ``n`` is such that ``∀p\! ∈\! ps\; n ≥_{yx} p``, the second
point ``s`` is such that ``∀p\! ∈\! ps\; s ≤_{yx} p``, the third point ``w`` is
such that ``∀p\! ∈\! ps\; w ≤_{xy} p``, and the fourth point ``e`` is such that
``∀p\! ∈\! ps\; e ≥_{xy} p``.

See also: [`ch_e_point()`](@ref), [`ch_n_point()`](@ref),
[`ch_ns_point()`](@ref), [`ch_s_point()`](@ref), [`ch_w_point()`](@ref),
[`ch_we_point()`](@ref)
"""
ch_nswe_point(ps::AbstractVector{Point2})

@doc raw"""
    ch_s_point(ps::AbstractVector{Point2})
    ch_s_point(ps::Point2...)

The function [`ch_s_point()`](@ref) finds a point of a given set of input points
with minimal ``y`` coordinate.

It traverses `ps`. After execution, the returned value is the first point
``s`` such that ``∀p\! ∈\! ps\; s ≤_{yx} p``.

See also: [`ch_e_point()`](@ref), [`ch_nswe_point()`](@ref),
[`ch_n_point()`](@ref), [`ch_ns_point()`](@ref), [`ch_w_point()`](@ref),
[`ch_we_point()`](@ref)
"""
ch_s_point(ps::AbstractVector{Point2})

@doc raw"""
    ch_w_point(ps::AbstractVector{Point2})
    ch_w_point(ps::Point2...)

The function [`ch_w_point()`](@ref) finds a point of a given set of input points
with minimal ``x`` coordinate.

It traverses `ps`. After execution, the returned value is the first point
``w`` such that ``∀p\! ∈\! ps\; w ≤_{xy} p``.

See also: [`ch_e_point()`](@ref), [`ch_nswe_point()`](@ref),
[`ch_n_point()`](@ref), [`ch_ns_point()`](@ref), [`ch_s_point()`](@ref),
[`ch_we_point()`](@ref)
"""
ch_w_point(ps::AbstractVector{Point2})

@doc raw"""
    ch_we_point(ps::AbstractVector{Point2})
    ch_we_point(ps::Point2...)

The function [`ch_we_point()`](@ref) finds two points of a given set of input
points with minimal and maximal ``x`` coordinate.

It traverses `ps`. After execution, the returned value is a tuple where the
first point ``w`` is such that ``∀p\! ∈\! ps\; w ≤_{xy} p``, and the second
point ``e`` is such that ``∀p\! ∈\! ps\; e ≥_{xy} p``.

See also: [`ch_e_point()`](@ref), [`ch_nswe_point()`](@ref),
[`ch_n_point()`](@ref), [`ch_ns_point()`](@ref), [`ch_s_point()`](@ref),
[`ch_w_point()`](@ref)
"""
ch_we_point(ps::AbstractVector{Point2})

for S ∈ (:e, :n, :ns, :nswe, :s, :w, :we)
    F = Symbol(:ch_, S, :_point)
    @eval begin
        $F(ps::AbstractVector) =
            isempty(ps) ?
                $F([CxxRef(Point2())]) :
                $F(CxxRef.(ps))
        $F(ps::reference_type_union(Point2)...) = $F(collect(CxxRef.(ps)))
    end
end