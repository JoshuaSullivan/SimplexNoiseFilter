# Simplex Noise Filter
#### By Joshua Sullivan

This package provides 2 new Core Image filters for creating "smooth noise". The filter kernels are written in Metal Shading Language for maximum performance. They require a GPU-accelerated CIContext in order to run.

## SimplexNoiseGenerator
A Metal-based implementation of the 3D Simplex noise generation algorithm. It produces monochromatic noise that varies smoothly in the range [0…1]. Visually, it resembles the ripples on the surface of water.

## FractalNoiseGenerator
This filter composes multiple "octaves" of Simplex Noise to create a more complex texture, while still retaining the overall smooth transitions. As with the `SimplexNoiseGenerator`, it produces values that vary smoothly in the range [0…1]. Visually, it resembles terrain or clouds.
