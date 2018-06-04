//
//  OCViewController.m
//  KeyPoint
//
//  Created by 123 on 2018/3/30.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "OCViewController.h"
#import <objc/runtime.h>
#import "NSMutableArray+Safe.h"
#import "Static_const_extern_ViewController.h"

@interface OCViewController ()

@property (nonatomic ,strong)NSString *property1;
@property (nonatomic ,strong)NSString *property2;
@property (nonatomic ,strong)NSString *property3;
@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /// MARK: - 获取属性
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b1 setTitle:@"获取属性" forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(getp:) forControlEvents:UIControlEventTouchUpInside];
    b1.backgroundColor = [UIColor redColor];
    [self.view addSubview:b1];
    
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b2 setTitle:@"交换方法" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(swizze:) forControlEvents:UIControlEventTouchUpInside];
    b2.backgroundColor = [UIColor redColor];
    [self.view addSubview:b2];
    
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b3 setTitle:@"获取方法" forState:UIControlStateNormal];
    [b3 addTarget:self action:@selector(getm:) forControlEvents:UIControlEventTouchUpInside];
    b3.backgroundColor = [UIColor redColor];
    [self.view addSubview:b3];
    
    
    UIButton *b4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b4 setTitle:@"添加属性" forState:UIControlStateNormal];
    [b4 addTarget:self action:@selector(addProperty:) forControlEvents:UIControlEventTouchUpInside];
    b4.backgroundColor = [UIColor redColor];
    [self.view addSubview:b4];
    
    
    UIButton *b5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b5 setTitle:@"resolveInstanceMethod 放奔溃" forState:UIControlStateNormal];
    [b5 addTarget:self action:@selector(addPropertyjhy:) forControlEvents:UIControlEventTouchUpInside];
    b5.backgroundColor = [UIColor redColor];
    [self.view addSubview:b5];
    
    
    b1.frame = CGRectMake(60, 100, 80, 40);
    b2.frame = CGRectMake(200, 100, 80, 40);
    b3.frame = CGRectMake(60, 160, 80, 40);
    b4.frame = CGRectMake(200, 160, 80, 40);
    b5.frame = CGRectMake(60, 220, 220, 40);
    

}

//=======重新定向========
void dynamicMethodIMP(id self, SEL _cmd) {
    NSLog(@" >> dynamicMethodIMP");
}


+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSLog(@"找不到方法m%@",NSStringFromSelector(sel));
    class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
    return YES;
}
//=======

/// MARK: - 直接转发至其他target
-(id)forwardingTargetForSelector:(SEL)aSelector{
    
    NSLog(@"kkkkkkkkkkkkkkkkkk");

    return self;//===这里可以返回target
}

-(void)forwardInvocation:(NSInvocation *)invocation
{
    SEL invSEL = invocation.selector;
    if ([self respondsToSelector:invSEL]){
        [invocation invokeWithTarget:self];
    } else {
        
        NSLog(@"未知道方法");
    }
}


//==================================================

- (void)addProperty:(id)obj{
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr safeAddObject:nil];
    [arr safeAddObject:@"one"];
    
    arr.fObj = @"kkkkkkkk";
    NSLog(@"添加的属性是%@",arr.fObj);
}
- (void)getp:(id)obj{
    NSLog(@"所有属性%@",[self getAllProperty]);
    NSLog(@"属性值%@",_property1);
}

- (void)getm:(id)obj{
    
    [self getAllMethid];
}
- (void)swizze:(id)obj{
    
    /// MARK: - 交换方法
    [self swizzeMethod];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// MARK: - 获取所有方法
- (void)getAllMethid{
    
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        Method method = methods[i];
        SEL msel = method_getName(method);
        const char * name = sel_getName(msel);
        NSLog(@"获取方法list%s",name);
    }
    
}

- (NSArray *)getAllProperty{
    
    unsigned int count;
    
    Ivar *property = class_copyIvarList([self class], &count);
    NSMutableArray *parr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0;i < count;i ++){
        
        const char *pname = ivar_getName(property[i]);
        NSString *name = [NSString stringWithUTF8String:pname];
        [parr addObject:name];
        [self setValue:@"mmm" forKey:name];
    }
    free(property);
    return parr;
}

/// MARK: - 使用数组进行测试
- (void)swizzeMethod{
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:nil];
    [arr addObject:@"one"];
    [arr addObject:@"two"];
    [arr addObject:@"three"];
    [arr objectAtIndex:20];
    NSLog(@"the arr is %@",arr);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
