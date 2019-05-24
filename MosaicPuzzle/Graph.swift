//
//  Graph.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/23/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

struct Graph {
    
    func draw(_ numberOfLines: Double, linesIn imageView: UIImageView, gameImage: UIImage) {
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
                
                drawRect(in: imageView, using: gameImage, withBounds: imageView)
                
                ctx.cgContext.drawPath(using: .fillStroke)
                //ctx.cgContext.strokePath()
            })
            imageView.image = img1
        }

    
    func drawRect(in bounds: UIImageView, using gameImage: UIImage, withBounds parent: UIView) {
        
        let rendererOne = UIGraphicsImageRenderer(bounds: bounds.bounds)
        let img1 = rendererOne.image(actions: { ctx in
            
            if gameImage.isDark == true {
                ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
            } else {
                ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            }
            ctx.cgContext.setLineWidth(1)
        
        
        // create grid outline
        let rectangle = CGRect(x: 0, y: 0, width: parent.frame.width, height: parent.frame.height)
        ctx.cgContext.setFillColor(red: 0, green: 0, blue: 0, alpha: 0)
        ctx.cgContext.addRect(rectangle)
        
        ctx.cgContext.drawPath(using: .fillStroke)
            
        
        })
        bounds.image = img1
    }

    
    
}
