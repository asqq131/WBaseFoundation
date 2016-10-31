//
//  UIImage+Transform.h
//  CRM-Demo
//
//  Created by HZwu on 14-9-5.
//  Copyright (c) 2014年 softgoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IMTransform)

/*
 *图片大小裁剪
 */
//+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize;
+ (UIImage *)scaleToImage:(UIImage *)image toSize:(CGSize)size;

/*
 *旋转图片
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

@end
