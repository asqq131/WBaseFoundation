//
//  NSString+MD5Encrypt.h
//  efangxue_teacher
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5Encrypt)

- (NSString *)md5Encrypt_32Bit;
+ (NSString *)stringFormMD5Encrypt_32BitWithString:(NSString *)string;

@end
