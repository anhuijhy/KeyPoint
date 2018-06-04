//
//  EnumFile.h
//  JJPro
//
//  Created by 123 on 17/4/18.
//  Copyright © 2017年 Jason. All rights reserved.
//

/*****
全局枚举定义
 *****/

#ifndef EnumFile_h
#define EnumFile_h
//列表刷新类型
typedef NS_ENUM(NSUInteger, TVloadType) {
    loadTypeNone,//不支持上拉 下拉刷新
    loadTypeRefresh,//只有刷新
    loadTypeMore,//只有加载更多
    loadTypeAll,//支持上拉 下拉
};


//collection 列表刷新类型
typedef NS_ENUM(NSUInteger, CVloadType) {
    loadCVTypeNone,//不支持上拉 下拉刷新
    loadCVTypeRefresh,//只有刷新
    loadCVTypeMore,//只有加载更多
    loadCVTypeAll,//支持上拉 下拉
};


#endif /* EnumFile_h */
