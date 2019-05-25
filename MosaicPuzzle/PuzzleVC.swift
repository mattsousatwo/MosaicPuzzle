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
    let graph = Graph()
    var puzzleTiles = [UIImage]()
    var linesCount = Float()
    var gameImage = UIImage() 
    @IBOutlet weak var tileStack: UIStackView!
    @IBOutlet weak var puzzleGridIV: UIImageView!
    @IBOutlet weak var gameGrid: UIView!
    
    // present views on screen - not working
    func animateGameScreen() {
        tileStack.alpha = 0
        gameGrid.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.tileStack.alpha = 1
            self.gameGrid.alpha = 1
        })
    }
    
    
    func addTilesToStack() {
        
        let array = try? t.convert(imageArray: puzzleTiles, toSize: 54) 
        
        for tile in array! {
            
            tileStack.addArrangedSubview(tile)
        }
        print("the number of tiles in array are : \(array?.count ?? 999)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        puzzleGridIV.isUserInteractionEnabled = false
        tileStack.isUserInteractionEnabled = true
        addTilesToStack()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graph.draw(linesCount, linesIn: puzzleGridIV, gameImage: gameImage)
       
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
