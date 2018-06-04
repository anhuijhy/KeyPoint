//
//  JJTBViewController.h
//  JJPro
//
//  Created by 123 on 17/4/20.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "BaseViewController.h"

@interface JJTBViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign)NSInteger pageNO;
@property (nonatomic ,assign)NSInteger pageSize;
@property (nonatomic ,strong)UITableView *jjTableView;
@property (nonatomic ,assign)TVloadType tvloadType;
@property (nonatomic ,assign)UITableViewStyle tableViewStyle;
@property (nonatomic ,assign)CGRect tableViewRect;

/**
 *  指loadStatusNet下的情况，不包含DB数据
 */
@property(nonatomic ,assign)BOOL isLoadFinish;

/**
 *  刷新tableview
 */
- (void)reloadTableView;

/**
 *  初始化完成之后优化方法，比如设置cell class 等 需要在初始化 view 之后,如果没有特别的地方这个方法可以不用调用 */
- (void)optimizeMethod;
/**
 *  刷新tableView
 */
- (void)refreshTableView;
/**
 *  加载更多
 */
- (void)loadMoreTableView;

/**
 *  请求数据
 */
- (void)requestListData;

/**
 停止所有加载动画
 **/
- (void)stopAllAnimation;

/**
 *  这个方法给子类设置 tableView 的 样式 ，frame pageSize 等
 */
- (void)prepareTableView;

/**
 *  初始化 tableView ,子类需要如果无特别需求，直接调用super 即可。
 */
- (void)readyTableView;

/**
 *  处理Http结果
 *
 *  @param baseData 数据字典
 */

- (void)fetchDetailHTTPData:(NSDictionary *)baseData withKeyStr:(NSString *)keyStr;


/**
 <#Description#>

 @param array <#array description#>
 */
- (void)addDetailDataListToArray:(NSArray *)array;

/**
 *  mjRefresh change no more data for load
 */
- (void)noticeNoMoreData;


@end
