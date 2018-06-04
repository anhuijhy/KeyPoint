//
//  BaseViewController.h
//  JJPro
//
//  Created by 123 on 17/4/18.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJCategoryKitHeader.h"
@interface BaseViewController : UIViewController
@property (nonatomic ,strong)NSDictionary *dataDic;
@property (nonatomic ,strong)NSMutableArray *dataList;

/**
 具有Nav的VC,用到有ItemVC时使用方便
 */
@property (nonatomic ,weak)UIViewController *NavVC;
- (void)setDefaultBackItem;
- (void)leftButtonAction:(id)sender;
- (void)rightButtonAction:(id)sender;
- (void)setNavigationLeftItemWithTitle:(NSString*)title andImage:(NSString*)imageName;
- (void)setNavigationRightItemWithTitle:(NSString*)title andImage:(NSString*)imageName;
//==========================
//左边btn失活
- (void)leftBUttonUnenable;

/**
 显示左边按钮
 */
- (void)showLeftButton;

//右边btn失活
- (void)rightBUttonUnenable;

/**
 显示右边按钮
 */
- (void)showrightButton;
//==========================
//带有文字的2s消失的提示
- (void)showMsg:(NSString *)msg;
- (void)hiddenHud;
- (void)showBtmMsg:(NSString *)msg;

//只转圈
- (void)showHUD;
- (void)hiddenHUD;

/**
 设置navbar是否需要下面的线 可以供子类覆盖
 */
- (void)setNavBarShadow:(BOOL)isNeed;

/**
 是否启动右边按钮的红点

 @param isNeed yes需要 no不需要
 */
- (void)setRedFlagForRightBtn:(BOOL)isNeed withNumStr:(NSString *)numStr;

@end
