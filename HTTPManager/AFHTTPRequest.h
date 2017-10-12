//
//  SuSNetwork.h
//  SuS
//
//  Created by HZwu on 14-11-29.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

//NSString *KDefaultErrorMessage = @"网络似乎不太顺畅，请稍后重试!";
#define KDefaultErrorMessage @"网络似乎不太顺畅，请稍后重试!"

typedef NS_ENUM(NSInteger, ResponseObjectCodeType){
    //    ResponseObjectCodeTypeIllegal = 0,
    ResponseObjectCodeTypeLegal = 200000
//    ResponseObjectCodeTypeUserNotLogin = 400009
};

/*
 请求服务器成功后的回调block
 */
typedef void(^SuccessCompletionBlock)(BOOL success, NSString * _Nullable msg, id _Nullable responseObject);

/*
 请求服务器失败后的回调block
 */
typedef void(^FailureCompletionBlock)(NSError * _Nullable error);

@interface AFHTTPRequest : NSObject

+ (instancetype _Nullable)shareInstance;

// 通用接口
- (nullable NSURLSessionDataTask *)baseRequestWithMethod:(NSString * _Nullable)method
                                           urlString:(NSString * _Nullable)urlString
                                          parameters:(NSDictionary * _Nullable)parameters
                                            progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                             success:(nullable SuccessCompletionBlock)success
                                             failure:(nullable FailureCompletionBlock)failure;

- (nullable NSURLSessionDataTask *)GetWithUrlString:(NSString * _Nullable)urlString
                        parameters:(NSDictionary * _Nullable)parameters
                            success:(nullable SuccessCompletionBlock)success
                            failure:(nullable FailureCompletionBlock)failure;

- (nullable NSURLSessionDataTask *)PostWithUrlString:(NSString * _Nullable)urlString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                                success:(nullable SuccessCompletionBlock)success
                                failure:(nullable FailureCompletionBlock)failure;

@end
