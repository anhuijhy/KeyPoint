//
//  ViewController.swift
//  fff
//
//  Created by BST-MAC on 2018/5/25.
//  Copyright © 2018年 BST-MAC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let app =  UIApplication.shared.delegate as! AppDelegate
        let jhye = JHY.init(entity: NSEntityDescription.entity(forEntityName: "JHY", in: app.persistentContainer.viewContext)!, insertInto: app.persistentContainer.viewContext)

        jhye.name = "jhy"
        jhye.uid = "uid100"
        jhye.m = "justest"

        app.saveContext()
 

        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "JHY")
        do {
         let arr = try app.persistentContainer.viewContext.fetch(request)
            print("the ori data arr is \(arr.first)")
            let j = arr.first as? JHY
            print("fafdafmmmmmmmm\(j?.name ?? "")")
        } catch  {
            print("the err is \(error)")
        }

        
        let f = FileManager.default
        let url = f.urls(for: .documentDirectory, in: .userDomainMask)
        print("the url is\(url)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

