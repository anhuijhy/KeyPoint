//
//  ViewController.swift
//  fdsaf
//
//  Created by BST-MAC on 2018/7/6.
//  Copyright © 2018年 BST-MAC. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController{
    
 
    @IBOutlet weak var jhy: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let b = Bundle.main.path(forResource: "jhy", ofType: "html")
        let url = URL.init(fileURLWithPath: b!)
        let r = URLRequest.init(url: url)
        jhy .load(r)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func wkAction(_ sender: Any) {
        
        
        let vc = WKWebViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
}

