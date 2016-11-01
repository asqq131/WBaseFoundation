//
//  UIViewController+TransitionAnimationViewController.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TransitionAnimation)

- (void)transitionRootViewWithController:(UIViewController * __nonnull)vc
                                duration:(NSTimeInterval)duration
                                 options:(UIViewAnimationOptions)options
                              completion:(void (^ __nullable)(BOOL finished))completion;

- (void)transitionToController:(UIViewController * __nonnull)tvc
                      duration:(NSTimeInterval)duration
                       options:(UIViewAnimationOptions)options
                    completion:(void (^ __nullable)(BOOL finished))completion;

@end
