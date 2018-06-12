
//
//  ImageManager.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/12.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import SDWebImage

class ImageManager: NSObject,ASImageDownloaderProtocol /*, ASImageCacheProtocol*/ {

//    func cachedImage(with URL: URL, callbackQueue: DispatchQueue, completion: @escaping ASImageCacherCompletion) {
//        <#code#>
//    }
    
    func downloadImage(with URL: URL, callbackQueue: DispatchQueue, downloadProgress: ASImageDownloaderProgress?, completion: @escaping ASImageDownloaderCompletion) -> Any? {
        
        let operation = SDWebImageDownloader.shared().downloadImage(with: URL, options: [], progress: nil) { (image, data, error, _) -> Void in
            if let image = image {
 
                    callbackQueue.async {
                    completion(image, error, nil)
                }
                
                return
            }
            completion(nil, error,nil)
        }
        return operation
    }
    
    func cancelImageDownload(forIdentifier downloadIdentifier: Any) {

        if let downloadIdentifier = downloadIdentifier as? SDWebImageOperation {
            downloadIdentifier.cancel()
        }
    }
    
    static let sharedManager = ImageManager()
}
