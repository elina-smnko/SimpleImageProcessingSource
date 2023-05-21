//
//  CIVector+Normalization.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

extension CIVector {
    convenience init(values: [CGFloat], count: Int, normalised: Bool) {
        let weights = normalised ? normalise(weights: values, normalise: true) : values
        self.init(values: weights, count: weights.count)
    }
}

func normalise(weights: [CGFloat], normalise: Bool) -> [CGFloat] {
    if !normalise { return weights }
    let sum = weights.reduce(0, +)
    return sum == 0 ?
        weights :
        weights.map({ $0 / sum })
}
