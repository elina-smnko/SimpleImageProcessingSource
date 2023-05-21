//
//  CustomConvolutionFilter.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 22.03.2023.
//

import Foundation
import CoreImage

class CustomConvolutionFilter: CIFilter {
    var bias: CGFloat
    private let kernel: CIVector
    
    init(kernel: CustomKernel, bias: CGFloat = 0) {
        self.bias = bias
        self.kernel = kernel.vector()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        self.bias = 0
        self.kernel = CustomKernel.identity3x3.vector()
        super.init(coder: coder)
    }
    
    func applyKernel(source: CIImage?) -> CIImage? {
        guard let source = source else { return nil }
        return source.applyingConvolution(vector: kernel, bias: bias)
    }
}



