//
//  SuSNetwork.h
//  SuS
//
//  Created by HZwu on 14-11-29.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface AFHTTPRequest : NSObject

//+ (instancetype)client;

+ (nullable NSURLSessionDataTask *)requestGetByUrlString:(NSString * _Nullable)urlString
                        parameters:(NSDictionary * _Nullable)parameters
                            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

+ (nullable NSURLSessionDataTask *)requestDeleteByUrlString:(nullable NSString *)urlString
                        parameters:(NSDictionary * _Nullable)parameters
                            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

+ (nullable NSURLSessionDataTask *)requestPostByUrlString:(NSString * _Nullable)urlString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

@end
