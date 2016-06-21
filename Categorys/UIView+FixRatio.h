//
//  UIView+FixRatio.h
//  ZWScrollTableViewCtrl
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FixRatio)

/** 按iPhone6的比例缩放 **/
+ (CGFloat)fixRatioHeightByIphone6:(CGFloat)height;
+ (CGFloat)fixRatioWidthByIphone6:(CGFloat)width;

@end
