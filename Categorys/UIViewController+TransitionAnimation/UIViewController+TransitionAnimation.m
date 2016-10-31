//
//  UIViewController+TransitionAnimationViewController.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIViewController+TransitionAnimation.h"

@implementation UIViewController (TransitionAnimation)

/**
 //转场动画相关的
 
 UIViewAnimationOptionTransitionNone            //无转场动画
 
 UIViewAnimationOptionTransitionFlipFromLeft    //转场从左翻转
 
 UIViewAnimationOptionTransitionFlipFromRight   //转场从右翻转
 
 UIViewAnimationOptionTransitionCurlUp          //上卷转场
 
 UIViewAnimationOptionTransitionCurlDown        //下卷转场
 
 UIViewAnimationOptionTransitionCrossDissolve   //转场交叉消失
 
 UIViewAnimationOptionTransitionFlipFromTop     //转场从上翻转
 
 UIViewAnimationOptionTransitionFlipFromBottom  //转场从下翻转
 **/

- (void)transitionWithController:(UIViewController * __nonnull)vc
                        duration:(NSTimeInterval)duration
                         options:(UIViewAnimationOptions)options
                      completion:(void (^ __nullable)(BOOL finished))completion {
    
    [UIView transitionWithView:self.view.window
                      duration:duration
                       options:options
                    animations:^(void) {
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        self.view.window.rootViewController = vc;
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:completion];
}

@end
