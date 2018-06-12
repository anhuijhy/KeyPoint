//
//  ViewController.swift
//  KeyPoint
//
//  Created by 123 on 2018/3/29.
//  Copyright © 2018年 Jason. All rights reserved.
//

//不能够在Category中使用@synthesize关键字。原因很简单，因为@synthesize是在编译期完成的，对于Runtime时期才加载的Category，自然是没有意义的。


import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
//25
    let a = [["title":"RT获取属性\\Array越界","id":"0"],
             ["title":"RT BaseOC 获取属性","id":"1"],
             ["title":"交换方法","id":"2"],
             ["title":"添加属性","id":"3"],
             ["title":"OCRun Time 各种例子","id":"4"],
             ["title":"zip","id":"5"],
             ["title":"高阶函数map fliter","id":"6"],
             ["title":"多线程","id":"7"],
             ["title":"信号量","id":"9"],
             ["title":"static const extern","id":"10"],
             ["title":"NFC","id":"12"],
             ["title":"AVCaptureSession","id":"18"],
             ["title":"Core Text","id":"19"],
             ["title":"Realm","id":"20"],
             ["title":"Moya","id":"21"],
             ["title":"融云","id":"22"],
             ["title":"融云单聊","id":"23"],
             ["title":"RunLoop","id":"25"],
             ["title":"RX更多的demo","id":"24"],
             ["title":"RX 基础","id":"8"],
             ["title":"RX Varable Demo","id":"11"],
             ["title":"RX Skip/AsyAuthoriz","id":"12"],
             ["title":"RX flatmap","id":"13"],
             ["title":"RX Alamofire","id":"14"],
             ["title":"RX 模拟提交表单","id":"15"],
             ["title":"RX cocoaDemo","id":"16"],
             ["title":"RX TV","id":"17"]
            ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "KeyPoint"
        let tv = UITableView.init(frame: self.view.bounds)
        tv.delegate = self
        tv.dataSource = self
        self.view.addSubview(tv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    /// MARK: - tabeleview delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return a.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dic = a[indexPath.row]
        let cid = "cid"
        var cell = tableView.dequeueReusableCell(withIdentifier: cid)
        if cell == nil{
            
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cid)
        }
        cell?.textLabel?.text = dic["title"]
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dic = a[indexPath.row]
        let title = dic["title"]
        let idx = Int(dic["id"]!)
        switch idx {
        case 0:
            let vc = GetPropertyViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = GetPropertyBaseOCViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = SwizzeViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = AddProperty()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            let vc = OCViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 5:
            let vc = ZipViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 6:
            let vc = GaoJieViewController.init(nibName: "GaoJieViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 7:
            let vc = MoreThreadViewController.init(nibName: "MoreThreadViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 8:
            let vc = RXViewController.init(nibName: "RXViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 9:
            let vc = SignalViewController.init(nibName: "SignalViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 10:
            let vc = Static_const_extern_ViewController.init(nibName: "Static_const_extern_ViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 11:
            let vc = ToDoDemoViewController.init(nibName: "ToDoDemoViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 12:
            let vc = SkipAsyViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
//            let vc = CLocationViewController.init(nibName: "CLocationViewController", bundle: nil)
//            vc.navigationItem.title = title
//            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 13:
            let vc = RXFlatMaoViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 14:
            let vc = RXAlamofireViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 15:
            let vc = CombinObservalViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 16:
            let vc = RXCocoaViewController.init(nibName: "RXCocoaViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 17:
            let vc = RXTvViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 18:
            let vc = AVCaptureViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 19:
            let vc = CoreTextViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 20:
            let vc = RealmViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 21:
            let vc = MoyaViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 22:
            let vc = RCListViewController()
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 23:
            let vc = RCChatViewController()
            vc.conversationType = .ConversationType_PRIVATE
            vc.targetId = "456"
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 24:
            let vc = MoreRXViewController.init(nibName: "MoreRXViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 25:
            let vc = RunLoopViewController.init(nibName: "RunLoopViewController", bundle: nil)
            vc.navigationItem.title = title
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            print("op")
        }
    }
    
}

