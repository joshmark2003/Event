//
//  EventDetailViewController.swift
//  Event
//
//  Created by Joshua Thompson on 26/07/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, UINavigationControllerDelegate {

    //MARK: - IBOutlet
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    var interactivePopTransition: UIPercentDrivenInteractiveTransition!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let popRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePopRecognizer(recognizer:)))
        
        view.addGestureRecognizer(popRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController!.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop being the navigation controller's delegate
        
        navigationController!.delegate = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UIGestureRecognizer handlers
    
    func handlePopRecognizer(recognizer: UIPanGestureRecognizer) {
        
        var progress = recognizer.translation(in: view).x / (view.bounds.width * 1.0) as CGFloat
        
        progress = min(1.0, max(0.0, progress))
        
        if recognizer.state == UIGestureRecognizerState.began {
            
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewController(animated: true)
            
        } else if recognizer.state == UIGestureRecognizerState.changed {
            
            interactivePopTransition.update(progress)
            
        } else if recognizer.state == UIGestureRecognizerState.ended || recognizer.state == UIGestureRecognizerState.cancelled {
            
            if (progress > 0.5) {
                
                interactivePopTransition.finish()
                
            } else {
                
                interactivePopTransition.cancel()
            }
            
            interactivePopTransition = nil
        }
    }
    
    //MARK: - UINavigationControllerDelegate methods
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // Check if we're transitioning from this view controller to a DSLSecondViewController
        if fromVC == self && toVC.isKind(of: EventsViewController.self) {
            
            return TransitionToEvent()
        } else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if animationController.isKind(of: TransitionToEvent.self) {
            return interactivePopTransition
        } else {
            return nil
        }
    }

}
