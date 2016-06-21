//
//  NSString+ThreeDES.h
//  3DE
//
//  Created by Brandon Zhu on 31/10/2012.
//  Copyright (c) 2012 Brandon Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ThreeDES)

+ (NSString *)threeDesEncrypt:(NSString*)plainText;
+ (NSString *)threeDesDecrypt:(NSString*)encryptText;

- (NSString *)threeDesEncrypt;
- (NSString *)threeDesDecrypt;

@end
