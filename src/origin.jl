export ORIGIN, NULL_VECTOR

"""
    ORIGIN

A symbolic constant which denotes the point at the origin.

This constant is used in the conversion between points and vectors.

# Example

```jldoctest
julia> p = Point2(1.0, 1.0)
PointC2(1, 1)

julia> v = p - ORIGIN
VectorC2(1, 1)

julia> q = ORIGIN + v
PointC2(1, 1)

julia> p == q
true
```

See also: [`Point2`](@ref), [`Point3`](@ref)
"""
ORIGIN


"""
    NULL_VECTOR

A symbolic constant used to construct zero length vectors.

See also: [`Vector2`](@ref), [`Vector3`](@ref)
"""
NULL_VECTOR
