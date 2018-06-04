//
//  JJTBViewController.m
//  JJPro
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "JJTBViewController.h"
@interface JJTBViewController ()

@end

@implementation JJTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageNO = 1;
    self.pageSize = 10;
    [self readyTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  刷新tableview
 */
- (void)reloadTableView{
    
    if(_isLoadFinish){
        
        [self noticeNoMoreData];
        
    }else{
        
    }
    
    [self.jjTableView reloadData];
    
    if (self.pageNO == 1) {
        
    }
}

/**
 *  初始化完成之后优化方法，比如设置cell class 等 需要在初始化 view 之后,如果没有特别的地方这个方法可以不用调用 */
- (void)optimizeMethod{
    
}

/**
 *  刷新类别 ：不刷新 上拉刷新  下拉刷新  全部
 *
 *  @param tvloadType tvLoadType
 */
- (void)setTvloadType:(TVloadType)tvloadType{
    
    _tvloadType = tvloadType;
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    if (_tvloadType == loadTypeNone) {
        
        //nothing need to do
    }else if (_tvloadType == loadTypeRefresh){
        
                MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
                    [weakSelf refreshTableView];
                }];
                header.lastUpdatedTimeLabel.hidden = YES;
                self.jjTableView.mj_header = header;
        
    }else if (_tvloadType == loadTypeMore){
        
        MJRefreshBackFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf loadMoreTableView];
            
        }];
        
        self.jjTableView.mj_footer = footer;
        
        
    }else if (_tvloadType == loadTypeAll){
        
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
                    [weakSelf refreshTableView];
            }];
            header.lastUpdatedTimeLabel.hidden = YES;
            self.jjTableView.mj_header = header;
        MJRefreshBackFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf loadMoreTableView];
            
        }];
        
        self.jjTableView.mj_footer = footer;
    }else{}
    
}


/**
 *  刷新tableView
 */
- (void)refreshTableView{
    
    _isLoadFinish = NO;
    self.pageNO = 1;
    [self requestListData];
}
/**
 *  加载更多
 */
- (void)loadMoreTableView{
    
    if (_isLoadFinish) {
        [self stopAllAnimation];
        [self.jjTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    self.pageNO = self.pageNO + 1;
    [self requestListData];
}

/**
 *  请求数据
 */
- (void)requestListData{
    
    
}

/**
 停止所有加载动画
 **/
- (void)stopAllAnimation{
    [self.jjTableView.mj_header endRefreshing];
    [self.jjTableView.mj_footer endRefreshing];
}

/**
 *  这个方法给子类设置 tableView 的 样式 ，frame pageSize 等
 */
- (void)prepareTableView{
    
    
}

/**
 *  初始化 tableView ,子类需要如果无特别需求，直接调用super 即可。
 */
- (void)readyTableView{
    
    [self prepareTableView];
    
    [self jjTableView];
    
    [self optimizeMethod];
}


#pragma marks
#pragma getter

- (UITableView *)jjTableView{
    
    if (!_jjTableView) {
        
        //如果tableview rect 为空的话 ，设置frame 为self.view.bounds.
        if (CGRectEqualToRect(_tableViewRect, CGRectZero)) {
            
            _tableViewRect = self.view.bounds;
        }
        
        _jjTableView = [[UITableView alloc] initWithFrame:_tableViewRect style:_tableViewStyle];
        _jjTableView.delegate = self;
        _jjTableView.dataSource = self;
        _jjTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_jjTableView];
    }
    
    return _jjTableView;
    
}

/**
 *  处理Http结果
 *
 *  @param baseData 数据字典
 */

- (void)fetchDetailHTTPData:(NSDictionary *)baseData withKeyStr:(NSString *)keyStr{
    
    [self stopAllAnimation];
    
    NSString *key = @"list";
    if (keyStr.length > 0) {
        
        key = keyStr;
    }
    
    if(self.pageNO == 1){
        
        [self.dataList removeAllObjects];
        [self addDetailDataListToArray:[baseData objectForKey:@"data"][key]];
        
        
    }else{
        
        [self addDetailDataListToArray:[baseData objectForKey:@"data"][key]];
        
    }
    
    NSArray *a = [baseData objectForKey:@"data"][key];
    
    if ([a count] == 0)
    {
        _isLoadFinish = YES;
    }
    
    [self reloadTableView];
}


/**
 <#Description#>
 
 @param array <#array description#>
 */
- (void)addDetailDataListToArray:(NSArray *)array{
    
    [self.dataList addObjectsFromArray:array];
}

/**
 *  mjRefresh change no more data for load
 */
- (void)noticeNoMoreData{
    
    [self.jjTableView.mj_footer endRefreshingWithNoMoreData];
}


#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ci = @"cici";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ci];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ci];
    }
    
    return cell;
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
