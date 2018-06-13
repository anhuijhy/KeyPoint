//
//  MoyaViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/5/18.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import Moya
import Result

class MoyaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        // 模拟网络请求
//        let myStubClosure: (Target) -> Moya.StubBehavior  = { type in
//            switch type {
//            default:
//                return Moya.StubBehavior.delayed(seconds: 1)
//            }
//        }

        
        // Do any additional setup after loading the view.
        let networkplugin = NetworkActivityPlugin.init { (changeType, type) in
        
            switch changeType {
            case .began:
                print("begin")
                break
            default:
                print("no tye")
            }
            
        }

        //=====
        
        //=====normal request begin===
    

        let requestClosure = { (endpoint: Endpoint, closure: (Result<URLRequest, MoyaError>) -> Void)  -> Void     in
            do {
                var  urlRequest = try endpoint.urlRequest()
                urlRequest.timeoutInterval = 30
//                urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
//                urlRequest.httpShouldHandleCookies = false
                closure(.success(urlRequest))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
            
        }
        
        let stubAction: (_ type:MoyaService) -> Moya.StubBehavior = { type in
            switch type {
            case .logout:
                return Moya.StubBehavior.never
            case .login( _,  _):
                return Moya.StubBehavior.never
            }
        }
        
        let endPointAction = { (target: MoyaService) -> Endpoint in

                return  Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
        }
        
        
        let p = MoyaProvider<MoyaService>(endpointClosure: endPointAction, requestClosure: requestClosure, stubClosure: stubAction, callbackQueue: nil, manager: MoyaProvider<MoyaService>.defaultAlamofireManager(), plugins: [networkplugin], trackInflights: false)
        
      
        p.request(MoyaService.logout, callbackQueue: nil, progress: nil) { (result) in
            
            if case let .success(response) = result {
                
                print("has error\(response.data)")
                do {
                    
                    let dic =  try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                    
                    print("the datdddddda is \(dic)")
                } catch  {
                    
                    print("the error is \(error)")
                    
                }
                
                
            }else{
                
                
            }
        }
    
        //=============================

        let provider = MoyaProvider<MoyaService>()
        provider.request(MoyaService.logout, callbackQueue: nil, progress: { (processreponse) in
            
        }) { (result) in
        
            if case let .success(response) = result {
             
                print("has error\(response.data)")
                do {
                    
                    let dic =  try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                    
                    print("the data is \(dic)")
                } catch  {
                    
                    print("the error is \(error)")
                    
                }

            }else{
                
                
            }
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
