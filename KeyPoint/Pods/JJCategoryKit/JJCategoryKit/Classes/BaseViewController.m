//
//  BaseViewController.m
//  JJPro
//
//  Created by 123 on 17/4/18.
//  Copyright © 2017年 Jason. All rights reserved.
//

#define REDLABTAG  100
#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *btnLeftItem; /**< <#属性注释#> */
@property (nonatomic, strong) UIButton *btnRightItem; /**< <#属性注释#> */
@end

@implementation BaseViewController

- (void)loadView{
    [super loadView];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar"]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self setNavBarShadow:YES];
    // Do any additional setup after loading the view.
    NSArray* tmp = self.navigationController.viewControllers;
    if(tmp.count > 1){
        [self setDefaultBackItem];
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromHex(@"#ffffff")}];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}


- (void)setNavBarShadow:(BOOL)isNeed{

    if (isNeed) {
        
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
        
    }else{
      
        //恢复navbar下面的线条
        self.navigationController.navigationBar.shadowImage = IMGNAMED(@"black");
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma marks --以后可以直接使用这个来处理tableView 数据源
#pragma getter
- (NSMutableArray *)dataList{
    
    if (!_dataList) {
        
        _dataList = [NSMutableArray array];
        
    }
    
    return _dataList;
    
}


- (void)showLoadingMsg:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = msg;
    // Move to bottm center.
    hud.offset = CGPointMake(0, 0);
    [hud hideAnimated:YES afterDelay:2.0];
}

- (void)showMsg:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    // Move to bottm center.
    hud.offset = CGPointMake(0, 0);
    [hud hideAnimated:YES afterDelay:2.0];
    
}

- (void)hiddenHud{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


- (void)showBtmMsg:(NSString *)msg{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    hud.offset = CGPointMake(0, kScreenHeight - 100);
    [hud hideAnimated:YES afterDelay:2.0];
}

- (void)showHUD{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


- (void)hiddenHUD{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


- (void)setDefaultBackItem{
    [self setNavigationLeftItemWithTitle:@"" andImage:@"back"];
}

- (void)setNavigationLeftItemWithTitle:(NSString*)title{
    [self.btnLeftItem setTitle:title forState:UIControlStateNormal];
}

- (void)setNavigationLeftItemWithTitle:(NSString*)title andImage:(NSString*)imageName{
    [self.btnLeftItem setTitle:title forState:UIControlStateNormal];
    [self.btnLeftItem setImage:IMGNAMED(imageName) forState:UIControlStateNormal];
}

- (void)setNavigationRightItemWithTitle:(NSString*)title andImage:(NSString*)imageName{
    [self.btnRightItem setTitle:title forState:UIControlStateNormal];
    [self.btnRightItem setImage:IMGNAMED(imageName) forState:UIControlStateNormal];
}


- (void)setNavigationRightItemWithTitle:(NSString*)title{
    [self.btnRightItem setImage:nil forState:UIControlStateNormal];
    [self.btnRightItem setTitle:title forState:UIControlStateNormal];
}

- (void)leftButtonAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonAction:(id)sender{}


- (UIButton*)btnLeftItem{
    if(!_btnLeftItem){
        _btnLeftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeftItem.titleLabel.font = __kNFont(28.0);
        [_btnLeftItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnLeftItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnLeftItem.frame = CGRectMake(0, 0, __kNewWidth(50), __kNewHeight(40));
        [_btnLeftItem addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnLeftItem];
    }
    return _btnLeftItem;
}
//==================================
- (void)leftBUttonUnenable{
    
    _btnLeftItem.hidden = YES;
}

- (void)showLeftButton{
    
    _btnLeftItem.hidden = NO;
}


//右边btn失活
- (void)rightBUttonUnenable{
    
    _btnRightItem.hidden = YES;
}

/**
 显示右边按钮
 */
- (void)showrightButton{
    
    _btnRightItem.hidden = NO;
}
//=================================
- (UIButton*)btnRightItem{
    if(!_btnRightItem){
        _btnRightItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRightItem.titleLabel.font = __kNFont(26.0);
        [_btnRightItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnRightItem.frame = CGRectMake(0, 0, __kNewWidth(120), __kNewHeight(40));
        _btnRightItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_btnRightItem addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnRightItem];
    }
    return _btnRightItem;
}


/**
 是否启动右边按钮的红点
 
 @param isNeed yes需要 no不需要
 */
- (void)setRedFlagForRightBtn:(BOOL)isNeed withNumStr:(NSString *)numStr{

    [_btnRightItem.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UILabel *l = (UILabel *)obj;
        if ([l isKindOfClass:[UILabel class]] && l.tag == REDLABTAG) {
            
            [l removeFromSuperview];
        }
        
    }];
    
    if (!isNeed) {
        
        return;
    }
    
    UILabel *lab = [[UILabel alloc] init];
    lab.backgroundColor = UIColorFromHex(@"#f43531");
    lab.tag = REDLABTAG;
    lab.frame = CGRectMake(0, 0, __kNewWidth(18.0), __kNewHeight(18.0));
    lab.center = CGPointMake(CGRectGetWidth(_btnRightItem.frame) - __kNewWidth(5),  __kNewHeight(3));
    lab.layer.cornerRadius = __kNewWidth(9.0);
    lab.clipsToBounds = YES;
    [_btnRightItem addSubview:lab];
}

- (void)dealloc{
    
    DBLog(@"dealloc happened %@",NSStringFromClass([self class]));
    
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
