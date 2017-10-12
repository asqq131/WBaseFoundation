//
//  ZWBaseTabBarController.m
//  ZW-WeChat
//
//  Created by HZwu on 14-9-12.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "WBaseTabBarCtrl.h"
#import "WFrostedRootViewCtrl.h"
#import "WConstants.h"

@interface WBaseTabBarCtrl () {
    
}

@end

@implementation WBaseTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setupTabBar];
    
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuViewCtrlAtNotification:) name:kNotificationNameByMenuSelected object:nil];

#pragma mark 测试调用，实际应该在嵌入tabBarCtrl中的控制器调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_frostedRootViewController addPanGestureToMainView];
    });
}

- (void)setupTabBar {
    // 拿到 TabBar 在拿到想应的item
    UITabBar *tabBar = self.tabBar;
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // ios7上会有个底色，去除底色的方法
    //    [tabBar setBackgroundImage:[UIImage new]];
    //    [tabBar setShadowImage:[UIImage new]];
    // 但是还有条线，出现线的解决办法
    //    tabBar.clipsToBounds = YES;
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    // 使用UITabBarItem时，如需使用自定义颜色的选中图时，需设置UIImageRenderingModeAlwaysOriginal
    item0.image = [[UIImage imageNamed:@"icon_home_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.selectedImage = [[UIImage imageNamed:@"icon_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"icon_student_defaulte"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"icon_student_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"icon_news_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"icon_news_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [item0 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorRGB(153, 153, 153, 1), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [item0 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorRGB(54, 201, 251, 1), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorRGB(153, 153, 153, 1), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorRGB(54, 201, 251, 1), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorRGB(153, 153, 153, 1), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorRGB(54, 201, 251, 1), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

#pragma mark - 获取侧滑菜单点击通知，进行页面切换
- (void)menuViewCtrlAtNotification:(NSNotification *)sender {
    NSIndexPath *indexPath = sender.object; // 获取切换点击行
    [self menuViewCtrlDidSelectAt:indexPath];
}

- (void)menuViewCtrlDidSelectAt:(NSIndexPath *)indexPath {
    NSLog(@"ZWBaseTabBarCtrl menuViewCtrlDidSelectAt");
    
#pragma mark 侧滑菜单响应处理示例 -> 可复写
    UINavigationController *navigationCtrl = self.viewControllers[self.selectedIndex];
    navigationCtrl.topViewController.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.row == 2) { // 给软件评分
        // itms-apps://itunes.apple.com/app/id%@ 和 itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+software&id%@
        NSString *urlString = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+software&id%@", kAppItunesId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

- (void)dealloc {
    [self unObserveAllNotifications];
}

- (void)unObserveAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNameByMenuSelected object:nil];
}

@end
