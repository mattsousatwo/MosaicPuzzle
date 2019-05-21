//
//  PuzzleVC.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/20/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class PuzzleVC: UIViewController {

    var puzzleTiles = [UIImage]()
    
    @IBOutlet weak var tileStack: UIStackView!
    
  
    
    func addTilesToStack() {
        for image in puzzleTiles {
            let closureView: UIImageView = { () -> UIImageView in
                let view = UIImageView()
                view.image = image
                return view
            }()
            
            tileStack.addArrangedSubview(closureView)
        }
        print(puzzleTiles.count)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tileStack.isUserInteractionEnabled = true
        addTilesToStack()
    }
    

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
       
        
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
