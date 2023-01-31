//
//  SimpleCameraControllerViewController.swift
//  camera
//
//  Created by Hira on 2020/1/17.
//

import UIKit
import AVFoundation

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var landingImg: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var libraryBtn: UIButton!
    @IBOutlet weak var changeMode: UIButton!

    //AVFoundation 媒體擷取核心是 AVCaptureSession 物件
    let captureSession = AVCaptureSession()
    //相機裝置
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    //裝置輸出
    var stillImageOutput: AVCaptureStillImageOutput?
    var stillImage: UIImage?
    //相機預覽
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    //轉換前後鏡頭手勢
    var toggleCameraGestureRecognizer = UISwipeGestureRecognizer()
    //鏡頭縮放手勢
    var zoomInGestureRecognizer = UISwipeGestureRecognizer()
    var zoomOutGestureRecognizer = UISwipeGestureRecognizer()
    //相簿選取照片
    var libraryImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let devices = AVCaptureDevice.devices(for: AVMediaType.video)
        for devices in devices {
            if devices.position == AVCaptureDevice.Position.back {
                backFacingCamera = devices
            } else if devices.position == AVCaptureDevice.Position.front{
                frontFacingCamera = devices
            }
        }
        
        currentDevice = backFacingCamera
        
        do {
            //以全解析度照相來預設photo
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
            var deviceDiscoverySession: AVCaptureDevice?
            if #available(iOS 10.0, *) {
                deviceDiscoverySession = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
            } else {
                deviceDiscoverySession = AVCaptureDevice.devices(for: AVMediaType.video).first
            }

            guard let captureDevice = deviceDiscoverySession else {
                print("找不到相機")
                return
            }
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)

            //設置輸出的session為擷取靜態圖片
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]

            //輸出與輸入裝置的session設置
            captureSession.addInput(captureDeviceInput)
            captureSession.addOutput(stillImageOutput!)

            //提供相機預覽
            cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(cameraPreviewLayer!)
            cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            cameraPreviewLayer?.frame = view.layer.frame

            //將按鈕調整到父檢視的最上面
            view.bringSubviewToFront(cameraBtn)
            view.bringSubviewToFront(libraryBtn)
            view.bringSubviewToFront(changeMode)
            captureSession.startRunning()
        } catch {
            print(error)
        }

        //相機辨識器的切換
        toggleCameraGestureRecognizer.direction = .right
        toggleCameraGestureRecognizer.addTarget(self, action: #selector(toggleCamera))
        view.addGestureRecognizer(toggleCameraGestureRecognizer)
        changeMode.addTarget(self, action: #selector(toggleCamera), for: .touchUpInside)

        //放大
        zoomInGestureRecognizer.direction = .up
        zoomInGestureRecognizer.addTarget(self, action: #selector(zoomIn))
        view.addGestureRecognizer(zoomInGestureRecognizer)

        //縮小
        zoomOutGestureRecognizer.direction = .down
        zoomOutGestureRecognizer.addTarget(self, action: #selector(zoomOut))
        view.addGestureRecognizer(zoomOutGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        landingImg.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - 拍照

    @IBAction func capture(sender: UIButton) {
        let videoConnection = stillImageOutput?.connection(with: AVMediaType.video)
        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection!, completionHandler: { (imageDataSampleBuffer, error) -> Void in

            if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!) {
                self.stillImage = UIImage(data: imageData)
                self.performSegue(withIdentifier: "showPhoto", sender: self)
            }
        })
    }

    // MARK: - Camera 手勢 or 點擊按鈕
    @objc func toggleCamera() {
        captureSession.beginConfiguration()

        //依照目前的相機變更位置
        let newDevice = (currentDevice?.position == AVCaptureDevice.Position.back) ? frontFacingCamera : backFacingCamera

        //從session移除所有的輸入
        for input in captureSession.inputs {
            captureSession.removeInput(input as! AVCaptureDeviceInput)
        }

        //變更為新的輸入
        let cameraInput: AVCaptureDeviceInput
        do {
            cameraInput = try AVCaptureDeviceInput(device: newDevice!)
        } catch {
            print(error)
            return
        }

        if captureSession.canAddInput(cameraInput) {
            captureSession.addInput(cameraInput)
        }

        currentDevice = newDevice
        captureSession.commitConfiguration()
    }

    @objc func zoomIn() {
        if let zoomFactor = currentDevice?.videoZoomFactor {
            if zoomFactor < 10.0 {
                let newZoomFactor = min(zoomFactor + 1.0, 20.0)
                do {
                    try currentDevice?.lockForConfiguration()
                    currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 0.5)
                    currentDevice?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }

    @objc func zoomOut() {
        if let zoomFactor = currentDevice?.videoZoomFactor {
            if zoomFactor > 1.0 {
                let newZoomFactor = max(zoomFactor - 1.0, 1.0)
                do {
                    try currentDevice?.lockForConfiguration()
                    currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                    currentDevice?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }

    // MARK: - PhotoLibrary

    @IBAction func photoLibrary(_ sender: Any) {
        //self.performSegue(withIdentifier: "showPhotoLibrary", sender: self)
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        imagePickerVC.modalPresentationStyle = .popover
        let popover = imagePickerVC.popoverPresentationController
        popover?.sourceView = sender as? UIView
        popover?.sourceRect = (sender as AnyObject).bounds
        popover?.permittedArrowDirections = .any

        show(imagePickerVC, sender: self)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        self.libraryImage = image
        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "showPhotoLibrary", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showPhoto" {
            let photoViewController = segue.destination as! PhotoViewController
            photoViewController.image = stillImage
        } else if segue.identifier == "showPhotoLibrary" {
            let photoLibraryController = segue.destination as! PhotoLibraryViewController
            photoLibraryController.image = libraryImage
        }
    }
}
