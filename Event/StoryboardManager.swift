//
//  StoryboardManager.swift
//  SainsburysPay
//
//  Created by Furio Catalano on 05/04/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

enum SPTransitionType {
    case transitionFlipFromLeft
    case transitionFlipFromRight
    case transitionCurlUp
    case transitionCurlDown
    case transitionCrossDissolve
    case transitionFlipFromTop
    case transitionFlipFromBottom
    case transitionSlideFromBottom
    case transitionSlideFromTop
    case transitionSlideFromRight
}

class StoryboardManager {
    private weak var containerView: UIView!
    private(set) weak var currentlyEmbeddedVC: UIViewController?

    init(containerView: UIView, initialViewController: UIViewController?) {
        self.containerView = containerView
        self.currentlyEmbeddedVC = initialViewController
    }

    deinit {
        containerView = nil
        currentlyEmbeddedVC = nil
    }

    func transitionToStoryboard(_ storyboard: UIStoryboard, owner: ContainerViewController, animationDuration: TimeInterval, additionalViewControllersStack: [String] = [], animationType: SPTransitionType = .transitionCrossDissolve) {
        guard let newController = storyboard.instantiateInitialViewController() else {
            return
        }

        if let navController = newController as? UINavigationController {
//            navController.delegate = owner
//            if let baseViewController = navController.viewControllers.first as? BaseViewController {
//                baseViewController.controllerParameters = owner.controllerParameters
//            }
            if additionalViewControllersStack.count > 0 {
                var viewControllers = navController.viewControllers
                for vcName in additionalViewControllersStack {
                    let vc = storyboard.instantiateViewController(withIdentifier: vcName)
//                    if let baseViewController = vc as? ContainerViewController {
//                        baseViewController.controllerParameters = owner.controllerParameters
//                    }
                    viewControllers.append(vc)
                }
                navController.setViewControllers(viewControllers, animated: false)
            }
        }

        transitionToViewController(newController, owner: owner, animationDuration: animationDuration, animationType: animationType)
    }

    func transitionToViewController(_ newController: UIViewController, owner: ContainerViewController, animationDuration: TimeInterval, animationType: SPTransitionType = .transitionCrossDissolve) {

        guard let currentlyEmbeddedVC = currentlyEmbeddedVC, currentlyEmbeddedVC != newController else {
            return
        }

        currentlyEmbeddedVC.willMove(toParentViewController: nil)
        owner.addChildViewController(newController)

        let finalFrame = createContainerFrame()
        let (options, initialFrame) = getOptionsAndInitialFrame(finalFrame: finalFrame, animationType: animationType)

        newController.view.frame = initialFrame

        if let navController = newController as? UINavigationController {
            owner.view.backgroundColor = navController.viewControllers.first?.view.backgroundColor
        } else {
            owner.view.backgroundColor = newController.view.backgroundColor
        }

        owner.transition(
            from: currentlyEmbeddedVC,
            to: newController,
            duration: animationDuration,
            options: options,
            animations: {
                newController.view.frame = finalFrame
            },
            completion: { finished in
                self.currentlyEmbeddedVC?.removeFromParentViewController()
                newController.didMove(toParentViewController: owner)
                self.currentlyEmbeddedVC = newController
            })
    }

    private func getOptionsAndInitialFrame(finalFrame: CGRect, animationType: SPTransitionType) -> (UIViewAnimationOptions, CGRect) {
        var options: UIViewAnimationOptions = []
        var initialFrame = finalFrame

        switch animationType {
        case .transitionFlipFromLeft:
            options = [.allowAnimatedContent, .transitionFlipFromLeft]
        case .transitionFlipFromRight:
            options = [.allowAnimatedContent, .transitionFlipFromRight]
        case .transitionCurlUp:
            options = [.allowAnimatedContent, .transitionCurlUp]
        case .transitionCurlDown:
            options = [.allowAnimatedContent, .transitionCurlDown]
        case .transitionCrossDissolve:
            options = [.allowAnimatedContent, .transitionCrossDissolve]
        case .transitionFlipFromTop:
            options = [.allowAnimatedContent, .transitionFlipFromTop]
        case .transitionFlipFromBottom:
            options = [.allowAnimatedContent, .transitionFlipFromBottom]
        case .transitionSlideFromBottom:
            initialFrame = CGRect(x: finalFrame.origin.x, y: finalFrame.origin.y + finalFrame.size.height, width: finalFrame.size.width, height: finalFrame.size.height)
            options = [.allowAnimatedContent, .curveEaseOut, .preferredFramesPerSecond60, .transitionCrossDissolve]
        case .transitionSlideFromTop:
            initialFrame = CGRect(x: finalFrame.origin.x, y: finalFrame.origin.y - finalFrame.size.height, width: finalFrame.size.width, height: finalFrame.size.height)
            options = [.allowAnimatedContent, .curveEaseOut, .preferredFramesPerSecond60, .transitionCrossDissolve]
        case .transitionSlideFromRight:
            initialFrame = CGRect(x: finalFrame.origin.x + finalFrame.size.width, y: finalFrame.origin.y, width: finalFrame.size.width, height: finalFrame.size.height)
            options = [.allowAnimatedContent, .curveEaseOut, .preferredFramesPerSecond60, .transitionCrossDissolve]
        }

        return (options, initialFrame)
    }

    private func createContainerFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
    }
}
