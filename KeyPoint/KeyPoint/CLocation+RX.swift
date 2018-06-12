//
//  CLocation+RX.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/7.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import RxSwift
extension CLLocationManager{
    
    static var isAuthorized:Observable<Bool>{
        
        return Observable.create({ (observale) -> Disposable in
            
            DispatchQueue.main.async {
              
                if authorizationStatus() == .authorizedAlways || authorizationStatus() == .authorizedWhenInUse{
                    print("location has authorized")
                    observale.onNext(true)
                    observale.onCompleted()
                }else{
                    
                    
                }
                
            }
        
        return Disposables.create()
        })
        
    }
}


