//
//  ZWViewController.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBaseViewController.h"

@interface WBaseViewController ()

@end

@implementation WBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航title字体，字体颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                     [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    // 修改导航返回按钮字体，阴影，字体颜色
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                    [UIFont systemFontOfSize:16], NSFontAttributeName,
                                    nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:0];
    
    // 修改UIBarButtonItem中文字的位置
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(3, -1) forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 左侧导航按钮懒加载
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 50, 44);
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:kScreenSize.width < 375 ? 14 : 15];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = barBtn;
    }
    
    return _navLeftBtn;
}

#pragma mark 右侧导航按钮懒加载
- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 50, 44);
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:kScreenSize.width < 375 ? 14 : 15];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = barBtn;
    }
    
    return _navRightBtn;
}

#pragma mark 网络请求失败view懒加载
- (UIView *)reloadNetworkView {
    if (!_reloadNetworkView) {
        UIView *reloadCoverView = [[UIView alloc] initWithFrame:self.view.bounds];
        reloadCoverView.backgroundColor = [UIColor clearColor];
        
        CGFloat viewHeight = 90;
        UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, viewHeight)];
        refreshView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        refreshView.layer.masksToBounds = YES;
        refreshView.layer.cornerRadius = 4.0;
        refreshView.center = reloadCoverView.center;
        [reloadCoverView addSubview:refreshView];
        
        CGSize reloadLabelSize = CGSizeMake(CGRectGetWidth(refreshView.frame), 35);
        UILabel *reloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, reloadLabelSize.width, reloadLabelSize.height)];
        reloadLabel.font = [UIFont systemFontOfSize:13];
        reloadLabel.textColor = [UIColor whiteColor];
        reloadLabel.text = kNetworkConnectFailTip;
        reloadLabel.textAlignment = NSTextAlignmentCenter;
        [refreshView addSubview:reloadLabel];
        
        CGSize reloadBtnSize = CGSizeMake(70, 25);
        UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reloadBtn.frame = CGRectMake((CGRectGetWidth(refreshView.frame) - reloadBtnSize.width) / 2, CGRectGetMaxY(reloadLabel.frame) + 5, reloadBtnSize.width, reloadBtnSize.height);
        reloadBtn.backgroundColor = kColorRGB(54, 201, 251, 1);
        [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        reloadBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        reloadBtn.layer.masksToBounds = YES;
        reloadBtn.layer.cornerRadius = 5.0;
        [reloadBtn addTarget:self action:@selector(reloadNetworkDataAction:) forControlEvents:UIControlEventTouchUpInside];
        [refreshView addSubview:reloadBtn];
        
        _reloadNetworkView = reloadCoverView;
    }
    
    return _reloadNetworkView;
}

#pragma mark -

- (void)reloadNetworkDataAction:(UIButton *)sender {
    NSLog(@"ZWViewController reloadNetworkData");
}

- (void)showReloadNetworkViewAddedTo:(UIView *)view {
    [view addSubview:self.reloadNetworkView];
}

- (void)hideReloadNetworkView {
    [_reloadNetworkView removeFromSuperview];
    _reloadNetworkView = nil;
}

@end
