//
//  CIImage+Convolution.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

extension CIImage {
    func applyingConvolution(vector: CIVector, bias: CGFloat = 0) -> CIImage? {
        let filterName: String
        switch vector.count {
        case 9:
            filterName = "CIConvolution3X3"
        case 25:
            filterName = "CIConvolution5X5"
        default:
            filterName = "CIConvolution7X7"
        }
        
        let parameters: [String: Any] = [kCIInputWeightsKey : vector, kCIInputBiasKey: bias]
        
        return applyingFilter(filterName, parameters: parameters)
            .applyingFilter("CIColorMatrix",
                            parameters: ["inputBiasVector": CIVector(x: 0, y: 0, z: 0, w: 1)])
            .cropped(to: extent)
    }
    
    func applyingConvolution(kernel: [CGFloat], normalise: Bool, bias: CGFloat = 0) -> CIImage? {
        let weightMatrix = CIVector(values: kernel, count: kernel.count, normalised: normalise)
        return applyingConvolution(vector: weightMatrix, bias: bias)
    }
}

