//
//  RequestPostUploadHelper.h
//  sub-EXG
//
//  Created by mac on 15/9/1.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLRequestSerialization.h"

@interface AFHTTPRequestHelper : NSObject
/**
 *POST 提交 并可以上传图片目前只支持单张
 */
- (void)uploadImageDataWithURL: (NSString * _Nullable)url  // IN
                    postParems: (NSMutableDictionary * _Nullable)postParems // IN
                   picFilePath: (NSString * _Nullable)picFilePath  // IN
                   picFileName: (NSString * _Nullable)picFileName  // IN
                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (void)downloadFileWithURL:(NSString * _Nullable)url
                 postParems:(NSMutableDictionary * _Nullable)postParems
                  savedPath:(NSString * _Nullable)savedPath
            downloadSuccess:(nullable void (^)(NSURLSessionDownloadTask * _Nullable operation, id _Nullable responseObject))success
            downloadFailure:(nullable void (^)(NSURLSessionDownloadTask * _Nullable operation, NSError * _Nullable error))failure
                   progress:(nullable void (^)(float progress))progress;

@end
