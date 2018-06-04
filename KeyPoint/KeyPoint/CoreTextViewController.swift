//
//  CoreTextViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/10.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import CoreText

class CoreTextViewController: UIViewController {

    let coreTextV = CoreTextStr.init(frame: CGRect.init(x: 0, y: 64+24, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 24))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(coreTextV)
//        coreTextV.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: 1500)
        coreTextV.backgroundColor = UIColor.white
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
