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

    var titleColor: UIColor = .black {
        didSet {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: titleColor]
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: titleColor]
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        titleColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        view.backgroundColor = traitCollection.userInterfaceStyle == .light ? UIColor.white : UIColor.black

        if let customLeftButton = navigationItem.leftBarButtonItem?.customView {
            customLeftButton.tintColor = titleColor
        }

        if let customRightButton = navigationItem.rightBarButtonItem?.customView {
            customRightButton.tintColor = titleColor
        }

        navigationController?.navigationBar.tintColor = titleColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        view.backgroundColor = traitCollection.userInterfaceStyle == .light ? UIColor.white : UIColor.black
        navigationController?.navigationBar.tintColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
    }

    // MARK: - Customization methods
    
    func addCustomNavigationButton(on position: CustomButtonPosition, icon: CustomButtonIcon, tintColor: UIColor, action: CustomButtonActionDelegate? = nil) {
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
