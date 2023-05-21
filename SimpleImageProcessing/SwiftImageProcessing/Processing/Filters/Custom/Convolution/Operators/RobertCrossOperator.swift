//
//  RobertCrossOperator.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

class RobertCrossOperator: BaseOperator {
    var inputImage: CIImage?
    override var outputImage: CIImage? {
        return applyKernel(source: inputImage, horizontalKernel: horizontalKernel, verticalKernel: verticalKernel)
    }
    
    private let horizontalKernel = CustomKernel.crossX3x3.vector()
    private let verticalKernel = CustomKernel.crossY3x3.vector()
}
