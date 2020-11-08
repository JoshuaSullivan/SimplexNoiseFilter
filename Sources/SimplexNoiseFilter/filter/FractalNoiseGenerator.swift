import CoreImage

/// Produces a more complex version of Simplex Noise by combining 2-8 "octaves" of noise.
///
/// Each octave is half the size of the previous one, meaning that additional octaves make
/// the noise more complex while still retaining the smooth transition between values.
///
public final class FractalNoiseGenerator: CIFilter {

    /// The color to use for the value of `0.0` in the noise output.
    public var lowColor: CIColor = .black

    /// The color to use for the value of `1.0` in the noise output.
    public var highColor: CIColor = .white

    /// The distance to shift the noise space along the x-axis. Default value is `0.0`.
    ///
    /// The amount of change is affected by the `zoom` level.
    public var offsetX: Float = 0.0

    /// The distance to shift the noise space along the y-axis. Default value is `0.0`.
    ///
    /// The amount of change is affected by the `zoom` level.
    public var offsetY: Float = 0.0

    /// The distance to shift the noise space along the z-axis. Default value is `0.0`.
    ///
    /// Shifting along the z-axis has the effect of gradulally changing the shape of noise features without
    /// producing any apparent horizontal or vertical movement of the noise, overall. The amount of change
    /// is affected by the `zoom` level.
    public var offsetZ: Float = 0.0

    /// The amount to "zoom in" on the noise. Valid values are in the range [1...1000]. Default value is `100.0`.
    ///
    /// At a value of 1.0, the noise features are extremely small.
    public var zoom: Float = 100.0

    /// The amount of contrast increase or decrease in the final product. Default value is `1.0`.
    ///
    /// A contrast of 1.0 is linear contrast.
    /// A contrast in the range (1 > contrast >= 10) will increase the contrast of the output.
    /// A contrast in the range (0.1 >= contrast > 1) will decrease the contrast of the output.
    public var contrast: Float = 1.0

    /// The number of noise octaves to generate. Valid values are in the range `[1...8]`. Default value is `3`.
    ///
    /// A value of 1 produces the same output as the SimplexNoiseGenerator. Additional octaves produce a
    /// rougher (more complex) texture, while still retaining the smooth transitions.
    public var octaves: UInt8 = 3

    /// Controls the overall scale of the noise. Default value is `1.0`.
    public var frequency: Float = 1.0

    /// Controls the intensity of the noise. Default value is `1.0`.
    public var amplitude: Float = 1.0

    /// Controls how much each octave changes in size.
    public var lacuniarity: Float = 2.0

    /// Controls how much each octave contributes to the overall value.
    public var persistence: Float = 0.5

    /// Set up the kernel by loading the metallib from the bundle.
    private static var kernel: CIColorKernel? = {
        guard let url = Bundle.main.url(forResource: "SimplexNoise", withExtension: "ci.metallib") else { return nil }

        do {
            let data = try Data(contentsOf: url)
            return try CIColorKernel(functionName: "FractalNoise3D", fromMetalLibraryData: data)
        } catch {
            print("[ERROR] Failed to create CIColorKernel: \(error)")
        }
        return nil
    }()

    public override var outputImage: CIImage? {
        guard let kernel = FractalNoiseGenerator.kernel else {
            print("Failed to create kernel.")
            return nil
        }
        return kernel.apply(
            extent: .infinite,
            arguments: [
                lowColor.ciVector,
                highColor.ciVector,
                offsetX,
                offsetY,
                offsetZ,
                max(1.0, min(zoom, 1000.0)),
                max(0.1, min(contrast, 10.0)),
                Float(max(1, min(octaves, 8))),
                frequency,
                amplitude,
                lacuniarity,
                persistence,
            ]
        )
    }
}
