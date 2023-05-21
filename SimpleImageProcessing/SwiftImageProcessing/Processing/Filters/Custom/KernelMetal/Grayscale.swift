//
//  Grayscale.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

class Grayscale: CIFilter {
    static var kernel: CIColorKernel = { () -> CIColorKernel in
        getKernel(type: .color, name: "grayscaleKernel") as! CIColorKernel
    }()

    var inputImage: CIImage?
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }
        return Grayscale.kernel.apply(extent: inputImage.extent,
                                       roiCallback: { (index, rect) -> CGRect in
                                                      return rect
                                      }, arguments: [inputImage])
    }
}

