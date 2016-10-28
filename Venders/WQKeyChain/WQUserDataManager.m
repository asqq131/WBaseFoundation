//
//  WQUserDataManager.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WQUserDataManager.h"
#import "WQKeyChain.h"

@implementation WQUserDataManager

static NSString * const KEY_IN_KEYCHAIN = @"com.app.allinfo";
static NSString * const KEY_PASSWORD = @"com.app.password";

+ (void)savePassWord:(NSString *)password {
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [WQKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+ (id)readPassWord {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[WQKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+ (void)deletePassWord {
    [WQKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
