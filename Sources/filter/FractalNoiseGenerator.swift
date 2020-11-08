import CoreImage

class FractalNoiseGenerator: CIFilter {

    var lowColor: CIColor = .black
    var highColor: CIColor = .white

    var offsetX: Float = 0.0
    var offsetY: Float = 0.0
    var offsetZ: Float = 0.0
    var zoom: Float = 100.0

    var contrast: Float = 1.0

    var octaves: UInt8 = 3
    var frequency: Float = 1.0
    var amplitude: Float = 1.0
    var lacuniarity: Float = 2.0
    var persistence: Float = 0.5

    static var kernel: CIColorKernel? = {
        guard let url = Bundle.main.url(forResource: "SimplexNoise", withExtension: "ci.metallib") else { return nil }

        do {
            let data = try Data(contentsOf: url)
            return try CIColorKernel(functionName: "FractalNoise3D", fromMetalLibraryData: data)
        } catch {
            print("[ERROR] Failed to create CIColorKernel: \(error)")
        }
        return nil
    }()

    override var outputImage: CIImage? {
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
                zoom,
                contrast,
                Float(max(1, min(octaves, 8))),
                frequency,
                amplitude,
                lacuniarity,
                persistence
            ]
        )
    }
}
