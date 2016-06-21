//
//  FrostedRootViewController.m
//  sub-EXG
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "WFrostedRootViewCtrl.h"
#import "WBaseTabBarCtrl.h"
#import "WMenuTableViewCtrl.h"

@interface WFrostedRootViewCtrl () <UIGestureRecognizerDelegate> {
    CGFloat _distance;
    CGFloat _FullDistance;
    CGFloat _Proportion;
    CGPoint _centerOfLeftViewAtBeginning;
    CGFloat _proportionOfLeftView;
    CGFloat _distanceOfLeftView;
    
    UITapGestureRecognizer *_tapGesture;
    
    CGFloat _menuDefaultCenerX;
}

@end

@implementation WFrostedRootViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _distance = 0;
    _FullDistance = 0.95; // 0.78
    _Proportion = 0.82; // 0.77
    _proportionOfLeftView = 1;
    _distanceOfLeftView = 50;
    
    // 侧滑背景图
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    NSString *imageString;
    if (kIsIphone4s) {
        imageString = kResourceSrcName(@"menu_bg_960");
    } else if (kIsIphone5) {
        imageString = kResourceSrcName(@"menu_bg_1136");
    } else {
        imageString = kResourceSrcName(@"menu_bg_1334");
    }
    
    bgImageView.image = [UIImage imageNamed:imageString];
    [self.view addSubview:_bgImageView = bgImageView];
    
    // 通过 StoryBoard 取出左侧侧滑菜单视图
//    _leftTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ZWMenuTableViewCtrl"];
    _leftTableViewController = [[WMenuTableViewCtrl alloc] init];
    
    // 适配 4.7 和 5.5 寸屏幕的缩放操作，有偶发性小 bug
//    if (kScreenSize.width > 320) {
//        _proportionOfLeftView = kScreenSize.width / 320;
//        _distanceOfLeftView += (kScreenSize.width - 320) * _FullDistance / 2;
//    }
    
    _leftTableViewController.view.center = CGPointMake(_leftTableViewController.view.center.x-50, _leftTableViewController.view.center.y);
    _leftTableViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    _centerOfLeftViewAtBeginning = _leftTableViewController.view.center;
    _leftTableViewController.frostedViewController = self;
    [self.view addSubview:_leftTableViewController.view];
    
    _menuDefaultCenerX = _centerOfLeftViewAtBeginning.x;
    
    // 在侧滑菜单之上增加黑色遮罩层，目的是实现视差特效
    UIView *blackCover = [[UIView alloc] initWithFrame:self.view.frame];
    blackCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_blackCover = blackCover];
    [self.view bringSubviewToFront:_blackCover];
    
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.frame];
    
//    _tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"ZWBaseTabBarCtrl"];
    _tabBarController = [[WBaseTabBarCtrl alloc] init];
    _tabBarController.frostedRootViewController = self;
    
    [mainView addSubview:_tabBarController.view];
    [mainView bringSubviewToFront:_tabBarController.view];
    
    [self.view addSubview:_mainView = mainView];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHome)];
}

#pragma 删除手指侧滑手势
- (void)removePanGestureFromMainView {
    [_mainView removeGestureRecognizer:_tabBarController.panGesture];
}

#pragma 添加手指侧滑手势
- (void)addPanGestureToMainView {
    // 绑定 UIPanGestureRecognizer
    _tabBarController.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    UIPanGestureRecognizer *panGesture = _tabBarController.panGesture;
//    [panGesture addTarget:self action:@selector(panHandle:)];
    [_mainView addGestureRecognizer:panGesture];
}

