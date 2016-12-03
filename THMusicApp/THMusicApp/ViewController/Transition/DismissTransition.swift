//
//  DismissTransition.swift
//  THMusicApp
//
//  Created by Hai on 12/1/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit

class DismissTransition : NSObject, UIViewControllerAnimatedTransitioning {
    
    var index : Int?
    let numberOfGenre = [2,3,4,5,6,7,9,10,11,12,14,15,16,17,18,19,20,21,22,24,34,50,51]
    var position : CGPoint?
    var size : CGSize?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        toVC?.view.alpha = 0
        
        let container = transitionContext.containerView
        container.addSubview((toVC?.view)!)
        container.addSubview((fromVC?.view)!)
        
        print("index", self.index)
        let fromImage = UIImageView()
        let imageFormat = "genre-\(self.numberOfGenre[index!])@2x.png.png"
        fromImage.image = UIImage(named: imageFormat)
        fromImage.frame.size = CGSize(width: (fromVC?.view.frame.height)!/7 - 10, height: (fromVC?.view.frame.height)!/7 - 10)
        fromImage.frame.origin.x = 8
        fromImage.frame.origin.y = 25
        
        container.addSubview(fromImage)
        
        print("211", fromImage.frame.size)
        
        UIView.animate(withDuration: 0.5, animations: {
            fromImage.frame.size = self.size!
            fromImage.frame.origin.x = (self.position?.x)!
            fromImage.frame.origin.y = (self.position?.y)!
            fromVC?.view.alpha = 0
            toVC?.view.alpha = 1
            
            }) { (compelete) in
                fromVC?.view.removeFromSuperview()
                transitionContext.completeTransition(true)
        }

    }
    
    
}
