//
//  WQUserDataManager.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQUserDataManager : NSObject

+ (void)savePassWord:(NSString *)password;
+ (id)readPassWord;
+ (void)deletePassWord;

@end
