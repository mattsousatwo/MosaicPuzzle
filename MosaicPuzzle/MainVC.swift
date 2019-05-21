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
    
    @IBAction func randomPickPressed(_ sender: Any) {
        print("randomPick()")
        performSegue(withIdentifier: "EditImageSegue", sender: self)
        
        let randomImage = images.pullRandomImage(from: imageArray, in: self)
        
        gameImage = images.unwrap(image: randomImage, in: self)!
        
        
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
        
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ImageEditingVC
        
        nextVC.gameImage = images.pullRandomImage(from: imageArray, in: self)!
        
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
