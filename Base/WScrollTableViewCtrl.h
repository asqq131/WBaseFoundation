//
//  ZWScrollTableViewCtrlViewController.h
//  ZWScrollTableViewCtrl
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBaseViewController.h"
#import "UIScrollView+Refresh.h"
#import "UIView+EmptyFailureView.h"

@protocol WScrollTableViewCtrlDelegate <NSObject>

/** 导航按钮触发函数 **/
//- (void)headerBtn:(UIButton *)sender didSelectAtIndex:(NSInteger)index;
- (void)headerBtnDidSelectAtIndex:(NSIndexPath *)indexPath;
/** 网络访问失败触发函数 **/
- (void)tableView:(UITableView *)tableView networkReloadDataAction:(UIButton *)sender;
/** tableView下拉触发函数 **/
- (void)tableViewPullDownRefresh:(UITableView *)tableView;
/** tableView上拉触发函数 **/
- (void)tableViewPullUpRefresh:(UITableView *)tableView;

@end

@interface WScrollTableViewCtrl : UIViewController <UITableViewDataSource, UITableViewDelegate>

/** 底部scrollview **/
@property (nonatomic) UIScrollView *scrollView;
/** 顶部导航按钮view **/
@property (nonatomic) UIView *headerView;
/** 导航按钮 **/
@property (nonatomic, weak) UICollectionView *collectionView;

/** 存放tableView数组 **/
@property (nonatomic, strong, readonly) NSArray *tableViews;
/** tableView显示个数 **/
@property (nonatomic, assign, readonly) NSInteger tableViewCount;
/** 导航按钮标题数组 **/
@property (nonatomic, strong) NSArray *navTitles;

/** 自定义顶部View **/
@property (nonatomic, weak) UIView *customHeaderView;
/** 导航按钮选中线颜色 **/
@property (nonatomic) UIColor *selectedLineColor;
/** 导航按钮选中颜色 **/
@property (nonatomic) UIColor *selectedNavTextColor;
/** 导航按钮默认颜色 **/
@property (nonatomic) UIColor *normalNavTextColor;

@property (nonatomic, weak) id<WScrollTableViewCtrlDelegate>delegate;

/** 根据count初始化所需tableView和导航按钮 **/
- (void)setUpTableViewAtCount:(NSInteger)count;
- (void)setUpTableViewAtCount:(NSInteger)count navTitles:(NSArray *)titles;
- (void)setUpTableViewAtCount:(NSInteger)count navTitles:(NSArray *)titles customHeaderView:(UIView *)customHeaderView;

/** 更换导航按钮默认和选中颜色 **/
- (void)updateWithNavTextNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor;

/** 设置tableView下拉刷新控件 **/
- (void)setupPullDownRefreshWith:(UITableView *)tableView;
/** 设置tableView上拉刷新控件 **/
- (void)setupPullUpRefreshWith:(UITableView *)tableView;

@end
