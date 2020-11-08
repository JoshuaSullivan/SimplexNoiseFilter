import CoreImage

extension CIColor {
    var ciVector: CIVector {
        return CIVector(x: red, y: green, z: blue, w: alpha)
    }

    var floatComponents: [CGFloat] {
        return [red, green, blue, alpha]
    }
}