#pragma 侧滑手势触发事件
- (void)panHandle:(UIPanGestureRecognizer *)recongnizer {
    CGFloat x = [recongnizer translationInView:self.view].x;
    
    CGFloat trueDistance = _distance + x; // 实时距离
    CGFloat trueProportion = trueDistance / (kScreenSize.width*_FullDistance);
    
    // 如果 UIPanGestureRecognizer 结束，则激活自动停靠
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        if (trueDistance > kScreenSize.width * (_Proportion / 3)) {
            [self showLeft];
        }
//        else if (trueDistance < kScreenSize.width * -(_Proportion / 3)) {
////            [self showRight];
//            return;
//            
//        }
        else {
            [self showHome];
        }
        
        return;
    }
    
#pragma 禁止右侧划
    //if (trueDistance < kScreenSize.width * -(1 / 3)) {
    if (trueDistance < 0 && _menuPanType == MenuPanTypeHome) {
        // 禁止右侧划
        return;
    }
    
    // 计算缩放比例
    CGFloat proportion = recongnizer.view.frame.origin.x >= 0 ? -1 : 1;
    proportion *= trueDistance / kScreenSize.width;
    proportion *= 1 - _Proportion;
    proportion /= 0.6; // 设定手指移动最大距离为0.6x
    proportion += 1;
    if (proportion <= _Proportion || proportion > 1) { // 若比例已经达到最小，则不再继续动画;proportion > 1禁止右侧滑
        return;
    }
    
    // 执行视差特效
    _blackCover.alpha = (proportion - _Proportion) / (1 - _Proportion);
    // 执行平移和缩放动画
    recongnizer.view.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y);
    recongnizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
    // 执行左视图动画
    CGFloat pro = 0.8 + (_proportionOfLeftView - 0.8) * trueProportion;
    _leftTableViewController.view.center = CGPointMake(_centerOfLeftViewAtBeginning.x + _distanceOfLeftView * trueProportion, _centerOfLeftViewAtBeginning.y - (_proportionOfLeftView - 1) * _leftTableViewController.view.frame.size.height * trueProportion / 2);
    _leftTableViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);
}

// 封装三个方法，便于后期调用

#pragma 展示左视图
- (void)showLeft {
    [_tabBarController.view addGestureRecognizer:_tapGesture];
    
    self.menuPanType = MenuPanTypeLeft;
    
    _distance = self.view.center.x * (_FullDistance + _Proportion / 2);
    [self doTheAnimate:_Proportion];
}

#pragma 展示主视图
- (void)showHome {
    [_tabBarController.view removeGestureRecognizer:_tapGesture];
    
    self.menuPanType = MenuPanTypeHome;
    
    _distance = 0;
    [self doTheAnimate:1];
}

#pragma 展示右视图
- (void)showRight {
    [_tabBarController.view addGestureRecognizer:_tapGesture];
    
    self.menuPanType = MenuPanTypeRight;
    
    _distance = self.view.center.x * -(_FullDistance + _Proportion / 2);
    [self doTheAnimate:_Proportion];
}

#pragma 执行三种试图展示
- (void)doTheAnimate:(CGFloat)proportion {
    [UIView animateWithDuration:.3 animations:^{
        _mainView.center = CGPointMake(self.view.center.x + _distance, self.view.center.y);
        _mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
        if (self.menuPanType == MenuPanTypeLeft) {
            // 移动左侧菜单的中心
            _leftTableViewController.view.center = CGPointMake(_centerOfLeftViewAtBeginning.x + _distanceOfLeftView, _leftTableViewController.view.center.y);
            // 缩放左侧菜单
            _leftTableViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, _proportionOfLeftView, _proportionOfLeftView);
            
        } else if (self.menuPanType == MenuPanTypeHome) {
            // 左菜单恢复默认设置
            _leftTableViewController.view.center = CGPointMake(_menuDefaultCenerX, _leftTableViewController.view.center.y);
            _leftTableViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
            _centerOfLeftViewAtBeginning = _leftTableViewController.view.center;
        }
        
        // 改变黑色遮罩层的透明度，实现视差效果
        _blackCover.alpha = self.menuPanType == MenuPanTypeHome ? 1 : 0;
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
