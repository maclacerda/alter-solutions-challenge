//
//  ImageDownloadStub.swift
//  AlterSolutionsChallengeAppTests
//
//  Created by Marcos Lacerda on 01/09/21.
//

import UIKit
import RxSwift
@testable import AlterSolutionsChallengeApp

class ImageDownloadStub: ImageDownloaderProtocol {
    
    // MARK: - Properties
    
    var mockType: MockType
    
    // MARK: - MockTypes
    
    enum MockType {
        case image(UIImage)
        case blankImage
        case error(NSError)
    }
    
    // MARK: - Initialization
    
    init(mockType: MockType = .blankImage) {
        self.mockType = mockType
    }
    
    // MARK: - ImageDownloaderProtocol
    
    func download(with url: URL) -> Observable<UIImage?> {
        switch mockType {
        case .image(let image):
            return Observable.of(image)
        case .blankImage:
            return Observable.of(UIImage())
        case .error(let error):
            return Observable.error(error)
        }
    }
    
}
