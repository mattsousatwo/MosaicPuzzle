//
//  ImageEditingVC.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class ImageEditingVC: UIViewController, UIGestureRecognizerDelegate {
    
    let images = Images()
    let capture = ImageCapture()
    let creation = TileCreation()
    let graph = Graph()
    
    var gameImage = UIImage()
    var screenshot = UIImage()
    var tileArray = [UIImage]()
    
    @IBOutlet weak var imageViewBG: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gridLineIV: UIImageView!
    
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var sliderValueDisplay: UILabel!
    @IBOutlet weak var refreshButton: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var backButton: UIImageView!
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        screenshot = capture.takeImage(of: imageViewBG)
        
        let roundedValue = round(sliderView.value)
        let sliderInputValue = Int(roundedValue)
        tileArray = creation.createTiles(sliderInputValue, from: screenshot)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.performSegue(withIdentifier: "EditingToPuzzleSegue", sender: self)
        }
        
    }
    
    // Set Slider Value Label to the square of the value of the slider
    func squareSliderValue( ) {
        let numberOfCells = round(sliderView.value) * round(sliderView.value)
        sliderValueDisplay.text = String(format: "%g", numberOfCells)
    }
    
    
    
    func configureViewOrder() {
        imageView.image = gameImage
        imageViewBG.sendSubviewToBack(imageView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderView.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        
        configureViewOrder()
        
        
        
        squareSliderValue()
        
        addGestures() 
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawLines()
    }
    
    var numberOfLines: Float = 2
    
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        print(sliderView.value)
        
        numberOfLines = sliderView.value
        
        squareSliderValue()
        
        drawLines()
    }
    
    
    
    func drawLines() {
        let start: Int = 1
        let end = round(numberOfLines)
        
        let imgViewBounds = gridLineIV.bounds
    
        
        let rendererOne = UIGraphicsImageRenderer(bounds: gridLineIV.bounds)
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
            
            // create grid outline
            let rectangle = CGRect(x: 0, y: 0, width: gridLineIV.frame.width, height: gridLineIV.frame.height)
            ctx.cgContext.setFillColor(red: 0, green: 0, blue: 0, alpha: 0)
            ctx.cgContext.addRect(rectangle)
            
            ctx.cgContext.drawPath(using: .fillStroke)
            //ctx.cgContext.strokePath()
        })
        gridLineIV.image = img1
    }

    
    // :: Gestures ::
    func addGestures() {
        gridLineIV.isUserInteractionEnabled = false
        imageView.isUserInteractionEnabled = true
        refreshButton.isUserInteractionEnabled = true
        backButton.isUserInteractionEnabled = true
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panImage(_:)))
        imageView.addGestureRecognizer(panRecognizer)
        panRecognizer.delegate = self
        
        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotateImage(_:)))
        imageView.addGestureRecognizer(rotateRecognizer)
        rotateRecognizer.delegate = self
        
        let scaleRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(scaleImage(_:)))
       imageView.addGestureRecognizer(scaleRecognizer)
       scaleRecognizer.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(refresh(_:)))
        refreshButton.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self

        let backTap = UITapGestureRecognizer(target: self, action: #selector(goBackPressed(_:)))
        backButton.addGestureRecognizer(backTap)
        backTap.delegate = self 
        
    }
    
    var initalImageOffset = CGPoint()
    
    @objc func panImage(_ sender: UIPanGestureRecognizer ) {
        print("moving image...")
        
        let translation = sender.translation(in: imageView)
        
        if sender.state == .began {
            initalImageOffset = imageView.frame.origin
        }
        
        let position = CGPoint(x: translation.x + initalImageOffset.x - imageView.frame.origin.x, y: translation.y + initalImageOffset.y - imageView.frame.origin.y)
        imageView.transform = imageView.transform.translatedBy(x: position.x, y: position.y)
        

    }
    
  
    @objc func rotateImage(_ sender: UIRotationGestureRecognizer) {
        print("rotate image...")
        
        imageView.transform = imageView.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    @objc func scaleImage(_ sender: UIPinchGestureRecognizer) {
        print("scale image...")
        imageView.transform = imageView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
  
    @objc func goBackPressed(_ sender: UITapGestureRecognizer) {
        print("go back")
        
        performSegue(withIdentifier: "goToMainVC", sender: self)
        
    }
    
    
    @objc func refresh(_ sender: UITapGestureRecognizer) {
        print("refresh")
        // reset position, scale/size, rotation
        imageView.transform = CGAffineTransform.identity
    }
    
    // recognize multiple gestures
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer.view != imageView {
            return false
        }
        
        if gestureRecognizer is UITapGestureRecognizer || otherGestureRecognizer is UITapGestureRecognizer || gestureRecognizer is UIPanGestureRecognizer || otherGestureRecognizer is UIPanGestureRecognizer {
            return false
        }
        
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "EditingToPuzzleSegue":
            let puzzleVC = segue.destination as! PuzzleVC
            puzzleVC.puzzleTiles = tileArray
        case "goToMainVC":
            
            print("Working!")
        default:
           
            break
        }
     
    }
    
    
    
 
} // <---  End Of Class


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
