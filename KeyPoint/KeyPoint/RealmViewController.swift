//
//  RealmViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/5/17.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
class RealmViewController: UIViewController {

    let p = Person()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        let realm = try! Realm()
        print(realm.configuration.fileURL!)

        /*
        let p = Person()
        p.name = "jsonmvv"
        p.birthData = NSDate(timeIntervalSinceNow: 0) as Date
        print("the person is \(p.name ?? "no persion")")
        let dog = Dog()
        dog.name = "jack"
        p.dogs.append(dog)
        print("the person is \(p) and the dogs is\(dog.owner)")
        
        let dogtwo = Dog(value: ["name":"mairk"])
        
        do {
            try realm.write {
                
                realm.add(dog)
                realm.add(dogtwo)
                realm.add(p)
            }
        } catch let e  {
            
            print("the error is\(e)")
        }
        
        let dogs = realm.objects(Dog.self)
        try? realm.write {

            realm.deleteAll()
        }
        print("所有的dogs is \(dogs)")
        print("删除后的数据\(p)")
        
        let dd = realm.objects(Dog.self).filter("name = %@","mairk")
        
        try! realm.write {
            
            realm.delete(dd)
        }
        */
        self.setUpUI()
        let dogM = Mapper<DogModel>().map(JSON: ["name":"i'm Jason"])
        print("the dog model is \(dogM?.name)")
        let alertVC = UIAlertController.init(title: "Msg", message: dogM?.name, preferredStyle: .alert)
        self.present(alertVC, animated: true) {
            
        }
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
extension RealmViewController{
    
    func setUpUI(){
        
        let addBtn = UIButton(type: .custom)
        addBtn.setTitle("增", for: .normal)
        addBtn.setTitleColor(UIColor.gray, for: .normal)
        addBtn.addTarget(self, action: #selector(addMethod(_:)), for: .touchUpInside)
        addBtn.frame = CGRect.init(x: 20, y: 100, width: 60, height: 40)
        self.view.addSubview(addBtn)
        
        let delBtn = UIButton(type: .custom)
        delBtn.setTitle("删", for: .normal)
        delBtn.setTitleColor(UIColor.gray, for: .normal)
        delBtn.addTarget(self, action: #selector(delMethod(_:)), for: .touchUpInside)
        delBtn.frame = CGRect.init(x: 80, y: 100, width: 60, height: 40)
        self.view.addSubview(delBtn)
        
        let modifyBtn = UIButton(type: .custom)
        modifyBtn.setTitle("改", for: .normal)
        modifyBtn.setTitleColor(UIColor.gray, for: .normal)
        modifyBtn.addTarget(self, action: #selector(modifyMethod(_:)), for: .touchUpInside)
        modifyBtn.frame = CGRect.init(x: 160, y: 100, width: 60, height: 40)
        self.view.addSubview(modifyBtn)
        
        
        let queryBtn = UIButton(type: .custom)
        queryBtn.setTitle("查", for: .normal)
        queryBtn.setTitleColor(UIColor.gray, for: .normal)
        queryBtn.addTarget(self, action: #selector(queryMethod(_:)), for: .touchUpInside)
        queryBtn.frame = CGRect.init(x: 240, y: 100, width: 60, height: 40)
        self.view.addSubview(queryBtn)
        
        
    }
    
    @objc func addMethod(_ b:UIButton){
        
        let dog = Dog(value: ["name":"豆豆"])
        let dogs = [Dog(value: ["name":"豆豆1"]),Dog(value: ["name":"豆豆2"])]
        let realm = try! Realm()
        
        try! realm.write {
            
            realm.add(dog)
            realm.add(dogs)
            //下面这个必须有主键才可以使用
            realm.create(Dog.self, value: ["name":"豆豆3"], update: false)
        }
    }
    
    @objc func delMethod(_ b:UIButton){
        
        let realm = try! Realm()
        
       let d = realm.objects(Dog.self).filter("name = %@","豆豆3")
        
        try! realm.write {
            
            realm.delete(d)
        }
    }
    
    
    @objc func modifyMethod(_ b:UIButton){
        
        let realm = try! Realm()
        let d = realm.objects(Dog.self).filter("name = %@","豆豆2").first
        
        try! realm.write {
            
            d?.name = "豆豆100"
        }
        
        /*有主键的情况下可以这样写
         
        // let dog = ... 存储在 Realm 中的 Dog 对象（有主键）
        // let dogs = ... 存储在 Realm 中的多个 Dog 对象（有主键）
        
        /* 在一个事务中修改数据 */
        try! realm.write {
            
            realm.add(dog, update: true) // 更新单个数据
            realm.add(dogs, update: true) // 更新多个数据
        }
        */
        
    
        /*通过kvc编写
         
        try! realm.write {
            
            dogs.first?.setValue("张三", forKeyPath: "name") // 将第一个狗狗名字改为张三
            dogs.setValue("张三", forKeyPath: "name") // 将所有狗狗名字都改为张三
        }
       */

    }
    
    
    @objc func queryMethod(_ b:UIButton){
        
    /*
    普通查询
    */
        let realm = try! Realm()
        let dogs = realm.objects(Dog.self)
        print("all the dogs \(dogs)")
        /*
 主键查询
         */
        let person = realm.object(ofType: Person.self, forPrimaryKey: "jsonmvv")
        print("the person is \(String(describing: person))")
        /*
 条件查询
         */
        let dogwithName = realm.objects(Dog.self).filter("name = %@","豆豆100")
        print("豆豆100是\(dogwithName)")
        
        
    }
    
}
