//
//  AVCaptureViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/8.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import AVFoundation
import CoreGraphics
class AVCaptureViewController: UIViewController {

    var session = AVCaptureSession.init()
    var output = AVCaptureVideoDataOutput.init()
    var previewLayer:AVCaptureVideoPreviewLayer?
    var imgv = UIImageView.init(frame: CGRect.init(x: 0, y: 50, width: 100, height: 100))
     let opq = DispatchQueue(label: "dd")
    let detector = CIDetector.init(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyLow,CIDetectorImageOrientation:NSNumber.init(value: 6)])
    
    lazy var resultv = {
       
        ()->UIView in
        let v = UIView.init()
        v.backgroundColor = UIColor.init(white: 0.5, alpha: 0.9)
        v.frame = self.view.bounds
        self.view.addSubview(v)
        return v
    }()
    lazy var redP =
        { () -> UIView in
            let v = UIView.init()
            v.backgroundColor = UIColor.red
//            self.view.addSubview(v)
            return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.resultv.transform = CGAffineTransform(scaleX: 1, y: -1)//jason
        self.resultv.addSubview(self.redP)
//    self.view.addSubview(self.imgv)
        // Do any additional setup after loading the view.
        self.setAVSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("mmmmm")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func setAVSetting(){
        
//        session.canSetSessionPreset(.hd4K3840x2160)
        session.sessionPreset = .medium
        guard   let device = AVCaptureDevice.default(for: .video) else {
            
            return
        }
        let deviceInput = try? AVCaptureDeviceInput.init(device: device)
        
        guard session.canAddInput(deviceInput!) else {
            return
        }

        session.addInput(deviceInput!)
        
        guard session.canAddOutput(output) else {
            
            return
        }

        output.setSampleBufferDelegate(self, queue: self.opq)
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey:kCVPixelFormatType_32BGRA] as [String : Any]
        output.alwaysDiscardsLateVideoFrames = true
        session.addOutput(output)
        output.connection(with: .video)
        previewLayer = AVCaptureVideoPreviewLayer.init(session: session)
        previewLayer?.frame = self.view.bounds
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(previewLayer!)
        session.startRunning()
    }
}


extension AVCaptureViewController:AVCaptureVideoDataOutputSampleBufferDelegate{
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

            self.imageFromSampleBuffer(sampleBuffer: sampleBuffer)
    }
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
     

    }
    
}

extension AVCaptureViewController{
    func imageFromSampleBuffer(sampleBuffer : CMSampleBuffer) -> Void
    {
        // Get a CMSampleBuffer's Core Video image buffer for the media data
        let  imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        // Lock the base address of the pixel buffer
        CVPixelBufferLockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly);
        
        
        // Get the number of bytes per row for the pixel buffer
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer!);
        
        // Get the number of bytes per row for the pixel buffer
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer!);
        // Get the pixel buffer width and height
        let width = CVPixelBufferGetWidth(imageBuffer!);
        let height = CVPixelBufferGetHeight(imageBuffer!);
        
        // Create a device-dependent RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        
        // Create a bitmap graphics context with the sample buffer data
        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue
        bitmapInfo |= CGImageAlphaInfo.premultipliedFirst.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        //let bitmapInfo: UInt32 = CGBitmapInfo.alphaInfoMask.rawValue
        let context = CGContext.init(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        // Create a Quartz image from the pixel data in the bitmap graphics context
        let quartzImage = context?.makeImage();
        // Unlock the pixel buffer
        CVPixelBufferUnlockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly);
        
        // Create an image object from the Quartz image
        let image = UIImage.init(cgImage: quartzImage!);
        print("the cur threed is \(Thread.current)")
//        return (image);
//        weak var weakself = self
        self.detectFace(img: image)
        /*
        DispatchQueue.main.async {
        
            self.imgv.image = image
           self.view.bringSubview(toFront: self.imgv)
            print("the imgv is \(self.imgv)")
    }
 */
    }
}

extension AVCaptureViewController{
    //检测人脸
    func detectFace(img image:UIImage) -> Void {
//        kCGImagePropertyOrientation
        let ciImg = CIImage.init(cgImage: image.cgImage!)

        
        let arr = detector?.features(in: ciImg)
        
        let ciImageSize = ciImg.extent.size
//        var transform = CGAffineTransform(scaleX: 1, y: -1)
//        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        for faceObject in arr! {

            let facef = faceObject as! CIFaceFeature
            print("found face lefteye=\(facef.leftEyePosition) righteye=\(facef.rightEyePosition)")

            DispatchQueue.main.async {
                // 坐标系的转换
//                [resultView setTransform:CGAffineTransformMakeScale(1, -1)];

                let scale = min(self.view.frame.size.width / ciImageSize.width,
                                self.view.frame.size.height / ciImageSize.height)
                self.redP.frame = CGRect.init(x: facef.leftEyePosition.x, y: facef.leftEyePosition.y, width: 40, height: 40)
                
                self.redP.center =  CGPoint.init(x: facef.leftEyePosition.x ,y:facef.leftEyePosition.y)
            
//                self.resultv.transform = CGAffineTransform(scaleX: 1, y: -1)
                print("the left postionx = \(facef.leftEyePosition.applying(CGAffineTransform(scaleX: 1, y: -1)))")
                print("the original positionx =\(facef.leftEyePosition.x)")
                self.view.bringSubview(toFront: self.resultv)
                print("the redp is \(self.redP)mmm\(scale)")
            }
        }
    }
    
}
