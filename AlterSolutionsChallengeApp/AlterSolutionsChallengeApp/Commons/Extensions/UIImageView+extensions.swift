//
//  UIImageView+extensions.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 30/08/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    func addCrossFadeAnimation(_ image: UIImage?) {
        let crossFade = CABasicAnimation(keyPath: "contents")
        
        crossFade.duration = 1.0
        crossFade.fromValue = UIImage.photoPlaceHolder?.cgImage
        crossFade.toValue = image?.cgImage
        
        layer.add(crossFade, forKey: "animateContents")
        
        self.image = image
    }
    
    func removeCrossFadeAnimation() {
        layer.removeAnimation(forKey: "animateContents")
    }
    
    func addBorder(_ borderColor: UIColor = .black, borderWidth: CGFloat = 0.5) {
        clipsToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    
}
