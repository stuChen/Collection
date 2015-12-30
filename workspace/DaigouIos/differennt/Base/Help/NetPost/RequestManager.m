//
//  RequestManager.m
//  Sahara
//
//  Created by Chen on 15/6/12.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

//上传请求
+ (void)PostUrl:(NSString *)url loding:(NSString *)loding dic:(NSDictionary *)dic response:(void (^)(id))response
{
    /**
     *  @brief  检查是否网络畅通
     */
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status == AFNetworkReachabilityStatusNotReachable) {
             [SVProgressHUD showErrorWithStatus:@"无网络连接！"];
             return;
         }
     }];
    [afNetworkReachabilityManager stopMonitoring];
    //加载图
    if (loding) {
        [SVProgressHUD showWithStatus:loding];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer   = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 20;
    //responseSerializer
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    NSSet *acceptContentType = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
    [responseSerializer setAcceptableContentTypes:acceptContentType];
    manager.responseSerializer = responseSerializer;
    //在向服务端发送请求状态栏显示网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager.requestSerializer setValue:@"female" forHTTPHeaderField:@"DifferentClassify"];
    //请求
    [manager POST:url
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              //请求结束状态栏隐藏网络活动标志：
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              response(responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              //请求结束状态栏隐藏网络活动标志：
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              response(nil);
          }];
    
}
+ (void)GETUrl:(NSString *)url
        loding:(NSString *)loding
           dic:(NSDictionary *)dic
      response:(void(^)(id response))response {
    /**
     *  @brief  检查是否网络畅通
     */
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status == AFNetworkReachabilityStatusNotReachable) {
             [SVProgressHUD showErrorWithStatus:@"无网络连接！"];
             return;
         }
     }];
    [afNetworkReachabilityManager stopMonitoring];
    //加载图
    if (loding) {
        [SVProgressHUD showWithStatus:loding];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer   = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 20;
    //responseSerializer
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    NSSet *acceptContentType = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
    [responseSerializer setAcceptableContentTypes:acceptContentType];
    manager.responseSerializer = responseSerializer;
    //在向服务端发送请求状态栏显示网络活动标志：
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //请求
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        response(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        //请求结束状态栏隐藏网络活动标志：
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        response(nil);
    }];
}
//上传图片
+(void)updatePic:(NSData *)data response:(void (^)(id response))callBack
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:@"http://125.71.215.141:4000/crm/api/v1/attachments/upload"
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData appendPartWithFileData:data name:@"111" fileName:@"avatar.png" mimeType:@"image/jpeg"];
                                    }
                                    error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                                       progress:&progress
                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                                  
                                                                  if (error)
                                                                  {
                                                                      callBack(nil);
                                                                      
                                                                  } else
                                                                  {
                                                                      callBack(responseObject);
                                                                  }
                                                                  
                                                              }];
    [uploadTask resume];
}
//上传多张图片
+(void)updatePics:(NSArray *)pics response:(void (^)(id response))callBack
{
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:@"http://125.71.215.141:4000/crm/api/v1/attachments/upload"
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        for (int i = 0;i < pics.count; i++) {
                                            UIImage *image = pics[i];
                                            NSData *data = UIImageJPEGRepresentation(image, 0.3);
                                            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"1%d",i] fileName:@"avatar.png" mimeType:@"image/jpeg"];
                                        }
                                        
                                    }
                                    error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                                       progress:&progress
                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                                  
                                                                  if (error)
                                                                  {
                                                                      callBack(nil);
                                                                      
                                                                  } else
                                                                  {
                                                                      callBack(responseObject);
                                                                  }
                                                                  
                                                              }];
    [uploadTask resume];
}
//上传图片
+(void)AA:(NSData *)data response:(void (^)(id response))callBack
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:@""
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData appendPartWithHeaders:@{@"Content-Type":@"application/json",
                                                                          @"Accept":@"*/*"}
                                                                   body:data];
                                    }
                                    error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                                       progress:&progress
                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                                  
                                                                  if (error)
                                                                  {
                                                                      callBack(nil);
                                                                      
                                                                  } else
                                                                  {
                                                                      callBack(responseObject);
                                                                  }
                                                                  
                                                              }];
    [uploadTask resume];
}


//
+ (NSString *)JsonStr:(id)obj
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted// Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
/*
+ (NSString *)ReWritePostUrl:(NSString *)url obj:(id)obj TheOrder:(NSArray*)order {
    
    if (!obj) {
        return url;
    }
    __block NSString *urlStr = [url stringByAppendingString:@"?"];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = obj;
        if (order.count > 0) {
            [order enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString * key = obj;
                urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[dic objectForKey:key]]];
            }];
        } else {
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
            }];
        }
        
        urlStr = [urlStr stringByReplacingCharactersInRange:NSMakeRange(urlStr.length - 1, 1) withString:@""];
        urlStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8));
    }
    return urlStr;
}
*/
@end
