//
//  Images.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import AVFoundation
import Photos
import UIKit

class Images {
    
    // collect local images - collectImageSet()
    func collectLocalImages() -> [UIImage] {
        var localImages = [UIImage].init()
        let imageNames: [String] = ["MP_boat", "MP_cat", "MP_dome", "MP_flowers", "MP_grass", "MP_house", "MP_paint", "MP_shark", "MP_sunset"]
        
        for name in imageNames {
            if let image = UIImage.init(named: name) {
                localImages.append(image)
            }
        }
        
        return localImages
    }
    
    // randomize images
    func pullRandomImage(from imageArray: [UIImage], in controller: UIViewController) throws -> UIImage? {
        guard imageArray.count > 0  else {
        errorAlert(message: "Couldn't pull random image from storage", in: controller)
        throw ErrorMessages.misc(error: "imageArray Missing Images")
        }
        
        let randomIndex = Int.random(in: 0..<imageArray.count)
        let randomizedImage = imageArray[randomIndex]
        print("randomImage() = Pass!")
        return randomizedImage
    }
    
    // processPicked()
    func unwrap(image: UIImage?, in controller: UIViewController) throws -> UIImage? {
        guard let newImage = image else {
            
            errorAlert(message: "Couldn't unwrap images", in: controller)
            throw ErrorMessages.noImage
        }
        print("unwrapImage() = Pass!")
        return newImage
    }
    
    // troubleAlertMessage()
    func errorAlert(message: String?, in view: UIViewController) {
        let alertController = UIAlertController(title: "Oops...", message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(OkAction)
        view.present(alertController, animated: true)
    }
    
    func presentImagePicker(sourceType: UIImagePickerController.SourceType, in view: UIViewController) {
        let imagePicker = UIImagePickerController()
        // may become a probelm
        imagePicker.delegate = (view as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        imagePicker.sourceType = sourceType
        view.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func move(image: UIView, sender: UIPanGestureRecognizer) {
        var initalImageOffset = CGPoint()
        
        let translation = sender.translation(in: image)
        
        if sender.state == .began {
            initalImageOffset = image.frame.origin
        }
        
        let position = CGPoint(x: translation.x + initalImageOffset.x - image.frame.origin.x, y: translation.y + initalImageOffset.y - image.frame.origin.y)
        image.transform = image.transform.translatedBy(x: position.x, y: position.y)
        }
    
    
    
    // Display Camera || Photo Library
    func displayMediaLibrary(source: UIImagePickerController.SourceType, inView view: UIViewController) {
        let sourceType = source
        
        let permissionMessage = [
            "photos" : "Mosaic Puzzle does not have access to use your photos. Please go to Settings>Mosaic Puzzle>Photos on your device to allow Mosaic Puzzle to use your photo library.",
            "camera" : "Mosaic Puzzle does not have access to use your camera. Please go to Settings>Mosaic Puzzle>Camera on your device to allow Mosaic Puzzle to use your Camera."]
        
        switch sourceType {
        case .photoLibrary:
            
            // checking if our source type is avalible
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                
                // access the current permission status of photo library
                let status = PHPhotoLibrary.authorizationStatus()
                
                switch status {
                // .notDetermined - user never asked to use Photo Library befrore
                case .notDetermined:
                    // then request photo library acess permission
                    PHPhotoLibrary.requestAuthorization({ (newStatus) in
                        if newStatus == .authorized {
                            // if accepted display imagePicker
                            self.presentImagePicker(sourceType: sourceType, in: view )
                        } else {
                            // else display message
                            self.errorAlert(message: permissionMessage["photos"], in: view)
                        }
                    })
                case .authorized:
                    print("authorized")
                    self.presentImagePicker(sourceType: sourceType, in: view)
                    
                case .denied, .restricted: // case no or never, display message
                    self.errorAlert(message: permissionMessage["photos"], in: view)
                default:
                    self.errorAlert(message: "No Photo Library Found", in: view)
                }
                
            }
                
            else { // else if UIImagePickerController photo Library source type is not avalible then print message alert controller
                self.errorAlert(message: permissionMessage["photos"], in: view)
            }
            
        case .camera:
            
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                
                
                switch status {
                case .notDetermined:
                    AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {(granted) in
                        if granted {
                            self.presentImagePicker(sourceType: sourceType, in: view)
                        } else {
                            self.errorAlert(message: permissionMessage["camera"], in: view)
                        }
                    })
                case .authorized:
                    self.presentImagePicker(sourceType: sourceType, in: view)
                case .denied, .restricted:
                    self.errorAlert(message: permissionMessage["camera"], in: view)
                default:
                    self.errorAlert(message: "No Camera Found", in: view)
                }
            }
            else {
                self.errorAlert(message: permissionMessage["camera"], in: view)
            }
            
        case .savedPhotosAlbum:
            break
        default:
            self.errorAlert(message: "Couldn't Access Library", in: view)
        }
    }
    
    
    
    
}
