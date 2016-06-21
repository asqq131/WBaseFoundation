//
//  ZWViewController.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+HUD.h"

@interface WBaseViewController : UIViewController

/** 导航栏左侧按钮 **/
@property (nonatomic, strong) UIButton *navLeftBtn;
/** 导航栏右侧按钮 **/
@property (nonatomic, strong) UIButton *navRightBtn;
/** 网络请求失败view **/
@property (nonatomic, strong) UIView *reloadNetworkView;
/** 空数据view **/
@property (nonatomic, strong) UIView *emptyDataView;

/** 创建网络请求失败view **/
- (void)showReloadNetworkViewAddedTo:(UIView *)view;
/** 删除网络请求失败view **/
- (void)hideReloadNetworkView;
/** 网络重新加载按钮事件 **/
- (void)reloadNetworkDataAction:(UIButton *)sender;

@end
