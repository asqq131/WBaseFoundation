//
//  NSString+CalculateSize.h
//  CloudPurchaseEra
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (CalculateSize)

- (CGSize)calculateSizeAtWidth:(CGFloat)width font:(UIFont *)font;

@end
