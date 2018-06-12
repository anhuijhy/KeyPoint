//
//  CLocationViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/7.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import CoreLocation

//获取地理信息
class CLocationViewController: UIViewController,CLLocationManagerDelegate {
    
    let clM = CLLocationManager()
    let isAuthorized = CLLocationManager.isAuthorized
    
    @IBAction func CLAction(_ sender: Any) {
        
        clM.requestWhenInUseAuthorization()
        clM.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        clM.delegate = self
        
        // Do any additional setup after loading the view.
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
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("the locaiton authorized status is \(status)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("the location is \(locations)")
    }
}
