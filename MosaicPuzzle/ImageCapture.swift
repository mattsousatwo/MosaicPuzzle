//
//  ImageCapture.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/21/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

struct ImageCapture {
    
    // Take a screenshot of the contents of a specified UIView
    func takeImage(of view: UIView ) -> UIImage {
        print("~[Capture Image]~")
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return screenshot
    }
    
    
}
