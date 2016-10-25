//
//  NSString+GenerateUuid.m
//  efangxue_teacher
//
//  Created by mac on 16/1/15.
//  Copyright © 2016年 macmini. All rights reserved.
//

#import "NSString+GenerateUuid.h"

@implementation NSString (GenerateUuid)

#pragma mark 生成GUID
+ (NSString *)generateUuidString {
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    // transfer ownership of the string
    // to the autorelease pool
    //    [uuidString autorelease];
    
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}

@end
