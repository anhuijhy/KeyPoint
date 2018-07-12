//
//  WKSWJSHelper.swift
//  GoodLawyer_LawyerClient
//
//  Created by BST-MAC on 2018/5/24.
//  Copyright © 2018年 口袋律师. All rights reserved.
//

import UIKit
import WebKit
class WKJSHelper: NSObject,WKScriptMessageHandler{

    /// 对应webview所对用的VC
    weak var vc:UIViewController?
    weak var webView:WKWebView?
    // MARK: - 点击按钮具体实现相应的方法
    /// 点击按钮具体实现相应的方法
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
     let jsName = message.name
    print("the msg name is \(jsName)")
        switch jsName {
        case "loadPage":
            let msgName = message.body as! String
            print("the msg name is \(jsName) the body is \(msgName)")
            break
        default: break
            //to do
        }
        
    }
}

extension WKJSHelper{
    
    /// reload webview
    func reloadWebView() {
        
        webView?.reload()
    }
}
