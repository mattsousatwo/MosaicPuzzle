//
//  ImageEditingVC.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class ImageEditingVC: UIViewController {
    
    
    var gameImage = UIImage()

    
    @IBOutlet weak var imageViewBG: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gridLineIV: UIImageView!
    
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var sliderValueDisplay: UILabel!
    
    
    // create variables of image height - width
    // test getting multiple lines across the screen 
    
    func configureViewOrder() {
        imageView.image = gameImage
        imageViewBG.sendSubviewToBack(imageView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderView.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        
        configureViewOrder()
        sliderValueDisplay.text = "0"
        // Do any additional setup after loading the view.
    }
    
    var numberOfLines: Float = 3
    
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        print(sliderView.value)
        
        numberOfLines = sliderView.value
        
        let numberOfCells = round(sliderView.value) * round(sliderView.value)
        sliderValueDisplay.text = String(format: "%g", numberOfCells)
        
        drawLines()
    }
    
    
    
    func drawLines() {
        let start: Int = 1
        let end = round(numberOfLines)
        
        let imgViewBounds = imageView.bounds
    
        
        let rendererOne = UIGraphicsImageRenderer(bounds: imageView.bounds)
        let img1 = rendererOne.image(actions: { ctx in
            
            ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
            ctx.cgContext.setLineWidth(1)
            
            // Lines appear to be slightly angled at higher number of cells
            // Draw X lines (up, down)
            for number in start...Int(end) {
                let xValue = imgViewBounds.width / CGFloat(end)
            
                // beginging xValue * CGFloat(number)
            ctx.cgContext.move(to: CGPoint(x: xValue * CGFloat(number) , y: 0))
                // end point
            ctx.cgContext.addLine(to: CGPoint(x: (imgViewBounds.width / CGFloat(end)) * CGFloat(number) , y: imgViewBounds.height))
                // Original
                // ctx.cgContext.move(to: CGPoint(x: (10 * number), y: 10))
                // ctx.cgContext.addLine(to: CGPoint(x: CGFloat(10 * number), y: imgViewBounds.height))
            }
    
            // Draw Y lines (left, right)
            for number in start...Int(end) {
                let yValue = imgViewBounds.height / CGFloat(end)
                
                // beginging
                ctx.cgContext.move(to: CGPoint(x: 0, y: yValue * CGFloat(number))  )
                // end point    - (imgViewBounds.height / CGFloat(end)) * CGFloat(number))
                ctx.cgContext.addLine(to: CGPoint(x: imgViewBounds.width, y: (imgViewBounds.height / CGFloat(end)) * CGFloat(number)) )
            }
            
            
            
            ctx.cgContext.drawPath(using: .fillStroke)
            //ctx.cgContext.strokePath()
        })
        gridLineIV.image = img1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
