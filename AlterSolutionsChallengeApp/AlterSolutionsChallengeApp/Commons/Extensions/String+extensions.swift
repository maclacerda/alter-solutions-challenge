//
//  String+extensions.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 29/08/21.
//

import Foundation
import AlterSolutionsChallengeCore

import UIKit

enum PositionTextFormat {
    case before
    case after
}

extension String {
    
    func makeAvatarURL() -> String {
        SecurityManager.shared.salt = Constants.salt
        
        do {
            let baseURL = try SecurityManager.shared.reveal(Constants.baseAvatarURL)
            return String(format: baseURL, self)
        } catch {
            return ""
        }
    }
    
    func extractPokemonIdentifier() -> String {
        let pathToExtract = String(self.dropLast())
        
        guard let index = pathToExtract.lastIndex(of: "/") else {
            return "0"
        }
        
        let identifier = String(pathToExtract.suffix(from: index).dropFirst())

        return identifier
    }
    
    func makeBoldText(separator: String, position: PositionTextFormat) -> NSAttributedString? {
        guard let separatorIndex = self.range(of: separator) else {
            return nil
        }
        
        var boldText: String
        var regularText: String
        
        switch position {
        case .before:
            boldText = String(self.prefix(upTo: separatorIndex.upperBound))
            regularText = String(self.suffix(from: separatorIndex.upperBound))
            
        case .after:
            boldText = String(self.suffix(from: separatorIndex.upperBound))
            regularText = String(self.prefix(upTo: separatorIndex.upperBound))
        }
        
        let attributedString = NSMutableAttributedString(string: boldText,
                                                         attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        )
        
        let normalString = NSMutableAttributedString(string: regularText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])

        attributedString.append(normalString)

        return attributedString
    }

    func adjustEventNameIfNeeded() -> String {
        return self.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "_").lowercased()
    }
}
