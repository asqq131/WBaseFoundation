//
//  UIView+FixRatio.m
//  ZWScrollTableViewCtrl
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+FixRatio.h"

@implementation UIView (FixRatio)

+ (CGFloat)fixRatioHeightByIphone6:(CGFloat)height {
    return (height / 647.0) * [UIScreen mainScreen].applicationFrame.size.height;
}

+ (CGFloat)fixRatioWidthByIphone6:(CGFloat)width {
    return (width / 375.0) * [UIScreen mainScreen].applicationFrame.size.width;
}

@end
