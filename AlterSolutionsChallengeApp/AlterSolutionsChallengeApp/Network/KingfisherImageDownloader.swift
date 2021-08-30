//
//  KingfisherImageDownloader.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 29/08/21.
//

import UIKit
import RxSwift
import Kingfisher

final class KingfisherImageDownloader: ImageDownloaderProtocol {
    
    func download(with url: URL) -> Observable<UIImage?> {
        return Observable.create({ observable in
            DispatchQueue.main.async {
                let holder = UIImageView()
                
                holder.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
                    switch result {
                    case .success(let data):
                        observable.onNext(data.image)
                        observable.onCompleted()
                        
                    case .failure(let error):
                        observable.onError(error)
                        observable.onCompleted()
                    }
                }
            }
            
            return Disposables.create()
        })
    }
    
}
