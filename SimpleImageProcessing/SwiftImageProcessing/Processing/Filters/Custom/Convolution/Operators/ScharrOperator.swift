//
//  ScharrOperator.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

class ScharrOperator: BaseOperator {
    var inputImage: CIImage?
    override var outputImage: CIImage? {
        return applyKernel(source: inputImage, horizontalKernel: horizontalKernel, verticalKernel: verticalKernel)
    }
    
    private let horizontalKernel = CustomKernel.scharrX3x3.vector()
    private let verticalKernel = CustomKernel.scharrY3x3.vector()
}

