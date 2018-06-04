//
//  OCObject.m
//  KeyPoint
//
//  Created by 123 on 2018/4/2.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "OCObject.h"
#import <objc/runtime.h>

@implementation OCObject
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSLog(@"找不到方法%@",NSStringFromSelector(sel));
    
    return YES;
}

+(BOOL)resolveClassMethod:(SEL)sel{
    
    NSLog(@"找不到方法%@",NSStringFromSelector(sel));
    
    return YES;
}
@end
