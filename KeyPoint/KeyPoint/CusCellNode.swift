//
//  CusCellNode.swift
//  KeyPoint
//
//  Created by BST-MAC on 2018/6/12.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class CusCellNode: ASCellNode {

    let iconImageView = ASNetworkImageNode(cache: nil, downloader: ImageManager.sharedManager)
    let titleLabel = ASTextNode()
    
    override init() {
        
        print("init suc")
        super.init()
        addSubnode(iconImageView)
        addSubnode(titleLabel)
        iconImageView.defaultImage = #imageLiteral(resourceName: "jhy")
    }
    
    func configureData(_ iconURL:URL,withTitle title:String){
        print("init suc")
        iconImageView.url = iconURL
        titleLabel.attributedText = NSAttributedString.init(string: title)
    }
    
    override func calculateSizeThatFits(_ constrainedSize: CGSize) -> CGSize {
        
        return CGSize.init(width: 300, height: 60)
    }
    
    override func layout() {
        super.layout()
        iconImageView.frame = CGRect.init(x: 20, y: 0, width: 200, height: 60)
        titleLabel.frame = CGRect.init(x: 240, y: 0, width: 100, height: 60)
    }
}
