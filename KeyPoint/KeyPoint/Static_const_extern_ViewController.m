//
//  Static_const_extern_ViewController.m
//  KeyPoint
//
//  Created by Jason Jiang on 2018/4/26.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "Static_const_extern_ViewController.h"
#import "StaticConstExtern.h"


@interface Static_const_extern_ViewController ()

@end

@implementation Static_const_extern_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    cStr = @"dddd";//不能修改
    NSLog(@"the const str is %@ 常量const%d",cStr,b);
    uuu = @"www";//修改全局静态变量的值
    extern NSString *uuu;
    NSLog(@"the extern value is %@",uuu);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
