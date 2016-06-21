//
//  UIScrollView+Refresh.m
//  CloudPurchaseEra
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)

- (void)setupPullDownRefreshWithTarget:(id)target refreshingAction:(SEL)action {
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    self.mj_header = refreshHeader;
}

- (void)setupPullUpRefreshWithhTarget:(id)target refreshingAction:(SEL)action {
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    refreshFooter.automaticallyHidden = YES;
    self.mj_footer = refreshFooter;
}

@end
