//
//  MainVC.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let animate = Animations()

    var images = Images()
    var imageArray = [UIImage]()
    
    var gameImage = UIImage()
    var buttonSize = CGSize()
    var buttonContainer = [UIButton?]()
    
    @IBOutlet weak var gameHeading: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    func goToNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.performSegue(withIdentifier: "EditImageSegue", sender: self)
        }
        // animate views off screen
        animate.buttons(buttonContainer, atSize: buttonSize, andHeading: gameHeading, offScreen: self.view)
    }
    
    @IBAction func randomPickPressed(_ sender: Any) {
        print("randomPick()")
        let randomImage = try? images.pullRandomImage(from: imageArray, in: self)
        gameImage = try! images.unwrap(image: randomImage, in: self)!
        // preform segue after a delay - to send over game image and to pause for animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.performSegue(withIdentifier: "EditImageSegue", sender: self)
        }
        // animate views off screen
        animate.buttons(buttonContainer, atSize: buttonSize, andHeading: gameHeading, offScreen: self.view)
    }
    
    @IBAction func selectPhotoPressed(_ sender: Any) {
        print("selectPhoto()")
       DispatchQueue.global(qos: .userInteractive).async {
           self.images.displayMediaLibrary(source: .photoLibrary, inView: self)
       }
   //     performSegue(withIdentifier: "EditImageSegue", sender: self)
    }
    
    @IBAction func takePhotoPressed(_ sender: Any) {
        print("takePhoto()")
        
        images.displayMediaLibrary(source: .camera, inView: self)
        
//        performSegue(withIdentifier: "EditImageSegue", sender: self)
    }
    
    
    @IBAction func displayResultsPressed(_ sender: Any) {
        print("displayResults()")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // collect buttons in array for animations
        buttonContainer = [randomButton, selectPhotoButton, cameraButton, resultsButton]
        // collect local images for random image selection
        imageArray = images.collectLocalImages()
        
        // Animate views on screen
        animate.buttons(buttonContainer, andHeading: gameHeading, onScreen: self.view)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // set button size
        buttonSize = randomButton.frame.size
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ImageEditingVC
        
       // nextVC.gameImage = images.pullRandomImage(from: imageArray, in: self)!
        nextVC.gameImage = gameImage
    }
    
    @IBAction func unwindToMainVC(segue: UIStoryboardSegue) { }

    // The user did pick a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("selected")
        
        picker.dismiss(animated: true, completion: { () in
    //        DispatchQueue.main.async {
                                // will bring over nextVC however back button is disabled 
    //           self.performSegue(withIdentifier: "EditImageSegue", sender: self)
            
 //           }
        })
        
        let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        guard let image = try? images.unwrap(image: newImage, in: self) else { return }
        
        gameImage = image

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    // will bring view over however slider can become delayed
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "ImageEditingVC") as! ImageEditingVC
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
          //  show window
            appDelegate.window?.rootViewController = view
        })
        
        
     //   self.performSegue(withIdentifier: "EditImageSegue", sender: self)
        
//        let topVC = topMostController()
//        let vcToPresent = self.storyboard!.instantiateViewController(withIdentifier: "ImageEditingVC") as! ImageEditingVC
//        topVC.present(vcToPresent, animated: true, completion: nil)
//
    }
    
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    

}


