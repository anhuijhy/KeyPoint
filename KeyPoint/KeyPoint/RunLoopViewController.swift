//
//  RunLoopViewController.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/8.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class RunLoopViewController: UIViewController {

    var t:Thread?
    
    @IBOutlet weak var runloopLIve: UIButton!

    @IBAction func liveAction(_ sender: Any) {
        
        self.startThread()
    }
    
    @IBOutlet weak var asyDisplayKit: UIButton!
    
    @IBAction func asyDisplayKitAction(_ sender: Any) {
        
        let att = NSAttributedString.init(string: "this is a text")
//        
//        let sSize = att.boundingRect(with: CGSize(width: 200, height: 800), options: .truncatesLastVisibleLine, context: nil)
        
        let textlabel = ASTextNode()
        textlabel.attributedText = att
        textlabel.backgroundColor = UIColor.red
//        textlabel.frame = CGRect.init(x: 0, y: 200, width: sSize.width, height: sSize.height)
        textlabel.layoutThatFits(ASSizeRange(min: CGSize.zero, max: CGSize(width: 200, height: 800)))
        textlabel.frame = CGRect(x: 0, y: 200, width: textlabel.calculatedSize.width, height: textlabel.calculatedSize.height)
        
        self.view.addSubnode(textlabel)
        
    }
    
    @IBAction func asyDisplayKitImgV(_ sender: Any) {
    
        let u = ASNetworkImageNode(cache: nil, downloader: ImageManager.sharedManager)
        u.frame = CGRect.init(x: 0, y: 230, width: 300, height: 100)
        u.url = URL.init(string: "http://f.hiphotos.baidu.com/image/pic/item/03087bf40ad162d9175e639f1ddfa9ec8b13cd85.jpg")
        self.view.addSubnode(u)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.startThread()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startThread() -> Void {
        
        let thread = Thread.init(target: self, selector: #selector(subThreadEntryPoint), object: nil)
        thread.name = "thread"
        thread.start()
        self.t = thread
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func subThreadEntryPoint() -> Void {
    
     let loop = RunLoop.current
     loop.add(NSMachPort.init(), forMode: .commonModes)
     loop.run()
    
    }
}

extension RunLoopViewController{
    
    //子线程任务
  @objc func subThreadTask() -> Void {
        
        print("the curent runloop\(RunLoop.current.currentMode ?? RunLoopMode(rawValue: "default NIL model"))")
        sleep(3)
        print("子线程任务结束")
    }
    
}

extension RunLoopViewController{
    
    //通过perform使用引用thread
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.perform(#selector(subThreadTask), on: self.t!, with: nil, waitUntilDone: true)
    }
    
    //=======评论UI,如何实现
    
}
