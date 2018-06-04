//
//  RCHelper.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/1.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class RCHelper: NSObject ,RCIMUserInfoDataSource,RCIMGroupInfoDataSource{
    
    static let helper = RCHelper()
    fileprivate override init(){}
    
    func getGroupInfo(withGroupId groupId: String!, completion: ((RCGroup?) -> Void)!) {
        
        print("the group id is=\(groupId)")
    }

    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        
        print("the user id is=\(userId)")
        //可以先从cache持久化中获取，如果没有强再获取
        let r =  RCUserInfo.init()
        r.userId = userId
        r.portraitUri = "http://pic5.photophoto.cn/20071208/0020033022749625_b.jpg"
        r.name = "wzq"
        completion(r)
    }
}
