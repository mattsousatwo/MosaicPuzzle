//
//  Animations.swift
//  MosaicPuzzle
//
//  Created by Matthew Sousa on 5/25/19.
//  Copyright © 2019 mattsousa. All rights reserved.
//

import UIKit

struct Animations {
    
    // animate main view heading on screen
    func animate(heading: UILabel, in view: UIView) {
        let viewBounds = view.bounds
        // drop into position
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
            // self.gameHeading.frame.origin = CGPoint(x: -viewBounds.width, y: 0)
            heading.frame.origin = CGPoint(x: 0, y: viewBounds.height)
        }, completion: { (sucess) in
            // begin spring
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                heading.frame = CGRect(x: heading.frame.origin.x, y: heading.frame.origin.y, width: heading.bounds.width + 5, height: heading.bounds.height + 5)
            }, completion: { (sucess) in
                // ending spring animation
                heading.frame = CGRect(x: heading.frame.origin.x, y: heading.frame.origin.y, width: heading.bounds.width - 5, height: heading.bounds.height - 5)
            })
        })
        
    }
    
    // Animate views on screen
    func buttons(_ buttons: [UIButton?], andHeading heading: UILabel, onScreen view: UIView) {
        self.animate(heading: heading, in: view)
        let duration = 0.3
        var delay = 0.0
        
        for button in buttons {
            guard let b = button else { return }
            
            // send random button to the right
            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
                b.center.x -= view.bounds.width
                
                //  self.view.layoutIfNeeded()
            })
            delay += 0.1
        }
        delay = 0.0
    }
    
    // animate views off screen
    func buttons(_ buttons: [UIButton?], atSize size: CGSize, andHeading heading: UILabel, offScreen view: UIView) {
        
        let duration = 0.2
        var delay = 0.0
        // push header off screen
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
            heading.center.y -= view.bounds.height
            
        }, completion: { (sucess) in
            heading.alpha = 0
        })
        
        for button in buttons {
            guard let b = button else { return }
            
            // send random button to the right
            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
                b.center.x += view.bounds.width
                b.frame.size = CGSize(width: 5, height: 5)
                //  self.view.layoutIfNeeded()
            })
            delay += 0.1
        }
        self.buttons(buttons, atSize: size, andHeading: heading, backOnScreen: view)
        delay = 0.0
    }
    
    // Bring views back on screen
    func buttons(_ buttons: [UIButton?], atSize buttonSize: CGSize, andHeading heading: UILabel, backOnScreen view: UIView) {
        let delay = 0.7
        // push header off screen
        UIView.animate(withDuration: 0.0, delay: delay, options: .curveEaseIn, animations: {
            heading.center.y += view.bounds.height
            
        }, completion: { (sucess) in
            heading.alpha = 1
        })
        
        for button in buttons {
            guard let b = button else { return }
            
            // send random button to the right
            UIView.animate(withDuration: 0.0, delay: delay, options: .curveEaseIn, animations: {
                b.center.x -= view.bounds.width
                b.frame.size = buttonSize
                //  self.view.layoutIfNeeded()
            })
            
        }
    }
    
    
    
    
}
