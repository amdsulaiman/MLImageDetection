//
//  ObjectDetectionVC.swift
//  CoreML2
//
//  
//

import UIKit
import AVKit
import Vision

class ObjectDetectionVC: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var objectNamelbl: UILabel!
    @IBOutlet weak var accuracyLbl: UILabel!
    
    var model = Resnet50().model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice)  else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        view.addSubview(bottomView)
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 15
        bottomView.layer.masksToBounds = true
        
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        
        
        
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: model) else { return}
        
        let request = VNCoreMLRequest(model: model) { finishedReq,err in
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return}
            guard let firstObservation = results.first else { return }
            
            var name : String = firstObservation.identifier
            var acc : Int = Int(firstObservation.confidence * 100)
            DispatchQueue.main.async {
                self.objectNamelbl.text = name
                self.accuracyLbl.text = "Accuracy :\(acc)%"
                print(name)
                print(acc)
            }
            
            
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
       
    }
    
    
}
