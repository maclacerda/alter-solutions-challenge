//
//  BaseViewController.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 28/08/21.
//

import UIKit

enum CustomButtonPosition {
    case left
    case right
}

enum CustomButtonIcon {
    case favorites
    case list
}

protocol CustomButtonActionDelegate: AnyObject {
    func didTapCustomNavigationButton()
}

class BaseViewController: UIViewController {
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            guard let navigationController = self.navigationController as? BaseNavigationViewController else { return }
            navigationController.statusBarStyle = statusBarStyle
        }
    }
    
    var navigationBarTintColor: UIColor = .black {
        didSet {
            navigationController?.navigationBar.barTintColor = navigationBarTintColor
        }
    }
    
    // MARK: - Customization methods
    
    func addCustomNavigationButton(on position: CustomButtonPosition, icon: CustomButtonIcon, tintColor: UIColor = .black, action: CustomButtonActionDelegate? = nil) {
        var imageName: String
        
        switch icon {
        case .list: imageName = "star"
        case .favorites: imageName = "star.fill"
        }
        
        let customButon = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
            action?.didTapCustomNavigationButton()
        }))
        
        customButon.setImage(UIImage(systemName: imageName), for: .normal)
        customButon.tintColor = tintColor
        customButon.accessibilityIdentifier = "favorites"
        customButon.isSelected = icon == .favorites
        
        let barButton = UIBarButtonItem(customView: customButon)

        switch position {
        case .left: navigationItem.setLeftBarButton(barButton, animated: true)
        case .right: navigationItem.setRightBarButton(barButton, animated: true)
        }
    }

}
