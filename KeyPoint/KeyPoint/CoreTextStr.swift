//
//  CoreTextStr.swift
//  KeyPoint
//
//  Created by Jason Jiang on 2018/5/10.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import CoreText

class CoreTextStr: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var imgFrame:CGRect?
    var ctFrame:CTFrame?
    var allFrame:CTFrame?
    var strlength = 0
    var lines:NSArray?
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let ref = UIGraphicsGetCurrentContext()

        //坐标系转换
        ref?.textMatrix = .identity
        ref?.translateBy(x: 0, y: self.bounds.size.height)
        ref?.scaleBy(x: 1.0, y: -1.0)

        //文本
        let attString = NSMutableAttributedString.init(string: "Hello CoreText!我是开始Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreTextHello CoreText!我是结尾")
        strlength = attString.length
        
        //行间距
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        attString.addAttributes([NSAttributedStringKey.paragraphStyle : style,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18)], range: NSMakeRange(0, attString.length))
        
        //添加本地图片
        var imageName = ["imageName":"jhy","height":"200","width":"100"]
        var imageCallBack =  CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (refcon) in
            
        }, getAscent: { (refcon) -> CGFloat in
        
            print("the pic dic is \(refcon)")

            return 100
        }, getDescent: { (refcon) -> CGFloat in
            return 0
        }) { (refcon) -> CGFloat in
            return UIScreen.main.bounds.size.width - 20
        }
        
        let runDelegate = CTRunDelegateCreate(&imageCallBack, &imageName)
        let imgString = NSMutableAttributedString(string: " ")
        //===
        imgString.addAttribute(NSAttributedStringKey(rawValue: kCTRunDelegateAttributeName as String), value: runDelegate!, range: NSMakeRange(0, 1))
        imgString.addAttribute(NSAttributedStringKey(rawValue: "imageName"), value: "jhy", range: NSMakeRange(0, 1))
        //===
        attString.insert(imgString, at: 16)


        //===========================
        let path = CGMutablePath.init()
        path.addRect(rect)
        
        //===
        let b = UIBezierPath.init(rect: CGRect.init(x: 100, y: 100, width: 100, height: 200))
        let pp = UIBezierPath.init(rect: self.bounds)
        pp.append(b)
        //===
        
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        let frame = CTFramesetterCreateFrame(framesetter, CFRange.init(location: 0, length: attString.length), pp.cgPath, nil)
        CTFrameDraw(frame, ref!)

        //===============
        allFrame = frame
        
        //遍历frame寻找CTLine===========
        let lines = CTFrameGetLines(frame) as NSArray
        let ctLinesArray = lines as Array
        var originalArray = [CGPoint](repeating: CGPoint.zero, count: ctLinesArray.count)
        let range = CFRangeMake(0, 0)
        
        CTFrameGetLineOrigins(frame, range, &originalArray)
        
        for i  in 0 ..<  lines.count {
            //遍历每行
            let line = lines[i]
            var lineAscent = CGFloat()
            var lineDescent = CGFloat()
            var lineLeading = CGFloat()
            
            CTLineGetTypographicBounds(line as! CTLine, &lineAscent, &lineDescent, &lineLeading)
            
           let runs = CTLineGetGlyphRuns(line as! CTLine) as NSArray
            
            for j in 0 ..< runs.count{
                
                var runAscent = CGFloat()
                var runDescent = CGFloat()
                let lineOrigin = originalArray[i]
                let run = runs[j]
                let attributes = CTRunGetAttributes(run as! CTRun)  as NSDictionary
                let width = CGFloat( CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0,0), &runAscent, &runDescent, nil) )
                
                let  runRect = CGRect.init(x:lineOrigin.x + CTLineGetOffsetForStringIndex(line as! CTLine, CTRunGetStringRange(run as! CTRun).location, nil), y:lineOrigin.y - runDescent, width:width, height:runAscent + runDescent)

                let imageNames = attributes.object(forKey: "imageName")
                //===
//                print("attribute is \(attributes.value(forKey: "CTRunDelegate"))")
//                let ctrun = attributes.value(forKey: "CTRunDelegate")
//                if let crrund = ctrun{
//
//                }else{}
                //===
                if imageNames is NSString {
                    //本地图片
                    let image = UIImage(named: imageNames as! String)
                    let imageDrawRect = CGRect.init(x:10, y:lineOrigin.y+runDescent, width:UIScreen.main.bounds.width - 20, height:100)
                    //img rect Jason
                    imgFrame = imageDrawRect
                    //================
                    ref?.draw(image!.cgImage!, in: imageDrawRect)
                }

            }
            
            
            ref?.draw((UIImage.init(named: "jhy")?.cgImage)!, in: CGRect.init(x: 100, y: 100, width: 100, height: 200))
        }
    }
}

