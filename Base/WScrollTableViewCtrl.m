//
//  ZWScrollTableViewCtrlViewController.m
//  ZWScrollTableViewCtrl
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WScrollTableViewCtrl.h"
#import "WScrollHeaderCollectionCell.h"

#define kMaxCollectionItemCount 3

@interface WScrollTableViewCtrl () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    __weak UILabel *_selectedLine;
    
    NSInteger _currentSelectItemIndex;
    NSInteger _collectionItemCount;
}

@end

@implementation WScrollTableViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

// FIXME: 可以直接获取到collectionView中每个cell相对父控件的位置
- (void)updateCollectionViewOffsetAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *attributes = [_collectionView layoutAttributesForItemAtIndexPath:indexPath];
//    CGRect cellFrameInSuperview = [_collectionView convertRect:attributes.frame toView:[_collectionView superview]];
    
    CGFloat itemWidth = kScreenSize.width / _collectionItemCount;
    CGFloat itemOffset = itemWidth * indexPath.row;
    CGFloat centerOffset = itemOffset + itemWidth / 2 - self.view.center.x;
    if (indexPath.row == 0) {
        centerOffset = 0;
    } else if (indexPath.row == _tableViewCount - 1) {
        centerOffset = itemOffset + itemWidth - kScreenSize.width;
    }
    
    [_collectionView setContentOffset:CGPointMake(centerOffset, 0) animated:YES];
}

#pragma mark 更换导航按钮默认和选中颜色
- (void)updateWithNavTextNormalColor:(UIColor *)normalColor andSelectColor:(UIColor *)selectColor {
    _normalNavTextColor = normalColor;
    _selectedNavTextColor = selectColor;
    [_collectionView reloadData];
}

#pragma mark - ---External Methods---

#pragma mark 按传入的count个数初始化tableView以及导航按钮
- (void)setUpTableViewAtCount:(NSInteger)count {
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.scrollView];
    
    _tableViewCount = count;
    
    NSMutableArray *tableViews = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // init tableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width * i, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame))];
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        [_scrollView addSubview:tableView];
        [tableViews addObject:tableView]; // 存入临时tableView集合
        
        // 创建空数据view
        [tableView setupEmptyDataViewWith:nil tipText:nil yOffset:0];
        [tableView getEmptyDataViewKey].hidden = YES;
        
        // 创建网络访问错误view
        [tableView setupNetworkReloadViewWith:nil tipText:nil yOffset:0];
        [[tableView getNetworkReloadBtnKey] addTarget:self action:@selector(networkReloadDataAction:) forControlEvents:UIControlEventTouchUpInside];
        [tableView getNetworkReloadViewKey].hidden = YES;
    }
    _tableViews = tableViews; // 赋值给tableView集合对象，供外部访问
    
    // 按钮底部选中线
    _collectionItemCount = count > kMaxCollectionItemCount ? kMaxCollectionItemCount : count;
    CGFloat itemWidth = CGRectGetWidth(_collectionView.frame) / _collectionItemCount;
    UILabel *selectedLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_collectionView.frame) - 2.0, itemWidth, 2.0)];
    selectedLine.backgroundColor = kColorRGB(54, 201, 251, 1);
    [_collectionView addSubview:_selectedLine = selectedLine];
    
    UILabel *collectionViewBottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_collectionView.frame) - 0.5, itemWidth * count, 0.5)];
    collectionViewBottomLine.backgroundColor = kColorRGB(232, 232, 232, 1);
    [_collectionView addSubview:collectionViewBottomLine];
    
    _scrollView.contentSize = CGSizeMake(kScreenSize.width*count, CGRectGetHeight(_scrollView.frame));
}

- (void)setUpTableViewAtCount:(NSInteger)count navTitles:(NSArray *)titles {
    [self setUpTableViewAtCount:count];
    
    self.navTitles = titles;
}

- (void)setUpTableViewAtCount:(NSInteger)count navTitles:(NSArray *)titles customHeaderView:(UIView *)customHeaderView {
    self.customHeaderView = customHeaderView;
    [self.view addSubview:self.customHeaderView];
    
    [self setUpTableViewAtCount:count navTitles:titles];
}

#pragma mark 根据tableView设置下拉刷新
- (void)setupPullDownRefreshWith:(UITableView *)tableView {
    [tableView setupPullDownRefreshWithTarget:self refreshingAction:@selector(tableViewPullDownRefresh)];
}

#pragma mark 根据tableView设置上拉刷新
- (void)setupPullUpRefreshWith:(UITableView *)tableView {
    [tableView setupPullUpRefreshWithhTarget:self refreshingAction:@selector(tableViewPullUpRefresh)];
}

#pragma mark 下拉刷新对外访问函数，提供tableView
- (void)tableViewPullDownRefresh:(UITableView *)tableView {
    NSLog(@"tableViewPullDownRefresh");
}

