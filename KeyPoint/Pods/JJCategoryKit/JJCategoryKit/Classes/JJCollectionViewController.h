//
//  NovaCollectionViewController.h
//  N-BOX
//
//  Created by iOS-JJ-MacBookAir on 16/5/23.
//  Copyright © 2016年 Novaiot. All rights reserved.
//

#import "BaseViewController.h"

@interface JJCollectionViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic ,strong)UICollectionView *jjCollectionView;
@property(nonatomic ,assign)CVloadType cvloadType;
@property(nonatomic ,assign)NSUInteger pageSize;
@property(nonatomic ,assign)NSUInteger pageNO;
@property(nonatomic ,strong)UICollectionViewFlowLayout *cvLayout;
@property(nonatomic ,assign)CGRect collectionViewRect;
@property(nonatomic , assign)Class            cell;
@property(nonatomic , strong)NSString       *reuseIdentifier;
/**
 下拉刷新颜色
 */
@property (nonatomic ,strong)NSString *hexStr;
/**
 *  指loadStatusNet下的情况，不包含DB数据
 */
@property(nonatomic ,assign)BOOL isLoadFinish;



-(void)initCellClass:(Class)cell withReuseIdentifier:(NSString *)indentifier;


/**
 *  刷新tableview
 */
- (void)reloadCollectionView;
/**
 *  刷新tableView
 */
- (void)refreshCollectionView;
/**
 *  加载更多
 */
- (void)loadMoreCollectionView;

/**
 *  请求数据
 */
- (void)requestListData;

/**
 停止所有加载动画
 **/
- (void)stopAllAnimation;

/**
 *  没有数据提示
 */
- (void)showNODataHud;

/**
 *  这个方法给子类设置 tableView 的 样式 ，frame pageSize 等
 */
- (void)prepareCollectionView;

/**
 *  初始化 tableView ,子类需要如果无特别需求，直接调用super 即可。
 */
- (void)readyCollectionView;

/**
 *  初始化完成之后优化方法，比如设置cell class 等 需要在初始化 view 之后,如果没有特别的地方这个方法可以不用调用
 */
- (void)optimizeMethod;

/**
 *  具体处理http返回的数据
 *
 *  @param baseData 数据结构
 */
- (void)fetchDetailHTTPData:(NSDictionary *)baseData withKeyStr:(NSString *)keyStr;


/**
 *  将次添加数据的方法单独出来是为了处理一般直接添加数据，二是如果以Model来处理数据的话，也可以override 这个方法。
 *
 * 
 */
- (void)addDetailDataListToArray:(NSArray *)array;



/**
 *  mjRefresh change no more data for load
 */
- (void)noticeNoMoreData;
@end
