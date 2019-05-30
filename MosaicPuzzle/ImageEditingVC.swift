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
    var numberOfLines: Float = 2
    
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
    
    // update view order so that the game image is first
    func configureViewOrder() {
        imageView.image = gameImage
        // -  not sure if i need this line -
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
        graph.draw(numberOfLines, linesIn: gridLineIV, gameImage: gameImage)
    }
    
    // Action for slider - change number of lines in grid / update value display
    @objc func sliderValueChanged(_ sender: UISlider) {
        print(sliderView.value)
        
        numberOfLines = sliderView.value
        
        squareSliderValue()
        
        graph.draw(numberOfLines, linesIn: gridLineIV, gameImage: gameImage)
        
        
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //  show window
        appDelegate.window?.rootViewController = view
 //       performSegue(withIdentifier: "goToMainVC", sender: self)
        
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
            puzzleVC.linesCount = numberOfLines
            puzzleVC.gameImage = gameImage
            
            
        case "goToMainVC":
            
            print("Working!")
        default:
           
            break
        }
     
    }
    
    
    
 
} // <---  End Of Class