#pragma mark 上拉刷新对外访问函数，提供tableView
- (void)tableViewPullUpRefresh:(UITableView *)tableView {
    NSLog(@"tableViewPullUpRefresh");
}

#pragma mark tableVew网络访问错误触发函数
- (void)tableView:(UITableView *)tableView networkReloadDataAction:(UIButton *)sender {
    NSLog(@"ZWScrollTableViewCtrlViewController tableNetworkReloadDataAction");
}

#pragma mark 导航按钮触发函数
- (void)headerBtnDidSelectAtIndex:(NSIndexPath *)indexPath {
//    NSLog(@"ZWScrollTableViewCtrlViewController didSelectAtIndex at %@", indexPath);
}

#pragma mark - ---delegate and datasource---

#pragma mark tableVew delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) return;
    
    CGRect rect = _selectedLine.frame;
    rect.origin.x = scrollView.contentOffset.x / _collectionItemCount;
    _selectedLine.frame = rect;
    
//    _collectionView.contentOffset = CGPointMake(scrollView.contentOffset.x / _collectionItemCount / 2, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) return;
    
    NSInteger page = scrollView.contentOffset.x / kScreenSize.width;
    _currentSelectItemIndex = page;
    
    [self updateCollectionViewOffsetAtIndexPath:[NSIndexPath indexPathForRow:_currentSelectItemIndex inSection:0]];
    [_collectionView reloadData];
}

#pragma mark collectionView delegate and datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tableViewCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WScrollHeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WScrollHeaderCollectionCell" forIndexPath:indexPath];
    
    cell.itemBtn.selected = _currentSelectItemIndex == indexPath.row;
    cell.separatorLine.hidden = _tableViewCount - 1 == indexPath.row;
    [cell.itemBtn setTitleColor:_selectedNavTextColor forState:UIControlStateSelected];
    [cell.itemBtn setTitleColor:_normalNavTextColor forState:UIControlStateNormal];
    
    if (_navTitles && _navTitles.count == _tableViewCount) {
        [cell.itemBtn setTitle:_navTitles[indexPath.row] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = _tableViewCount > kMaxCollectionItemCount ? kMaxCollectionItemCount : _tableViewCount;
    return CGSizeMake(kScreenSize.width / count, CGRectGetHeight(collectionView.frame));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentSelectItemIndex = indexPath.row;
    
    [_scrollView setContentOffset:CGPointMake(kScreenSize.width * _currentSelectItemIndex, 0) animated:YES];
    
    [self updateCollectionViewOffsetAtIndexPath:indexPath];
    [self headerBtnDidSelectAtIndex:indexPath]; // 调用对外按钮访问函数
    
    [collectionView reloadData];
}

#pragma mark - ---events---

#pragma mark 下拉刷新触发函数
- (void)tableViewPullDownRefresh {
    NSInteger index = _scrollView.contentOffset.x / kScreenSize.width;
    UITableView *tableView = _tableViews.count > index ? [_tableViews objectAtIndex:index] : nil;
    [self tableViewPullDownRefresh:tableView];
}

#pragma mark 上拉刷新触发函数
- (void)tableViewPullUpRefresh {
    NSInteger index = _scrollView.contentOffset.x / kScreenSize.width;
    UITableView *tableView = _tableViews.count > index ? [_tableViews objectAtIndex:index] : nil;
    [self tableViewPullUpRefresh:tableView];
}

#pragma mark tableVew网络访问错误触发函数
- (void)networkReloadDataAction:(UIButton *)sender {
    NSInteger index = _scrollView.contentOffset.x / kScreenSize.width;
    [self tableView:_tableViews[index] networkReloadDataAction:sender];
}

#pragma mark - ---setting getting---

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.customHeaderView.frame) + 64, kScreenSize.width, 44) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerNib:[UINib nibWithNibName:@"WScrollHeaderCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"WScrollHeaderCollectionCell"];
        _collectionView = collectionView;
    }
    
    return _collectionView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), kScreenSize.width, kScreenSize.height + 20 - CGRectGetMaxY(self.collectionView.frame))];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    
    return _scrollView;
}

- (void)setNavTitles:(NSArray *)navTitles {
    _navTitles = navTitles;
    
    if (navTitles.count != _tableViewCount) {
        [self showHint:@"导航按钮数目与列表数不一致"];
        
    } else {
        [_collectionView reloadData];
    }
}

- (void)setSelectedLineColor:(UIColor *)selectedLineColor {
    _selectedLineColor = selectedLineColor;
    
    _selectedLine.backgroundColor = selectedLineColor;
}

- (void)setSelectedNavTextColor:(UIColor *)selectedNavTextColor {
    _selectedNavTextColor = selectedNavTextColor;
    
    [_collectionView reloadData];
}

- (void)setNormalNavTextColor:(UIColor *)normalNavTextColor {
    _normalNavTextColor = normalNavTextColor;
    
    [_collectionView reloadData];
}

@end
