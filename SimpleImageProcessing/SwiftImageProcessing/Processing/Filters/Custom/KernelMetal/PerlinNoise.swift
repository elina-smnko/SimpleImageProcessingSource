//
//  PerlinNoise.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 16.04.2023.
//

import CoreImage
import Metal
import MetalKit

class PerlinNoiseGenerator: CIFilter {
    // Define filter input parameters
    var extent: CGRect?
    
    // Define the kernel function as a CIKernel object
    static var kernel: CIKernel = { () -> CIKernel in
        getKernel(type: .general, name: "perlinKernel")
    }()
    
    override var outputImage: CIImage? {
        guard let extent = extent else { return nil }
        
        // Create output image
        return PerlinNoiseGenerator.kernel.apply(extent: extent, roiCallback: { (index, rect) -> CGRect in
            return rect
        }, arguments: [])
    }
}

