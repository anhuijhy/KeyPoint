//
//  ConfigFile.h
//  JJPro
//
//  Created by 123 on 17/4/18.
//  Copyright © 2017年 Jason. All rights reserved.
//

/*****
 这里主要宏定义一些 变量 、常用数据等并无统一性的数据
 *****/

#ifndef ConfigFile_h
#define ConfigFile_h

//日志打印
#ifdef DEBUG
#define DBLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define DBLog(format, ...)
#endif


#define IMGNAMED( X )	     [UIImage imageNamed:X]
#define UIColorFromHex(hex) [UIColor colorWithHexString:hex]


//获取整个app delegate
#define _GET_APP_DELEGATE_(appDelegate)\
AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;


//获取屏幕宽度
#define kTabBarHeight    49.0
#define kStatusBarHeight 20.0
#define kNavBarHeight    44.0
#define kSysBarHeight    (49.0 + 20.0 + 44.0)

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define __kNewWidth(pxSize)  [[Tool instance] translatWidth:pxSize]
#define __kNewHeight(pxSize) [[Tool instance] translatHeight:pxSize]
#define __kNewRealHeight(pxSize)  [[Tool instance] translatRealHeight:pxSize]
#define __kNFont(fontSize)    [UIFont systemFontOfSize:__kNewWidth(fontSize)]
#define __kNBoldFont(fontSize)    [UIFont boldSystemFontOfSize:__kNewWidth(fontSize)]
#define __kScreenWidth__ [[UIScreen mainScreen] bounds].size.width
#define __kScreenHeight__ [[UIScreen mainScreen] bounds].size.height
#define DEFAULTS ((NSUserDefaults *)[NSUserDefaults standardUserDefaults])
#define APPDELE ((AppDelegate *)([UIApplication sharedApplication].delegate))

#endif /* ConfigFile_h */
