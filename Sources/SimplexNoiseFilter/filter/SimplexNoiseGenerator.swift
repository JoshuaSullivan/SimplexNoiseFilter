import CoreImage

class SimplexNoiseGenerator: CIFilter {

    var lowColor: CIColor = .black
    var highColor: CIColor = .white

    var offsetX: Float = 0.0
    var offsetY: Float = 0.0
    var offsetZ: Float = 0.0
    var zoom: Float = 100.0

    var contrast: Float = 1.0

    static var kernel: CIColorKernel? = {
        guard let url = Bundle.main.url(forResource: "SimplexNoise", withExtension: "ci.metallib") else { return nil }

        do {
            let data = try Data(contentsOf: url)
            return try CIColorKernel(functionName: "SimplexNoise3D", fromMetalLibraryData: data)
        } catch {
            print("[ERROR] Failed to create CIColorKernel: \(error)")
        }
        return nil
    }()

    override var outputImage: CIImage? {
        guard let kernel = SimplexNoiseGenerator.kernel else {
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
                contrast
            ]
        )
    }
}
