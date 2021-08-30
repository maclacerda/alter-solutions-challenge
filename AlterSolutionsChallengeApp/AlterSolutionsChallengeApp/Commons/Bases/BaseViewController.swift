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
        
        let barButton = UIBarButtonItem(customView: customButon)
        
        switch position {
        case .left: navigationItem.setLeftBarButton(barButton, animated: true)
        case .right: navigationItem.setRightBarButton(barButton, animated: true)
        }
    }
    
    // MARK: - Messages
    
//    func showQuestion(_ title: String = "Atenção", message: String, handler: ((UIAlertAction) -> Void)? = nil) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let yesAction = UIAlertAction(title: "Sim", style: .destructive, handler: handler)
//        let noAction = UIAlertAction(title: "Não", style: .cancel, handler: nil)
//
//        alertController.addAction(yesAction)
//        alertController.addAction(noAction)
//
//        if let navigationController = self.navigationController {
//            navigationController.present(alertController, animated: true, completion: nil)
//        } else {
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//    func showError(_ message: String, _ field: UITextField?) {
//        MessagesHelper.shared.show(with: "Ops!", message: message, type: .error, handler: {
//            DispatchQueue.main.async {
//                field?.becomeFirstResponder()
//            }
//        })
//    }
    
}
