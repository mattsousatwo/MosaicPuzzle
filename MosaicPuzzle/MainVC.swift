//
//  MainVC.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBAction func randomPickPressed(_ sender: Any) {
        print("randomPick()")
        performSegue(withIdentifier: "EditImageSegue", sender: self)
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
        
        
        // Do any additional setup after loading the view.
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