extension CoreTextStr{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("the touch began")
        let touch = (touches as NSSet).anyObject()!
        let location = self.systemPointFromScreenPoint((touch as! UITouch).location(in: self))
        print("the location is \(location)")
        if self.checkIsClickOnImgWithPoint(location) {
            DispatchQueue.main.async {
                
                let alertv = UIAlertView.init(title: "Tip", message: "the img has click", delegate: nil, cancelButtonTitle: "OK")
                alertv.show()
                
            }
            print("the img has click")
            return
        }
        
        //==to do
        
       let q = DispatchQueue(label: "jhy")
        q.async {
            
           self.ClickOnStrWithPoint(location)
        }

    }
    
    
    
    //屏幕坐标系转换为系统坐标系
    func systemPointFromScreenPoint(_ origin:CGPoint) -> CGPoint{
    
         return CGPoint.init(x: origin.x, y: self.bounds.size.height - origin.y)
    
    }
    
    
}

extension  CoreTextStr{
    
    func checkIsClickOnImgWithPoint(_ location:CGPoint) -> Bool {
        
        //提前保存img ctframe
        print("the iamg original frame is\(imgFrame ?? CGRect.zero)")
        if self .isFrameContainsPoint(imgFrame!, containsPoint: location) {
        
            return true
        }
    
        return false
    }
}

extension CoreTextStr{
    
    func isFrameContainsPoint(_ frame:CGRect,containsPoint point:CGPoint) -> Bool {
        
        return frame.contains(point)
    }
}

extension CoreTextStr{
    
    func ClickOnStrWithPoint(_ location:CGPoint) -> Void {
        
        guard let _ = allFrame else {
            
            return
        }
        lines = CTFrameGetLines(allFrame!) as NSArray
        var rangs = [CFRange](repeating: CFRange.init(), count: (lines?.count)!)
        var origins = [CGPoint](repeating: CGPoint.zero, count: (lines?.count)!)
        CTFrameGetLineOrigins(allFrame!, CFRangeMake(0, 0), &origins)
        
        for i in 0 ..< lines!.count {

            let line = lines![i]
            print("the ctline is \(line)")
            let range = CTLineGetStringRange(line as! CTLine)
            rangs[i] = range
        }
        
        //==== 逐个字符检查
        for i in 0 ..< strlength {

            var lineNum = 0
            var maxLoc :CLong = 0
            //防止字符越过所在CTLine
            for j in 0 ..< lines!.count {

                let range = rangs[j]
                maxLoc = range.location + range.length - 1
                if (i <= maxLoc){

                    lineNum = j
                    //跳出所在for loop
                    break
                }
            }

            let line = lines![lineNum]
            let origin = origins[lineNum]

            let rr = self.frameForCTRunWithIndex(i, ctline: line as! CTLine, origin: origin)
            if self.isFrameContainsPoint(rr, containsPoint: location){

                NSLog("您点击到了第 %d 个字符，位于第 %d 行，然而他没有响应事件。",i,lineNum + 1);//点击到文字，然而没有响应的处理。可以做其他处理
                
                DispatchQueue.main.async {
                    
                    let alertv = UIAlertView.init(title: "Tip", message: "你点击了文字\(i) 行\(lineNum + 1)", delegate: nil, cancelButtonTitle: "OK")
                    alertv.show()
                    
                }

                return
            }
        }
        
        
    }
    
}

extension CoreTextStr{
    
    func frameForCTRunWithIndex(_ index:Int,ctline line:CTLine ,origin ori:CGPoint) -> CGRect {
        
        var offsetX = CTLineGetOffsetForStringIndex(line, index, nil)
        var offsetX2 = CTLineGetOffsetForStringIndex(line, index + 1, nil)
        offsetX += ori.x
        offsetX2 += ori.x
        let offsetY = ori.y
        var lineAscent = CGFloat()
        var lineDescent = CGFloat()
        let runs = CTLineGetGlyphRuns(line) as NSArray
        var runCurrent :CTRun?
        for k in 0 ..< runs.count {
    
            let run = runs[k]
            let range = CTRunGetStringRange(run as! CTRun)
            let rangeOC = NSMakeRange(range.location, range.length)
            if(self .isIndex(index, inRange: rangeOC)){
                
                runCurrent = (run as! CTRun)
                break
            }
        }
        
        guard let _ = runCurrent else {
            //空白地方runCurrent == nil
            return CGRect.zero
        }
        
        CTRunGetTypographicBounds(runCurrent!, CFRange.init(location: 0, length: 0), &lineAscent, &lineDescent, nil)
        let height = lineAscent + lineDescent
        return CGRect.init(x: offsetX, y: offsetY, width: offsetX2 - offsetX, height: height)
    }
    
    func isIndex(_ index:NSInteger,inRange range:NSRange) -> Bool {
        
        if (index <= range.location + range.length - 1) && index >= range.location{
          
            return true
            
        }
          return false
    }
}
