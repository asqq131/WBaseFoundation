//
//  UIView+UIView_EmpyFalseDataView.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EmpyFalseDataView)

/** 设置空数据view，图标和提示传nil或空则使用默认值 **/
- (void)setupEmptyDataViewWith:(UIImage *)image tipText:(NSString *)tip yOffset:(float)yOffset;
/** 设置网络请求失败view，图标和提示传nil或空则使用默认值 **/
- (void)setupNetworkReloadViewWith:(UIImage *)image tipText:(NSString *)tip yOffset:(float)yOffset;

/** 获取空数据view关联 **/
- (UIView *)getEmptyDataViewKey;
/** 获取网络请求失败view关联 **/
- (UIView *)getNetworkReloadViewKey;
/** 必须先初始化NetworkReloadView **/
- (UIButton *)getNetworkReloadBtnKey;

@end
