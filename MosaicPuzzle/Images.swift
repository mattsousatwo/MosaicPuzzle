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
    func pullRandomImage(from imageArray: [UIImage], in controller: UIViewController) -> UIImage? {
        
        if imageArray.count > 0 {
            while true {
                let randomIndex = Int.random(in: 0..<imageArray.count)
                let randomizedImage = imageArray[randomIndex]
                print("randomImage() = Pass!")
                return randomizedImage
            }
        }
        
        print("randomImage() Failed")
        
        errorAlert(message: "Couldn't pull random images", in: controller)
        return nil
    }
    
    
    func unwrap(image: UIImage?, in controller: UIViewController) -> UIImage? {
        
        if let newImage = image {
            print("unwrapImage() = Pass!")
            return newImage
        }
        print("randomImage() = Failed--")
        errorAlert(message: "Couldn't unwrap images", in: controller)
        return nil
    }
    
    
    func errorAlert(message: String?, in view: UIViewController) {
        let alertController = UIAlertController(title: "Oops...", message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(OkAction)
        view.present(alertController, animated: true)
    }
    
}
