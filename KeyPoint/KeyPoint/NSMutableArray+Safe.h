//
//  NSMutableArray+Safe.h
//  KeyPoint
//
//  Created by 123 on 2018/4/1.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)
- (void)safeAddObject:(id)anObject;
- (id)safeObjectAtIndex:(NSInteger)idx;
@property (nonatomic,strong)  NSString *fObj;
@end
