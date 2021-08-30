//
//  UIButton+extensions.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 29/08/21.
//

import UIKit

extension UIButton {
    
    func roundCorners(with borderColor: UIColor, borderWidth: CGFloat = 1.0, cornerRadius: CGFloat = 16) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
}
