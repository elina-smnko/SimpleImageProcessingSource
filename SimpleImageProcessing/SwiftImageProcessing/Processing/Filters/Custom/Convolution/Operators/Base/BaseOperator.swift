//
//  BaseOperator.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

class BaseOperator: CIFilter {
    var bias: CGFloat
    
    init(bias: CGFloat = 0) {
        self.bias = bias
        super.init()
    }
    
    required init?(coder: NSCoder) {
        self.bias = 0
        super.init(coder: coder)
    }
    
    func applyKernel(source: CIImage?, horizontalKernel: CIVector, verticalKernel: CIVector) -> CIImage? {
        guard let source = source else { return nil }
        return source
            .applyingConvolution(vector: horizontalKernel, bias: bias)?
            .applyingConvolution(vector: verticalKernel, bias: bias)?
            .cropped(to: source.extent)
    }
}
