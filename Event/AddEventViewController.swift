//
//  AddEventViewController.swift
//  Event
//
//  Created by Joshua Thompson on 19/07/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewContraint: NSLayoutConstraint!
    @IBOutlet weak var eventCodeTextField: UITextField!
    @IBOutlet weak var eventPasswordField: UITextField!
    @IBOutlet weak var submitButton: SpinnerButton!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        roundCorner(view: eventCodeTextField)
        roundCorner(view: eventPasswordField)
        roundCorner(view: containerView)

        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 3.0).cgPath
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 10.0
        
        blurView.alpha = 0.0
        
        hideContainerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.blurView.alpha = 1.0
            
        }) { (finished: Bool) in
            self.showContainerView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showContainerView() {
        
        containerViewContraint.constant = 0
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseInOut,
                       animations: {
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func hideContainerView() {
        
        containerViewContraint.constant = (view.frame.height/2) + (containerView.frame.height/2)
    }
    
    func roundCorner(view: UIView) {
        view.layer.cornerRadius = 3.0
    }
    
    //MARK: - Action Events
    
    @IBAction func closeButtonPressed() {
        
        hideContainerView()
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { (finished: Bool) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func submitButtonPressed() {
        
        submitButton.animate(1.0) { 
            self.closeButtonPressed()
        }
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
