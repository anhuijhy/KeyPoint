//
//  WKWebViewController.swift
//  GoodLawyer_LawyerClient
//
//  Created by BST-MAC on 2018/5/24.
//  Copyright © 2018年 口袋律师. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {

    lazy var runJS: UIButton = {
    
        let b = UIButton(type: .custom)
        b.frame = CGRect.init(x: 40, y: 90, width: 60, height: 40)
        b.backgroundColor = UIColor.gray
        b.setTitle("run js", for: .normal)
        b.addTarget(self, action: #selector(runScript(_:)), for: .touchUpInside)
        self.view.addSubview(b)
        return b
    }()
    
    
    lazy var webView:WKWebView = {

//        let wScript = WKUserScript.init(source:"document.cookie = '\(session ?? "")';", injectionTime: .atDocumentStart, forMainFrameOnly: false)
        let wContentController = WKUserContentController()
//        wContentController.addUserScript(wScript)
        //==
        let wConfig = WKWebViewConfiguration()
        wConfig.userContentController = wContentController
        let wkWeb = WKWebView.init(frame: CGRect.init(x: 0, y: 200, width: self.view.bounds.width, height: self.view.bounds.height - 200), configuration: wConfig)
        wkWeb.navigationDelegate = self
        wkWeb.uiDelegate = self
        return wkWeb
    }()
    
    lazy var jsHelper:WKJSHelper = {
       
        let jsHelper = WKJSHelper()
        jsHelper.vc = self
        jsHelper.webView = self.webView
        return jsHelper
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        _ = self.runJS
        // Do any additional setup after loading the view.
        self.view.addSubview(self.webView)
        self.loadRequest()
        self.addScript()
        
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

extension WKWebViewController{
    
    func addScript(){
        
        self.webView.configuration.userContentController.add(self.jsHelper, name: "loadPage")
    }
    
    //添加JS
    @objc func runScript(_ b:UIButton) -> Void {
        
        DispatchQueue.main.async {
            
            self.webView.evaluateJavaScript("shareResult('jhy','jason','你好')") { (result, err) in
                
                print("the run js err is \(err) the res code is \(result)")
            }
        }
    }
}


extension WKWebViewController{
    
    /// 开始加载网页内容
    ///
    /// - Parameter url: url path
    func loadRequest( ) -> Void {
        
        let b = Bundle.main.path(forResource: "jhy", ofType: "html")
        let url = URL.init(fileURLWithPath: b!)
        let r = URLRequest.init(url: url)
        self.webView.load(r)
    }
    
}

extension WKWebViewController:WKNavigationDelegate,WKUIDelegate{

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation  :  \(error)")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit")
    }
    
    //js alert panewith msg
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        print("the msg is \(message)")
        
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
            
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //====== 确定/取消
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        print("the msg is \(message)")
        
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
            
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: { (action) in
            
            completionHandler(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
     
        let alert = UIAlertController.init(title: prompt, message: "", preferredStyle: .alert)
        
        alert.addTextField { (tf) in
            
            tf.text = defaultText
        }
        
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
            
            completionHandler(alert.textFields![0].text ?? "")
        }))
        
      self.present(alert, animated: true, completion: nil)
    }
    //======
}
