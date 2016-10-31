//
//  UIViewController+TransitionAnimationViewController.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TransitionAnimation)

- (void)transitionWithController:(UIViewController * __nonnull)vc
                  duration:(NSTimeInterval)duration
                   options:(UIViewAnimationOptions)options
                completion:(void (^ __nullable)(BOOL finished))completion;

@end
