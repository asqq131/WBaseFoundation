//
//  NSString+IPAddresses.h
//  CloudPurchaseEra
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPAddresses : NSObject

/** 获取网卡的硬件地址 **/
- (NSString *)macaddress;
/** 外网可见的ip地址，如果你在小区的局域网中，那就是小区的，不是局域网的内网地址 **/
- (NSString *)whatismyipdotcom;
/** 获取本地wifi的ip地址 **/
- (NSString *)localWiFiIPAddress;
/** 获取host的名称 **/
- (NSString *)hostname;
/** 从host获取地址 **/
- (NSString *)getIPAddressForHost: (NSString *) theHost;
/** 本地host的IP地址 **/
- (NSString *)localIPAddress;

/** NSString和Address的转换 **/
+ (NSString *)stringFromAddress: (const struct sockaddr *) address;
+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address;

@end
