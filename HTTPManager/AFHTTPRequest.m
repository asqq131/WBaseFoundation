//
//  SuSNetwork.m
//  SuS
//
//  Created by HZwu on 14-11-29.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "AFHTTPRequest.h"
#import "NSString+ThreeDES.h"
#import "NSString+MD5Encrypt.h"
#import "RSAEncryptor.h"
#import "WConstants.h"

@implementation AFHTTPRequest

#pragma mark 优化
static AFHTTPSessionManager *_manager = nil;

+ (instancetype)shareInstance {
    static AFHTTPRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
        
#pragma mark https配置
        // 站点证书
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@".cer"];
//        NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
//        NSSet *cerSet = [NSSet setWithObjects:cerData, nil];
//        
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//        // 如果需要验证自建证书，需要设置为YES
//        securityPolicy.allowInvalidCertificates = YES;
//        // validatesDomainName 是否需要验证域名，默认为YES
//        securityPolicy.validatesDomainName = YES;
//        // 添加站点证书
//        [securityPolicy setPinnedCertificates:cerSet];
        
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil, nil];
        
//        manager.securityPolicy = securityPolicy;
        
        //    manager.requestSerializer.timeoutInterval = 60.0; // 超时请求，默认60秒
    });
    
    return _sharedClient;
}

- (nullable NSURLSessionDataTask *)baseRequestWithMethod:(NSString *)method
                                            urlString:(NSString * _Nullable)urlString
                                            parameters:(NSDictionary * _Nullable)parameters
                                            progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                            success:(SuccessCompletionBlock)success
                                            failure:(FailureCompletionBlock)failure
{
    DebugLog(@"接口 URL-> %@", urlString);
    DebugLog(@"参数-> %@", parameters);
    
    if ([method isEqualToString:@"GET"]) {
        return [_manager GET:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DebugLog(@"GET请求完成");
            
            NSString *code = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
            NSString *msg = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"message"]];
//            if ([code integerValue] == ResponseObjectCodeTypeUserNotLogin) {
//                success([code integerValue] == ResponseObjectCodeTypeLegal, @"请求失败，请重新点击", responseObject);
//            } else {
                success([code integerValue] == ResponseObjectCodeTypeLegal, msg, responseObject);
//            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DebugLog(@"GET请求失败: %@", error);
            failure(error);
        }];
        
    } else if ([method isEqualToString:@"POST"]) {
        return [_manager POST:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DebugLog(@"POST请求完成");
            
            NSString *code = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"status"]];
            NSString *msg = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"message"]];
//            if ([code integerValue] == ResponseObjectCodeTypeUserNotLogin) {
//                success([code integerValue] == ResponseObjectCodeTypeLegal, @"请求失败，请重新点击", responseObject);
//            } else {
                success([code integerValue] == ResponseObjectCodeTypeLegal, msg, responseObject);
//            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DebugLog(@"POST请求失败: %@", error);
            failure(error);
        }];
        
    } else {
        return nil;
    }
}

#pragma mark 网络请求GET类方法
- (nullable NSURLSessionDataTask *)GetWithUrlString:(NSString * _Nullable)urlString
                            parameters:(NSDictionary * _Nullable)parameters
                            success:(SuccessCompletionBlock)success
                            failure:(FailureCompletionBlock)failure
{
    return [self baseRequestWithMethod:@"GET" urlString:urlString parameters:parameters progress:nil success:success failure:failure];
}

#pragma mark 网络请求POST类方法
- (nullable NSURLSessionDataTask *)PostWithUrlString:(NSString * _Nullable)urlString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                success:(SuccessCompletionBlock)success
                                failure:(FailureCompletionBlock)failure
{
    return [self baseRequestWithMethod:@"POST" urlString:urlString parameters:parameters progress:uploadProgress success:success failure:failure];
}

@end
