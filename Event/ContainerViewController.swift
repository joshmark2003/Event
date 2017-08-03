//
//  ContainerViewController.swift
//  SainsburysPay
//
//  Created by Joshua Thompson on 18/07/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    private var storyboardManager: StoryboardManager?

    let notifier = Notifier()

    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        storyboardManager = StoryboardManager(containerView: containerView, initialViewController: childViewControllers.last)
        notifier.register(.moveToLogin, observer: self, selector: #selector(ContainerViewController.moveToLogin))
        notifier.register(.moveToHome, observer: self, selector: #selector(ContainerViewController.moveToHome))

        NotificationCenter.default.addObserver(self, selector: #selector(atApplicationLaunch), name: NSNotification.Name.UIApplicationDidFinishLaunching, object: nil)
    }

    func atApplicationLaunch() {
//        if LoginService.isUserLoggedIn() {
//            moveToHome()
//        } else {
            moveToLogin()
//        }
    }

    func moveToLogin() {
        let storyboard = UIStoryboard(name: "Registration", bundle: Bundle.main)
        storyboardManager?.transitionToStoryboard(storyboard, owner: self, animationDuration: 0.25)
    }

    func moveToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        storyboardManager?.transitionToStoryboard(storyboard, owner: self, animationDuration: 0.25)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
}
