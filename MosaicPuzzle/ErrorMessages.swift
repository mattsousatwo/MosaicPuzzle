//
//  ErrorMessages.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/22/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

enum ErrorMessages: Error {
    case missingTiles
    case noImage
    case misc(error: String)
}
