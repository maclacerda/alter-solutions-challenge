//
//  BaseNavigationViewController.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 28/08/21.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return statusBarStyle }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .fade }
    
}
