//
//  SecondViewController.m
//  sub-EXG
//
//  Created by mac on 8/21/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "WBaseNavigationCtrl.h"
#import "WConstants.h"

@interface WBaseNavigationCtrl ()

@end

@implementation WBaseNavigationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏背景色
//    [[UINavigationBar appearance] setBarTintColor:kColorRGB(54, 201, 251, 1)];

    //给navigationBar设置背景图片
    self.navigationBar.shadowImage = [UIImage new];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:kResourceSrcName(@"nav_bg")]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
//    self.navigationBar.layer.shadowOpacity = 1;
//    self.navigationBar.layer.shadowColor = [UIColor colorWithRed:54.0/255.0 green:201.0/255.0 blue:251.0/255.0 alpha:1.0].CGColor;
    
    // 设置导航title颜色
    // [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:16.0], NSFontAttributeName 标题字体大小，且只改标题
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    
    // 自定义返回按钮图标
    UIImage *backButtonImage = [[UIImage imageNamed:kResourceSrcName(@"ic_back")] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
