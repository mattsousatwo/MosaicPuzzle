//
//  PuzzleVC.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class PuzzleVC: UIViewController {
    
    let t = TileCreation()
    var puzzleTiles = [UIImage]()
    
    @IBOutlet weak var tileStack: UIStackView!
    
  
    
    func addTilesToStack() {
        
        let array = try? t.convert(imageArray: puzzleTiles, toSize: 54) 
        
        for tile in array! {
            
            tileStack.addArrangedSubview(tile)
        }
        print("the number of tiles in array are : \(array?.count ?? 999)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tileStack.isUserInteractionEnabled = true
        addTilesToStack()
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
