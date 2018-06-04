//
//  ArrayViewController.swift
//  KeyPoint
//
//  Created by 123 on 2018/3/30.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class AddProperty: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "cellid"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell == nil {
            
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellid)
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let of = scrollView.contentOffset.y
        print("========================>offset\(of)")
        let alpha = fabs(of/400.0)
        print("=====>delt\(alpha)")
        self.navigationController?.navigationBar.setNavbgColor(bgColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: alpha))
//        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tv = UITableView.init(frame: CGRect.init(x: 0, y: 108, width: UIScreen.main.bounds.width, height: 600))
        tv.delegate = self
        tv.dataSource = self
        if #available(iOS 11.0, *) {
            tv.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(tv)
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


extension UINavigationBar{
    
       private struct AssociatedKeys {
        static var jhy = "yf_PersonName"
    }

    @objc dynamic var navChangedBackgroundView:UIView?{
        
        get {
            
            return objc_getAssociatedObject(self, &AssociatedKeys.jhy) as? UIView
        }
        set{
            
            objc_setAssociatedObject(self, &AssociatedKeys.jhy, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
 func setNavbgColor(bgColor:UIColor) -> Void{
        
        
        if self.navChangedBackgroundView == nil {
            
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            let v = UIView.init(frame: CGRect.init(x: 0, y: -20, width: UIScreen.main.bounds.height, height: self.bounds.size.height + 20))
            self.navChangedBackgroundView = v
            self.insertSubview(self.navChangedBackgroundView!, at: 0)
        }
        
        self.navChangedBackgroundView?.backgroundColor = bgColor
    }
 
    func removeNavColor() -> Void {
        
        self.setBackgroundImage(nil, for: .default)
        self.navChangedBackgroundView?.removeFromSuperview()
        self.navChangedBackgroundView = nil
    }
}



