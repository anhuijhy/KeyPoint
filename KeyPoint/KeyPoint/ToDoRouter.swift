//
//  ToDoRouter.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/5.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import Alamofire

enum ToDoRouter:URLRequestConvertible{
    
    static let baseURL = "https://jsonplaceholder.typicode.com/"
    
    case get(Int?)
    case post([String:Any])
    
    func asURLRequest() throws -> URLRequest {
        
        var method:HTTPMethod{
            switch self {
            case .get:
                return .get
            case .post:
                return .post
            default:
                print("unknow http method")
            }
        }
        //===
        var params :[String:Any]?{
            
            switch self {
            case .get:
                return nil
            case .post(let dic):
                return dic
            default:
                return ["1":"1"]
            }
        }
        
        var url:URL{
            var relativeURL = "todos"
            
            switch self {
            case .get(let todoId):
                if todoId != nil{
                    relativeURL = "todos/\(todoId!)"
                }
                break
            default:
                print("http method nil")
            }
            
            let url = URL(string: ToDoRouter.baseURL)!.appendingPathComponent(relativeURL)
            return url
        }
        
        print("the params is \(params)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let encoding = JSONEncoding.default
       return  try encoding.encode(request, with: params)
        
    }
}
