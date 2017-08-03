//
//  TransitionFromFirstToSecond.swift
//  Event
//
//  Created by Joshua Thompson on 01/03/2016.
//  Copyright © 2016 Joshua Thompson. All rights reserved.
//

import UIKit

class TransitionFromEvent: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? EventsViewController else {
            return
        }
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? EventDetailViewController else {
            return
        }
        
        let containerView: UIView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        
        guard let cell = fromViewController.tableView.cellForRow(at: fromViewController.tableView.indexPathForSelectedRow!) as? EventTableViewCell else{
            return
        }
        
        guard let cellImageSnapshot = cell.eventImageView.snapshotView(afterScreenUpdates: false) else {
            return
        }
        
        cellImageSnapshot.frame = containerView.convert(cell.eventImageView.frame, from: cell.eventImageView.superview)
        cell.eventImageView.isHidden = true
        
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        toViewController.view.alpha = 0.0
        toViewController.eventImageView.isHidden = true
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(cellImageSnapshot)
        
        UIView.animate(withDuration: duration, animations: {
            
            toViewController.view.alpha = 1.0
            
            var imgFrame: CGRect = containerView.convert(toViewController.eventImageView.frame, from: toViewController.view)
            
            imgFrame.x = (toViewController.view.center.x - toViewController.eventImageView.frame.width/2)
            
            cellImageSnapshot.frame = imgFrame
            
            }, completion: {(finished: Bool) in
                
                toViewController.eventImageView.isHidden = false
                
                cellImageSnapshot.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
}

class TransitionToEvent: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? EventDetailViewController else {
            return
        }
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? EventsViewController else {
            return
        }
        
        let containerView: UIView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        
        guard let imgSnapshot: UIView = fromViewController.eventImageView.snapshotView(afterScreenUpdates: false) else {
            return
        }
        
        imgSnapshot.frame = containerView.convert(fromViewController.eventImageView.frame, from: fromViewController.eventImageView.superview)
        fromViewController.eventImageView.isHidden = true
        
        guard let cell = toViewController.tableView.cellForRow(at: toViewController.tableView.indexPathForSelectedRow!) as? EventTableViewCell else {
            return
        }
        
        cell.eventImageView.isHidden = true
        
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        containerView.addSubview(imgSnapshot)
        
        UIView.animate(withDuration: duration, animations: {
            
            fromViewController.view.alpha = 0.0
            
            let imgFrame: CGRect = containerView.convert(cell.eventImageView.frame, from: cell.eventImageView.superview)
            
            imgSnapshot.frame = imgFrame
            
            }, completion: {(finished: Bool) in
                
                imgSnapshot.removeFromSuperview()
                
                fromViewController.eventImageView.isHidden = false
                cell.eventImageView.isHidden = false
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
}
