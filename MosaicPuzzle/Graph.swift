//
//  Graph.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/23/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

struct Graph {
    
    func draw(_ numberOfLines: Float, linesIn imageView: UIImageView, gameImage: UIImage) {
            let start: Int = 1
            let end = round(numberOfLines) 
            
            let imgViewBounds = imageView.bounds
            
            let rendererOne = UIGraphicsImageRenderer(bounds: imageView.bounds)
            let img1 = rendererOne.image(actions: { ctx in
                
                if gameImage.isDark == true {
                    ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
                } else {
                    ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
                }
                ctx.cgContext.setLineWidth(1)
                
                // Draw X lines (up, down)
                for number in start...Int(end) {
                    let xValue = imgViewBounds.width / CGFloat(end)
                    
                    // begining xValue * CGFloat(number)
                    ctx.cgContext.move(to: CGPoint(x: xValue * CGFloat(number) , y: 0))
                    // end point
                    ctx.cgContext.addLine(to: CGPoint(x: (imgViewBounds.width / CGFloat(end)) * CGFloat(number) , y: imgViewBounds.height))
                }
                
                // Draw Y lines (left, right)
                for number in start...Int(end) {
                    let yValue = imgViewBounds.height / CGFloat(end)
                    
                    // begining
                    ctx.cgContext.move(to: CGPoint(x: 0, y: yValue * CGFloat(number))  )
                    // end point    - (imgViewBounds.height / CGFloat(end)) * CGFloat(number))
                    ctx.cgContext.addLine(to: CGPoint(x: imgViewBounds.width, y: (imgViewBounds.height / CGFloat(end)) * CGFloat(number)) )
                }
                
                // Draw outside line for top
                ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
                ctx.cgContext.addLine(to: CGPoint(x: 0, y: imageView.bounds.maxY))
                // Draw outside line for left side
                ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
                ctx.cgContext.addLine(to: CGPoint(x: imageView.bounds.maxX, y: 0))
                
                ctx.cgContext.drawPath(using: .fillStroke)
                //ctx.cgContext.strokePath()
            })
            imageView.image = img1
        }

    
    func drawRect(in bounds: UIImageView, using gameImage: UIImage) {
        
        let rendererOne = UIGraphicsImageRenderer(bounds: bounds.bounds)
        let img1 = rendererOne.image(actions: { ctx in
            
            if gameImage.isDark == true {
                ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
            } else {
                ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            }
            ctx.cgContext.setLineWidth(1)
        
        
        // create grid outline
        let rectangle = CGRect(x: 0, y: 0, width: bounds.frame.width, height: bounds.frame.height)
        ctx.cgContext.setFillColor(red: 0, green: 0, blue: 0, alpha: 0)
        ctx.cgContext.addRect(rectangle)
        
        ctx.cgContext.drawPath(using: .fillStroke)
            
        
        })
        bounds.image = img1
    }

    
    
}

// Extention to create property to check if Image is mostly Black or mostly White
extension CGImage {
    var isDark: Bool {
        get {
            guard let imageData = self.dataProvider?.data else { return false }
            guard let ptr = CFDataGetBytePtr(imageData) else { return false }
            let length = CFDataGetLength(imageData)
            let threshold = Int(Double(self.width * self.height) * 0.45)
            var darkPixels = 0
            for i in stride(from: 0, to: length, by: 4) {
                let r = ptr[i]
                let g = ptr[i + 1]
                let b = ptr[i + 2]
                let luminance = (0.299 * Double(r) + 0.587 * Double(g) + 0.114 * Double(b))
                if luminance < 150 {
                    darkPixels += 1
                    if darkPixels > threshold {
                        return true
                    }
                }
            }
            return false
        }
    }
}

extension UIImage {
    var isDark: Bool { 
        get {
            return self.cgImage?.isDark ?? false
        }
    }
}
