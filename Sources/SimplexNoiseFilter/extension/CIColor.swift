import CoreImage

public extension CIColor {
    /// Convert a CIColor into a CIVector[4] for use in Metal.
    var ciVector: CIVector {
        return CIVector(x: red, y: green, z: blue, w: alpha)
    }
}
