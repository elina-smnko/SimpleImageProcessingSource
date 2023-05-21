//
//  CameraStream.swift
//  SwiftImageProcessing
//
//  Created by Elina Semenko on 15.04.2023.
//

import AVFoundation
import CoreMedia
import CoreImage

class CameraStream: NSObject {
    weak var delegate: CameraStreamDelegate?
    
    let session = AVCaptureSession()
    let devicePosition: AVCaptureDevice.Position
    
    required init(devicePosition: AVCaptureDevice.Position) {
        self.devicePosition = devicePosition
        super.init()
        initialiseCaptureSession()
    }
    
    fileprivate func initialiseCaptureSession() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard let self = self else { return }
            if granted {
                self.session.beginConfiguration()
                
                guard let videoDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: self.devicePosition) else {
                    fatalError("Unable to access video device")
                }
                let videoDeviceInput = try! AVCaptureDeviceInput(device: videoDevice)
                self.session.addInput(videoDeviceInput)
                
                let videoDataOutput = AVCaptureVideoDataOutput()
                videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
                videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
                self.session.addOutput(videoDataOutput)
                
                self.session.commitConfiguration()
                self.session.startRunning()
            } else {
                print("Camera access denied")
            }
        }
    }
}

extension CameraStream: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        DispatchQueue.main.async {
            self.delegate?.didCaptureImage(self, image: CIImage(cvPixelBuffer: pixelBuffer))
        }
    }
}

protocol CameraStreamDelegate: AnyObject {
    func didCaptureImage(_ cameraStream: CameraStream, image: CIImage)
}
