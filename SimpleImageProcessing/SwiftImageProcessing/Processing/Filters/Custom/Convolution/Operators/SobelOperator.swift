//
//  SobelOperator.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

class SobelOperator3x3: BaseOperator {
    var inputImage: CIImage?
    
    override var outputImage: CIImage? {
        return applyKernel(source: inputImage, horizontalKernel: horizontalKernel, verticalKernel: verticalKernel)
    }
    
    private var horizontalKernel = CustomKernel.sobelX3x3.vector()
    private var verticalKernel = CustomKernel.sobelY3x3.vector()
}

class SobelOperator5x5: BaseOperator {
    var inputImage: CIImage?
    override var outputImage: CIImage? {
        return applyKernel(source: inputImage, horizontalKernel: horizontalKernel, verticalKernel: verticalKernel)
    }
    
    private var horizontalKernel = CustomKernel.sobelX5x5.vector()
    private var verticalKernel = CustomKernel.sobelY5x5.vector()
}

class SobelOperator7x7: BaseOperator {
    var inputImage: CIImage?
    override var outputImage: CIImage? {
        return applyKernel(source: inputImage, horizontalKernel: horizontalKernel, verticalKernel: verticalKernel)
    }
    
    private var horizontalKernel = CustomKernel.sobelX7x7.vector()
    private var verticalKernel = CustomKernel.sobelY7x7.vector()
}


