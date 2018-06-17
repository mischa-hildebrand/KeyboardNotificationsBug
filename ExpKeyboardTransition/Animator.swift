//
//  Animator.swift
//  ExpKeyboardTransition
//
//  Created by Mischa (Privat) on 6/17/18.
//  Copyright © 2018 Mischa Hildebrand. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("\n----- 🔮 Transition Animation BEGIN -----\n")
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        transitionContext.containerView.addSubview(toView)
        print("\n----- 🔮 Transition Animation added subview -----\n")
        toView.frame = transitionContext.containerView.bounds
        toView.layoutIfNeeded()
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
    
}
