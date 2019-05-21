//
//  ImageEditingVC.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class ImageEditingVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var sliderValueDisplay: UILabel!
    
    
    // create variables of image height - width
    // test getting multiple lines across the screen 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderView.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        
        drawLines()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    var numberOfLines: Float = 3
    
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        print(sliderView.value)
        
        numberOfLines = sliderView.value
        
        let numberOfCells = round(sliderView.value) * round(sliderView.value)
        sliderValueDisplay.text = "\(numberOfCells)"
        
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
            
           
            for number in start...Int(end) {
                let xValue = imgViewBounds.width / CGFloat(end)
            
                // beginging
            ctx.cgContext.move(to: CGPoint(x: (Int(imgViewBounds.width / CGFloat(end)) * number ), y: 0))
                // end point
            ctx.cgContext.addLine(to: CGPoint(x: xValue * CGFloat(number), y: imgViewBounds.height))
                // Original
                // ctx.cgContext.move(to: CGPoint(x: (10 * number), y: 10))
                // ctx.cgContext.addLine(to: CGPoint(x: CGFloat(10 * number), y: imgViewBounds.height))
            }
    
            
            for number in start...Int(end) {
                let yValue = imgViewBounds.height / CGFloat(end)
                
                // beginging
                ctx.cgContext.move(to: CGPoint(x: 0, y:  (Int(imgViewBounds.height / CGFloat(end)) * number) ))
                // end point
                ctx.cgContext.addLine(to: CGPoint(x: imgViewBounds.width, y: yValue * CGFloat(number)))
                // Original
                // ctx.cgContext.move(to: CGPoint(x: (10 * number), y: 10))
                // ctx.cgContext.addLine(to: CGPoint(x: CGFloat(10 * number), y: imgViewBounds.height))
            }
            
            
            
            ctx.cgContext.drawPath(using: .fillStroke)
            //ctx.cgContext.strokePath()
        })
        imageView.image = img1
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
