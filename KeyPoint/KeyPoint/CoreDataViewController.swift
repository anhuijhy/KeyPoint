//
//  CoreDataViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/27.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class CoreDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CoreDataManager.manager.addNewEntity("JhyEntity")
        CoreDataManager.manager.queryEntityData(nil, entityName: "JhyEntity")
        CoreDataManager.manager.modifyEntityData(nil, entityName: "JhyEntity")
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
