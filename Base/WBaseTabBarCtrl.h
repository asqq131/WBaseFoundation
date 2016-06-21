//
//  ZWBaseTabBarController.h
//  ZW-WeChat
//
//  Created by HZwu on 14-9-12.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFrostedRootViewCtrl;
@interface WBaseTabBarCtrl : UITabBarController

@property (weak, nonatomic) WFrostedRootViewCtrl *frostedRootViewController;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

- (void)menuViewCtrlDidSelectAt:(NSIndexPath *)indexPath;

@end
