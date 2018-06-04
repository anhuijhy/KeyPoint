//
//  MoyaService.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/5/18.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation

import Moya

enum MoyaService {
    
    case login(phoneNum:String,passwd:String)
    case logout
}

extension MoyaService:TargetType{
    
    var baseURL: URL {
        
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        
        switch self {
        case .login(_,_):
            return "account"
        case .logout:
            return "posts"
        }
    }
    
    var method: Moya.Method {
        
        switch self {
        case .login(_,_):
            return .post
        case .logout:
            return .get
        }
    }

    //data for test
    var sampleData: Data {
        
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        
        switch self {
        case .login(let a,let b):
            return .requestParameters(parameters: [a:"v1",b:"v2"], encoding: URLEncoding.default)
        case .logout:
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
        
        return nil
    }
}

