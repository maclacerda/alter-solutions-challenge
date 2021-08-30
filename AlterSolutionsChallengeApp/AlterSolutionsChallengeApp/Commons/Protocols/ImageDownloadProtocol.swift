//
//  ImageDownloadProtocol.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 29/08/21.
//

import UIKit
import RxSwift

protocol ImageDownloaderProtocol: AnyObject {
    
    func download(with url: URL) -> Observable<UIImage?>
    
}
