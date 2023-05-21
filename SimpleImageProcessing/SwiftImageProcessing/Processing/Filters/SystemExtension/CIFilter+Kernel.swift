//
//  CIFilter+Kernel.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 18.03.2023.
//

import Foundation
import CoreImage

enum KernelType {
    case general
    case color
    case warp
}

extension CIFilter {
    static func getKernel(type: KernelType, name: String) -> CIKernel {
        guard let url = Bundle.main.url(forResource: "default",
                                withExtension: "metallib"),
              let data = try? Data(contentsOf: url)
        else { fatalError("No Metal file found") }
        
        switch type {
        case .general:
            return try! CIKernel(functionName: name,
                              fromMetalLibraryData: data)
        case .color:
            return try! CIColorKernel(functionName: name,
                              fromMetalLibraryData: data)
        case .warp:
            return try! CIWarpKernel(functionName: name,
                              fromMetalLibraryData: data)
        }
    }
}
