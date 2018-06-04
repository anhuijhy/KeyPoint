//
//  StaticConstExtern.h
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/26.
//  Copyright © 2018年 Jason. All rights reserved.
//

#ifndef StaticConstExtern_h
#define StaticConstExtern_h
//======关于static before====
//1.static修饰就构成了静态(全局/局部)变量。只会初始化一次，全局和局部的却别在于作用于不一样。

// 2.开发中常用static修饰全局变量,只改变作用域
// 为什么要改变全局变量作用域，防止重复声明全局变量。
//======关于static end=====


//=====关于static const 联合使用 begin====
// 开发中经常拿到key修改值，因此用const修饰key,表示key只读，不允许修改。
//static  NSString * const key = @"name";

// 如果 const修饰 *key1,表示*key1只读，key1还是能改变。

//static  NSString const *key1 = @"name";
//======关于static const 联合使用 end =====


//extern用来获取全局变量的值，参见VC中的uuu值的打印

//const（常量）

static  NSString  * const cStr = @"this is const strmmm";//所以这里不能修改
static  NSString   const *ccStr = @"this is const strmmm";//所以这里能修改
const int b = 20;//不能修改

static NSString *uuu = @"jhy";

extern NSString *jhy;

#endif /* StaticConstExtern_h */
