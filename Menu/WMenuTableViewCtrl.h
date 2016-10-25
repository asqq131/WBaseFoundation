//
//  MenuTableTableViewController.h
//  sub-EXG
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFrostedRootViewCtrl;
@interface WMenuTableViewCtrl : UITableViewController

/*
 * 侧滑主控制器
 */
@property (nonatomic, weak) WFrostedRootViewCtrl *frostedViewController;

@end
