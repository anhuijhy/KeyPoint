//
//  JhyMessage.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/7/2.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

let RCJhyIdentifoer = "RC:JhyMsg"

class JhyMessage: RCMessageContent,NSCoding {
    
    var jhyName:String?
    var extra:String?
    
    //.... system
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.jhyName, forKey: "jhyName")
        aCoder.encode(self.extra, forKey: "extra")
    }
    
    required init?(coder aDecoder: NSCoder? = nil) {
        self.jhyName = aDecoder?.decodeObject(forKey: "jhyName") as? String
        self.extra = aDecoder?.decodeObject(forKey: "extra") as? String
    }
    
    override init() {
        super.init()
    }
    //....
    
    
    /// MARK: - RCMessageCoding delegate method begin===
    ///
    /// - Returns: <#return value description#>
    override func encode() -> Data! {
        
        var dict = Dictionary<String, Any>()
        
        dict["jhyName"] = self.jhyName
        dict["extra"] = self.extra
        
        
        //附加的用户信息
        if (self.senderUserInfo != nil) {
            
            var dictt = Dictionary<String, Any>()
            
            if (self.senderUserInfo.name != nil){
                
                dictt["name"] = self.senderUserInfo.name
                
            }else{}
            
            if (self.senderUserInfo.userId != nil){
                
                dictt["userId"] = self.senderUserInfo.userId
                
            }else{}
            
            if (self.senderUserInfo.portraitUri != nil){
                
                dictt["portraitUri"] = self.senderUserInfo.portraitUri
                
            }else{}
            
            dict["user"] = dictt
        }
        
        var d = Data.init()
        
        do {
        
             d = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
        } catch  {
        
            print("the err is \(error)")
        }
        
        return d
    }
    
    
    override func decode(with data: Data!) {
        
        do {
            
//            var dict = Dictionary<String,Any>()
         let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
         guard let _ = dict else { return }
         self.jhyName = dict!["jhyName"] as? String
         self.extra = dict!["extra"] as? String
         /*
             用户信息暂时不处理了
         */
        
        } catch {
            
        }
    }
    //======================end
    
    //内容摘要
    override func conversationDigest() -> String! {
        
        return "消息"
    }
    
    override class func getObjectName() -> String {
        
        return RCJhyIdentifoer
    }
}

extension JhyMessage{
    
    
    
}
