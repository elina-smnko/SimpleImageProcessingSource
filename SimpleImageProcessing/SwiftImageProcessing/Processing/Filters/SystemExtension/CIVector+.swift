//
//  CIVector+.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

extension CIVector {
    func multiply(by val: CGFloat) -> CIVector {
        var target: [CGFloat] = []
        for i in 0..<count {
            target.append(value(at: i) * val)
        }
        return CIVector(values: target, count: target.count)
    }
}
