//
//  PHPhotoLibrary+RX.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/4.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import Photos
import RxSwift
extension PHPhotoLibrary{
    
    static var isAuthorized:Observable<Bool>{
        
        return Observable.create({ (observable) -> Disposable in

            DispatchQueue.main.async {
                if authorizationStatus() == .authorized{
                    observable.onNext(true)
                    observable.onCompleted()
                }else{
                    
                    requestAuthorization({ (status) in
                        
                        observable.onNext(authorizationStatus() == .authorized)
                        observable.onCompleted()
                    })
                }
            }
            return Disposables.create()
        })
        
    }
    
}
