//
//  UIScrollView+Refresh.h
//  CloudPurchaseEra
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface UIScrollView (Refresh)

- (void)setupPullDownRefreshWithTarget:(id)target refreshingAction:(SEL)action;
- (void)setupPullUpRefreshWithhTarget:(id)target refreshingAction:(SEL)action;

@end
