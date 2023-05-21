//
//  ImageView.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 15.04.2023.
//

import MetalKit

class MKImageView: MTKView {
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    lazy var commandQueue: MTLCommandQueue? = { [unowned self] in
        return self.device?.makeCommandQueue()
    }()
    
    lazy var context: CIContext? = { [unowned self] in
        guard let device = self.device else { return nil }
        return CIContext(mtlDevice: device)
    }()
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device ?? MTLCreateSystemDefaultDevice())
        guard super.device != nil else { fatalError("Device doesn't support Metal") }
        framebufferOnly = false
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var image: CIImage? {
        didSet {
            renderImage()
        }
    }
    
    func renderImage() {
        guard let image = image,
              let targetTexture = currentDrawable?.texture,
              let commandBuffer = commandQueue?.makeCommandBuffer() else { return }
        
        let bounds = CGRect(origin: CGPoint.zero, size: drawableSize)
        
        let originX = image.extent.origin.x
        let originY = image.extent.origin.y
        
        let scaleX = drawableSize.width / image.extent.width
        let scaleY = drawableSize.height / image.extent.height
        let scale = min(scaleX, scaleY)
        
        let scaledImage = image
                            .transformed(by: CGAffineTransform(translationX: -originX, y: -originY))
                            .transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        context?.render(scaledImage,
            to: targetTexture,
            commandBuffer: commandBuffer,
            bounds: bounds,
            colorSpace: colorSpace)
        
        commandBuffer.present(currentDrawable!)
        
        commandBuffer.commit()
    }
}
