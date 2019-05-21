//
//  MainVC.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    var images = Images()
    var imageArray = [UIImage]()
    
    var gameImage = UIImage()

    
    @IBOutlet weak var gameHeading: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    
    
    
    
    @IBAction func randomPickPressed(_ sender: Any) {
        print("randomPick()")
       
        
        let randomImage = images.pullRandomImage(from: imageArray, in: self)
        
        gameImage = images.unwrap(image: randomImage, in: self)!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.performSegue(withIdentifier: "EditImageSegue", sender: self)
        }
        animateOffScreen()
        
    }
    
    @IBAction func selectPhotoPressed(_ sender: Any) {
        print("selectPhoto()")
        performSegue(withIdentifier: "EditImageSegue", sender: self)
    }
    
    @IBAction func takePhotoPressed(_ sender: Any) {
        print("takePhoto()")
        performSegue(withIdentifier: "EditImageSegue", sender: self)
    }
    
    
    @IBAction func displayResultsPressed(_ sender: Any) {
        print("displayResults()")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
         imageArray = images.collectLocalImages()
        
        animateHeading()
        // Do any additional setup after loading the view.
    }

    
    func animateHeading() {
        let viewBounds = self.view.bounds
        // drop into position
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
            // self.gameHeading.frame.origin = CGPoint(x: -viewBounds.width, y: 0)
             self.gameHeading.frame.origin = CGPoint(x: 0, y: viewBounds.height)
        }, completion: { (sucess) in
            // begin spring
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.gameHeading.frame = CGRect(x: self.gameHeading.frame.origin.x, y: self.gameHeading.frame.origin.y, width: self.gameHeading.bounds.width + 5, height: self.gameHeading.bounds.height + 5)
            }, completion: { (sucess) in
                // ending spring animation
               self.gameHeading.frame = CGRect(x: self.gameHeading.frame.origin.x, y: self.gameHeading.frame.origin.y, width: self.gameHeading.bounds.width - 5, height: self.gameHeading.bounds.height - 5)
            })
        })
      
    }
    
    
    func animateOffScreen() {
        
        // push header off screen
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.gameHeading.center.y -= self.view.bounds.height
           
        }, completion: { (sucess) in
                 self.gameHeading.alpha = 0
        })
        
        // send random button to the right
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.randomButton.center.x += self.view.bounds.width
            self.randomButton.frame.size = CGSize(width: 5, height: 5)
          //  self.view.layoutIfNeeded()
        })
        // send select photo button to the right
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
            self.selectPhotoButton.center.x += self.view.bounds.width
            self.selectPhotoButton.frame.size = CGSize(width: 5, height: 5)
        })
        // send camera button to the right
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
            self.cameraButton.center.x += self.view.bounds.width
            self.cameraButton.frame.size = CGSize(width: 5, height: 5)
        })
        // send results button to the right
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseIn, animations: {
            self.resultsButton.center.x += self.view.bounds.width
            self.resultsButton.frame.size = CGSize(width: 5, height: 5)
        })
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ImageEditingVC
        
       // nextVC.gameImage = images.pullRandomImage(from: imageArray, in: self)!
        nextVC.gameImage = gameImage
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


