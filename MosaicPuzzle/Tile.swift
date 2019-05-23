//
//  Tile.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/22/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

class Tile: UIImageView {
    
    var correctPosition = Int()
    var isInCorrectPosition = Bool()
    var s = String()
    
    
    override init(frame: CGRect) {
  
        super.init(frame: frame)
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
