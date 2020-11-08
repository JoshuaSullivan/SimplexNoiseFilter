#pragma once

// Adapted from C++ source at: https://github.com/SRombauts/SimplexNoise

/**
 * @brief A Perlin Simplex Noise Metal Implementation
 */
class SimplexNoise {
public:
    // 3D Perlin simplex noise
    static float noise(float x, float y, float z);

    // More complex 3D noise using multiple "octaves"
    static float fractal(size_t octaves, float x, float y, float z, float freq, float amp, float lac, float per);
};


