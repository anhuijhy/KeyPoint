//
//  SkipAsyViewController.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/4.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import Photos
import RxSwift
class SkipAsyViewController: UIViewController {
    fileprivate lazy var photos = SkipAsyViewController.loadPhotos()
    fileprivate lazy var imageManager = PHCachingImageManager()
    lazy var tv: UITableView = {
        let t = UITableView.init(frame: self.view.bounds, style: .plain)
        t.delegate = self
        t.dataSource = self
        self.view.addSubview(t)
        return t
    }()
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fsafdsf\(photos)")
        // Do any additional setup after loading the view.
        let isAuthorized = PHPhotoLibrary.isAuthorized.share()
        isAuthorized
            .skipWhile { (e) -> Bool in
                if (!e){
                    return true
                }else{
                    return false
                }
            }
            .take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (e) in
                if self != nil
                {
                    print("tv relaod")
                    self?.tv.reloadData()
                }
                
                }, onError: { (error) in
                    
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: bag)
        
        isAuthorized
            .distinctUntilChanged()
            .takeLast(1)
            .filter { (e) -> Bool in
                print("ddd\(e)")
                return !e
            }.subscribe(onNext: { (e) in
                
                self.flash(title: "Cannot access your photo library",
                           message: "You can authorize access from the Settings.",
                           callback: { _ in
                            self.navigationController?.popViewController(animated: true)
                })
                
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: bag)
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

extension SkipAsyViewController{
    static func loadPhotos() -> PHFetchResult<PHAsset> {
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        return PHAsset.fetchAssets(with: .video, options: options)
    }
}

extension SkipAsyViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("init cell")
        let cid = "cid"
        var cell = tableView.dequeueReusableCell(withIdentifier: cid)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cid)
        }
        let asset = photos.object(at: indexPath.row)
        imageManager.requestImage(for: asset, targetSize: CGSize.init(width: 200, height: 200), contentMode: PHImageContentMode.aspectFit, options: nil) { (img, info) in
            guard let imgg = img,let _ = info else{return}
            
            //            if cell.representedAssetIdentifier == asset.localIdentifier {
            print("the img is \(imgg)")
            cell?.imageView?.image = imgg
            //            }
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
}

