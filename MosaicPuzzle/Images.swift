//
//  Images.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import Foundation
import UIKit

class Images {
    
    // collect local images
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
        errorAlert(message: "Couldn't pull random images", in: controller)
        throw ErrorMessages.misc(error: "imageArray Missing Images")
        }
        
        let randomIndex = Int.random(in: 0..<imageArray.count)
        let randomizedImage = imageArray[randomIndex]
        print("randomImage() = Pass!")
        return randomizedImage
    }
    
    
    func unwrap(image: UIImage?, in controller: UIViewController) throws -> UIImage? {
        guard let newImage = image else {
            
            errorAlert(message: "Couldn't unwrap images", in: controller)
            throw ErrorMessages.noImage
        }
        print("unwrapImage() = Pass!")
        return newImage
    }
    
    
    func errorAlert(message: String?, in view: UIViewController) {
        let alertController = UIAlertController(title: "Oops...", message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(OkAction)
        view.present(alertController, animated: true)
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
    
    
    
}
