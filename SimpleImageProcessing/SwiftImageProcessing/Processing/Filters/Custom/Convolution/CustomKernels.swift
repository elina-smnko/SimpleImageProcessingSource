//
//  CustomKernels.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 22.03.2023.
//

import Foundation
import CoreImage

enum CustomKernel {
    case identity3x3
    case boxBlur3x3
    case sharpen1_3x3
    case sharpen2_3x3
    case sharpen3_3x3
    case edgeDetect3x3
    case laplacian3x3
    case emboss3x3
    case sobelX3x3
    case sobelY3x3
    case crossX3x3
    case crossY3x3
    case scharrX3x3
    case scharrY3x3
    case boxBlur5x5
    case laplacian5x5
    case gaussian5x5
    case laplaccianOfGaussian5x5
    case emboss5x5
    case unsharp5x5
    case sharpen5x5
    case sobelX5x5
    case sobelY5x5
    case boxBlur7x7
    case sobelX7x7
    case sobelY7x7
    case edgeDetect7x7
    case laplacian7x7
    case gaussian7x7
    
    
    func vector() -> CIVector {
        switch self {
        case .identity3x3:
            return CIVector(values: [
                                0,0,0,
                                0,1,0,
                                0,0,0], count: 9)
        case .boxBlur3x3:
            return CIVector(values: [
                                1,1,1,
                                1,1,1,
                                1,1,1], count: 9)
        case .sharpen1_3x3:
            return CIVector(values: [
                                0,-1,0,
                                -1,5,-1,
                                0,-1,0], count: 9)
        case .sharpen2_3x3:
            return CIVector(values: [
                                -1,-1,-1,
                                -1,9,-1,
                                -1,-1,-1], count: 9)
        case .sharpen3_3x3:
            return CIVector(values: [
                                1,1,1,
                                1,-7,1,
                                1,1,1], count: 9)
        case .edgeDetect3x3:
            return CIVector(values: [
                                -1,-1,-1,
                                -1,8,-1,
                                -1,-1,-1], count: 9)
        case .laplacian3x3:
            return CIVector(values: [
                                0,1,0,
                                1,-4,1,
                                0,1,0], count: 9)
        case .emboss3x3:
            return CIVector(values: [
                                -2,-1,0,
                                -1,1,1,
                                0,1,2], count: 9)
        case .sobelX3x3:
            return CIVector(values: [
                                -1,0,1,
                                -2,0,2,
                                -1,0,1], count: 9)
        case .sobelY3x3:
            return CIVector(values: [
                                -1,-2,-1,
                                0,0,0,
                                1,2,1], count: 9)
        case .crossX3x3:
            return CIVector(values: [
                                1,0,0,
                                0,-1,0,
                                0,0,0], count: 9)
        case .crossY3x3:
            return CIVector(values: [
                                0,1,0,
                                -1,0,0,
                                0,0,0], count: 9)
        case .scharrX3x3:
            return CIVector(values: [
                                3,0,-3,
                                10,0,-10,
                                3,0,-3], count: 9)
        case .scharrY3x3:
            return CIVector(values: [
                                3,10,3,
                                0,0,0,
                                -3,-10,-3], count: 9)
        case .boxBlur5x5:
            return CIVector(values: [
                                1,1,1,1,1,
                                1,1,1,1,1,
                                1,1,1,1,1,
                                1,1,1,1,1,
                                1,1,1,1,1], count: 25)
        case .laplacian5x5:
            return CIVector(values: [
                                -4,-1, 0,-1,-4,
                                -1, 2, 3, 2,-1,
                                0, 3, 4, 3, 0,
                                -1, 2, 3, 2,-1,
                                -4,-1, 0,-1,-4], count: 25)
        case .gaussian5x5:
            return CIVector(values: [
                                1,  4,  7,  4, 1,
                                4, 16, 26, 16, 4,
                                7, 26, 41, 26, 7,
                                4, 16, 26, 16, 4,
                                1,  4,  7,  4, 1], count: 25)
        case .laplaccianOfGaussian5x5:
            return CIVector(values: [
                                0,  0, -1,  0,  0,
                                0, -1, -2, -1,  0,
                                -1, -2, 16, -2, -1,
                                0, -1, -2, -1,  0,
                                0,  0, -1,  0,  0], count: 25)
        case .emboss5x5:
            return CIVector(values: [
                                -1, -1, -1, -1, 0,
                                -1, -1, -1,  0, 1,
                                -1, -1,  0,  1, 1,
                                -1,  0,  1,  1, 0,
                                0,  1,  1,  1, 1], count: 25)
        case .unsharp5x5:
            return CIVector(values: [
                                1, 4, 6, 4, 1,
                                4, 16, 24, 16, 4,
                                6, 24, -476, 24, 6,
                                4, 16, 24, 16, 4,
                                1, 4, 6, 4, 1], count: 25)
        case .sharpen5x5:
            return CIVector(values: [
                                -1, -1, -1, -1, -1,
                                -1,  2,  2,  2, -1,
                                -1,  2,  8,  2, -1,
                                -1,  2,  2,  2, -1,
                                -1, -1, -1, -1, -1], count: 25)
        case .sobelX5x5:
            return CIVector(values: [
                                -1, -2, 0, 2, 1,
                                -4, -8, 0, 8, 4,
                                -6, -12, 0, 12, 6,
                                -4, -8, 0, 8, 4,
                                -1, -2, 0, 2, 1], count: 25)
        case .sobelY5x5:
            return CIVector(values: [
                                -1, -4, -6, -4, -1,
                                -2, -8, -12, -8, -2,
                                0, 0, 0, 0, 0,
                                2, 8, 12, 8, 2,
                                1, 4, 6, 4, 1], count: 25)
        case .boxBlur7x7:
            return CIVector(values: [
                                1,1,1,1,1,1,1,
                                1,1,1,1,1,1,1,
                                1,1,1,1,1,1,1,
                                1,1,1,1,1,1,1,
                                1,1,1,1,1,1,1,
                                1,1,1,1,1,1,1,
                                1,1,1,1,1,1,1], count: 49)
        case .sobelX7x7:
            return CIVector(values: [
                                -1,  -2,  -3, 0,  3,  2, 1,
                                -3,  -6,  -7, 0,  7,  6, 3,
                                -6, -14, -15, 0, 15, 14, 6,
                                -8, -18, -20, 0, 20, 18, 8,
                                -6, -14, -15, 0, 15, 14, 6,
                                -3,  -6,  -7, 0,  7,  6, 3,
                                -1,  -2,  -3, 0,  3,  2, 1,], count: 49)
        case .sobelY7x7:
            return CIVector(values: [
                                -1, -3,  -6,  -8,  -6, -3, -1,
                                -2, -6, -14, -18, -14, -6, -2,
                                -3, -7, -15, -20, -15, -7, -3,
                                0,  0,   0,   0,   0,  0,  0,
                                3,  7,  15,  20,  15,  7,  3,
                                2,  6,  14,  18,  14,  6,  2,
                                1,  3,   6,   8,   6,  3,  1], count: 49)
        case .edgeDetect7x7:
            return CIVector(values: [
                                0,  0, -1, -1, -1,  0,  0,
                                0, -1, -3, -3, -3, -1,  0,
                                -1, -3,  0,  7,  0, -3, -1,
                                -1, -3,  7, 25,  7, -3, -1,
                                -1, -3,  0,  7,  0, -3, -1,
                                0, -1, -3, -3, -3, -1,  0,
                                0,  0, -1, -1, -1,  0,  0], count: 49)
        case .laplacian7x7:
            return CIVector(values: [
                                -10, -5, -2, -1, -2, -5, -10,
                                -5,  0,  3,  4,  3,  0,  -5,
                                -2,  3,  6,  7,  6,  3,  -2,
                                -1,  4,  7,  8,  7,  4,  -1,
                                -2,  3,  6,  7,  6,  3,  -2,
                                -5,  0,  3,  4,  3,  0,  -5,
                                -10, -5, -2, -1, -2, -5, -10], count: 49)
        case .gaussian7x7:
            return CIVector(values: [
                                0,  0,   0,   5,   0,  0, 0,
                                0,  5,  18,  32,  18,  5, 0,
                                0, 18,  64, 100,  64, 18, 0,
                                5, 32, 100, 100, 100, 32, 5,
                                0, 18,  64, 100,  64, 18, 0,
                                0,  5,  18,  32,  18,  5, 0,
                                0,  0,   0,  5,    0,  0, 0], count: 49)
        }
    }
}
