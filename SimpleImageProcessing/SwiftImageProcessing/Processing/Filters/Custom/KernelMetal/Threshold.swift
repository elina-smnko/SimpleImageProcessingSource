//
//  Threshold.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 13.03.2023.
//

import Foundation
import CoreImage

class Threshold: CIFilter {
    static var kernel: CIColorKernel = { () -> CIColorKernel in
        getKernel(type: .color, name: "thresholdKernel") as! CIColorKernel
    }()

    var inputImage: CIImage?
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }
        return Threshold.kernel.apply(extent: inputImage.extent,
                                       roiCallback: { (index, rect) -> CGRect in
                                                      return rect
                                      }, arguments: [inputImage, threshold])
    }

    private var threshold: Float

    init(threshold: Float) {
        self.threshold = threshold
        super.init()
    }

    required init?(coder: NSCoder) {
        self.threshold = 0
        super.init(coder: coder)
    }
}
