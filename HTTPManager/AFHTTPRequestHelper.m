//
//  RequestPostUploadHelper.m
//  sub-EXG
//
//  Created by mac on 15/9/1.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AFHTTPRequestHelper.h"
#import "AFHTTPRequest.h"

@implementation AFHTTPRequestHelper

#pragma mark 图片上传
- (void)uploadImageDataWithURL:(NSString * _Nullable)url  // IN
            postParems:(NSMutableDictionary * _Nullable)postParems // IN
           picFilePath:(NSString * _Nullable)picFilePath  // IN
           picFileName:(NSString * _Nullable)picFileName  // IN
        success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    //得到图片的data
    NSData* data;
    if(picFilePath){
        UIImage *image = [UIImage imageWithContentsOfFile:picFilePath];
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
        } else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.0);
        }
    }
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@", kMainAPIDomain, url] parameters:postParems constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data
                                    name:@"imgFile"
                                fileName:picFileName
                                mimeType:@"image/jpeg"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
//                          [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          failure(uploadTask, error);
                          
                      } else {
                          success(uploadTask, responseObject);
                      }
                  }];
    
    [uploadTask resume];
}

#pragma mark 文件/图片下载
- (void)downloadFileWithURL:(NSString *)url
                 postParems: (NSMutableDictionary *)postParems
                     savedPath:(NSString *)savedPath
               downloadSuccess:(void (^)(NSURLSessionDownloadTask *operation, id responseObject))success
               downloadFailure:(void (^)(NSURLSessionDownloadTask *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat currentProgress = (float)downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        progress(currentProgress);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:savedPath];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            failure(downloadTask, error);
        } else {
            success(downloadTask, response);
        }
    }];
    
    [downloadTask resume];
}

@end
