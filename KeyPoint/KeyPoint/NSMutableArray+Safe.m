//
//  NSMutableArray+Safe.m
//  KeyPoint
//
//  Created by 123 on 2018/4/1.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import <objc/runtime.h>

static char *jkey = "key";

@implementation NSMutableArray (Safe)
+(void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        id obj = [[self alloc] init];
        
        [obj swizzedMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
        [obj swizzedMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
        [obj swizzedMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeinsertObject:atIndex:)];
        
    });
}

- (void)setFObj:(NSString *)fObj{
    
    objc_setAssociatedObject(self, &jkey, fObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(NSString *)fObj{
    
    return objc_getAssociatedObject(self, &jkey);

}

- (void)safeinsertObject:(id)obj atIndex:(NSInteger)idx{
    
    if (obj) {
        
        [self safeinsertObject:obj atIndex:idx];
    }else{
    
        NSLog(@"insert anObject is nil");
    }
}

- (void)safeAddObject:(id)anObject{
   
    if (anObject) {
//         NSLog(@"dddd%@",anObject);
        [self safeAddObject:anObject];
    }else{
        
        NSLog(@"anObject is nil");
    }
}


- (id)safeObjectAtIndex:(NSInteger)idx{
    
    if (idx < self.count) {
        
        return [self safeObjectAtIndex:idx];
    }else{
        
        NSLog(@"index is beyond counts");
    }
    
    return nil;
}


-(void)swizzedMethod:(SEL)originalSel withMethod:(SEL)newSel{
    
    Class cls = [self class];
    
    Method oriM = class_getInstanceMethod(cls, originalSel);
    Method newM = class_getInstanceMethod(cls, newSel);
    BOOL didAddMethod = class_addMethod(cls, originalSel, method_getImplementation(newM), method_getTypeEncoding(newM));
    
    if (didAddMethod) {
        
        class_replaceMethod(cls, newSel, method_getImplementation(oriM), method_getTypeEncoding(oriM));
        
    }else{
        
          method_exchangeImplementations(oriM, newM);
    }
}

@end
