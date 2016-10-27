//
//  UIView+UIView_EmpyFalseDataView.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EmpyFalseDataView)

/** 设置网络请求失败view，图标和提示传nil或空则使用默认值 **/
- (void)setupNetworkReloadViewWithImageString:(NSString *)imageString
                           tipText:(NSString *)tip
                           btnText:(NSString *)btnText
                            margin:(UIEdgeInsets)margin
                      yImageOffset:(float)yOffset;

- (void)setNetworkReloadViewHidden:(BOOL)hidden;
- (void)showNetworkReloadViewWithTip:(NSString *)tip btnString:(NSString *)btnString;
- (void)emptyButtonAddTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/** 设置空数据view，图标和提示传nil或空则使用默认值，按钮text传nil或空则隐藏 **/
- (void)setupEmptyDataViewWithImageString:(NSString *)imageString
                                  tipText:(NSString *)tip
                                  btnText:(NSString *)btnText
                                   margin:(UIEdgeInsets)margin
                             yImageOffset:(float)yOffset;

- (void)setEmptyViewHidden:(BOOL)hidden;
- (void)showEmptyViewWithTip:(NSString *)tip btnString:(NSString *)btnString;
- (void)networkReloadButtonAddTarget:(id)target
                              action:(SEL)action
                    forControlEvents:(UIControlEvents)controlEvents;

/** 获取空数据view关联 **/
- (UIView *)getEmptyDataViewKey;
/** 获取网络请求失败view关联 **/
- (UIView *)getNetworkReloadViewKey;

@end
