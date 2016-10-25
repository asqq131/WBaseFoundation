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

// 通用接口
+ (nullable NSURLSessionDataTask *)baseRequestWithMethod:(NSString * _Nullable)method
                                           urlString:(NSString * _Nullable)urlString
                                          parameters:(NSDictionary * _Nullable)parameters
                                            progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                             success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

+ (nullable NSURLSessionDataTask *)GetWithUrlString:(NSString * _Nullable)urlString
                        parameters:(NSDictionary * _Nullable)parameters
                            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

+ (nullable NSURLSessionDataTask *)PostWithUrlString:(NSString * _Nullable)urlString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

@end
