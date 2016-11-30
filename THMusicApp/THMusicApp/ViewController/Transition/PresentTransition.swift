//
//  PresentTransition.swift
//  THMusicApp
//
//  Created by Hai on 11/29/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit

class PresentTransition : NSObject, UIViewControllerAnimatedTransitioning {
    var fromImage : UIImageView?
    var toImage : UIImageView?
    var index : IndexPath?
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! ViewController
        let toVC = transitionContext.viewController(forKey: .to) as! SongViewController
        toVC.view.alpha = 0.5
        let container = transitionContext.containerView
        container.addSubview((fromVC.view)!)
        container.addSubview((toVC.view)!)
        
        UIView.animate(withDuration: 5, animations: {
            toVC.view.alpha = 1
            }) { (compelete) in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }
}
