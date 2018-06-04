//
//  jjCollectionViewController.m
//  N-BOX
//
//  Created by iOS-JJ-MacBookAir on 16/5/23.
//  Copyright © 2016年 Novaiot. All rights reserved.
//

#import "JJCollectionViewController.h"

@implementation JJCollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageNO = 1;
    self.pageSize = 10;
    [self readyCollectionView];
}


-(void)initCellClass:(Class)cell withReuseIdentifier:(NSString *)indentifier{
    
    _cell = cell;
    _reuseIdentifier = indentifier;
    
}

/**
 *  这个方法给子类设置 tableView 的 样式 ，frame pageSize 等
 */
- (void)prepareCollectionView{
    
    
}

/**
 *  初始化 tableView ,子类需要如果无特别需求，直接调用super 即可。
 */
- (void)readyCollectionView{
    
    [self prepareCollectionView];
    
    [self jjCollectionView];
    
    [self optimizeMethod];
}

/**
 *  优化方法
 */
- (void)optimizeMethod{
    
    
}

/**
 *  刷新类别 ：不刷新 上拉刷新  下拉刷新  全部
 *
 *
 */
- (void)setCvloadType:(CVloadType)cvloadType{
    
    _cvloadType = cvloadType;
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    if (_cvloadType == loadTypeNone) {
        
        //nothing need to do
    }else if (_cvloadType == loadTypeRefresh){
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf refreshCollectionView];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        self.jjCollectionView.mj_header = header;
        self.jjCollectionView.mj_header = header;
        
    }else if (_cvloadType == loadTypeMore){
        
        MJRefreshBackFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf loadMoreCollectionView];
            
        }];
        
        self.jjCollectionView.mj_footer = footer;
        
    }else if (_cvloadType == loadTypeAll){
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf refreshCollectionView];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        self.jjCollectionView.mj_header = header;

        self.jjCollectionView.mj_header = header;
        
        MJRefreshBackFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf loadMoreCollectionView];
            
        }];
        
        self.jjCollectionView.mj_footer = footer;
    }else{}
    
}

/**
 *  刷新tableview
 */
- (void)refreshCollectionView{
    
    
    _isLoadFinish = NO;
    self.pageNO = 1;
    [self requestListData];
}

/**
 *  加载更多
 */
- (void)loadMoreCollectionView{
    
    
    if (_isLoadFinish) {
        
        [self.jjCollectionView.mj_footer endRefreshingWithNoMoreData];
        return;
        
    }
    self.pageNO = self.pageNO + 1;
    [self requestListData];
    
}

/**
 *  reload tableView,如果数据处理完毕以后，实际情况仍需要一些处理，比如加入数据库等等操作，可以覆盖这个方法，即先不调用super，在处理完成之后，直接reload。如果处理完成后对dataList中的数据没有影响也可以super这个方法来reload.
 
 */

- (void)reloadCollectionView{
    
    if(_isLoadFinish){
            
        [self noticeNoMoreData];
            
    }else{
            
    }
        
    [self.jjCollectionView reloadData];
}

/**
 *  请求 可供子类覆盖
 */

- (void)requestListData{
    
    
    
}


/**
 停止所有加载动画
 **/
- (void)stopAllAnimation{
    
    [self.jjCollectionView.mj_header endRefreshing];
    [self.jjCollectionView.mj_footer endRefreshing];
    
}

/**
 *  提示没有更多数据可以加载了
 */
- (void)noticeNoMoreData{
    
    [self.jjCollectionView.mj_footer endRefreshingWithNoMoreData];
}


- (void)showNODataHud{
    
    //    [MBProgressHUD showError:@"没有数据" toView:self.view];
    [self showMsg:@"没有数据"];
}

/**
 *  具体HHTP协议处理数据，目前基类中已处理加载异常 ，没有数据等等情况.
 *
 *  @param baseData 数据
 *  至于HTTP列表返回的数据格式是否这样带验证
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
    
    [self reloadCollectionView];
}


/**
 将次添加数据的方法单独出来是为了处理一般直接添加数据，二是如果以Model来处理数据的话，也可以override 这个方法。
 */
- (void)addDetailDataListToArray:(NSArray *)array{
    
    [self.dataList addObjectsFromArray:array];
    
}


#pragma marks
#pragma setter tableview rect

- (void)setCollectionViewRect:(CGRect)collectionViewRect{
    
    _collectionViewRect = collectionViewRect;
}

#pragma marks
#pragma setter
- (void)setCvLayout:(UICollectionViewFlowLayout *)cvLayout{
    
    _cvLayout = cvLayout;
}

#pragma marks
#pragma getter

- (UICollectionView *)jjCollectionView{
    
    if (!_jjCollectionView) {
        
        //如果tableview rect 为空的话 ，设置frame 为self.view.bounds.
        if (CGRectEqualToRect(_collectionViewRect, CGRectZero)) {
            
            _collectionViewRect = self.view.bounds;
        }
        
        if (!_cvLayout) {
            
            _cvLayout = [[UICollectionViewFlowLayout alloc] init];
            _cvLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            _cvLayout.itemSize = CGSizeMake(100,100);
            _cvLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        _jjCollectionView = [[UICollectionView alloc] initWithFrame:_collectionViewRect collectionViewLayout:_cvLayout];
        //        [_jjCollectionView registerClass:_cell forCellWithReuseIdentifier:_reuseIdentifier];
        _jjCollectionView.delegate = self;
        _jjCollectionView.dataSource = self;
        [self.view addSubview:_jjCollectionView];
    }
    
    return _jjCollectionView;
    
}

#pragma marks
#pragma TableView delegate and datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:_reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
