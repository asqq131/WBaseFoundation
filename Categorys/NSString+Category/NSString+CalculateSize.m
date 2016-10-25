//
//  NSString+CalculateSize.m
//  CloudPurchaseEra
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "NSString+CalculateSize.h"

@implementation NSString (CalculateSize)

- (CGSize)calculateSizeAtWidth:(CGFloat)width font:(UIFont *)font {
    NSDictionary *attrib = @{NSFontAttributeName: font}; // 字体大小
    // MAXFLOAT(值很大)为最大的高度，可以认为高度不限 限定正文的最大宽度
    CGSize contentSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrib context:nil].size;
    
    return contentSize;
}

@end
