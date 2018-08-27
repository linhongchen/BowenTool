//
//  UANetworking.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/22.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "UANetworking.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonDigest.h>

#define NetworkStatusString @"NetworkStatusString"

@interface UACache : YYCache
@end
@implementation UACache

@end
/*****************************以上为 一个YYCache单例模型****************************/

@interface NSString (md5)
+ (NSString *)md5StringFromString:(NSString *)string;
@end

@implementation NSString (md5)
+ (NSString *)md5StringFromString:(NSString *)string
{
    if(string == nil || [string length] == 0)  return nil;
    
    const char *value = [string UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++)
    {
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

@end
/*****************************以上为 字符串MD5加密分类****************************/


@interface UIImage (scale)
+ (UIImage *)IMGCompressed:(UIImage *)image width:(CGFloat)width;
@end

@implementation UIImage (scale)
+ (UIImage *)IMGCompressed:(UIImage *)image width:(CGFloat)width
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    if (image.size.width < width) return image;
    
    CGSize tempsize = CGSizeMake(width, image.size.height/image.size.width*width);
    
    UIGraphicsBeginImageContext(tempsize);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, tempsize.width, tempsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    
    return scaledImage;
}
@end
/*****************************以上为 UIImage压缩剪切分类****************************/


#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

#define CODE_TIMEOUT -1001

static NSString *privateNetworkBaseUrl = nil;//BaseUrl
static BOOL isEnableInterfaceDebug = NO;
static BOOL shouldAutoEncode = NO;//是否编码url
static NSDictionary *httpHeaders = nil;
static ResponseType responseType = ResponseTypeJSON;
static RequestType  requestType  = RequestTypeJSON;
static BOOL cacheGet = YES;
static BOOL cachePost = NO;
static BOOL shouldCallbackOnCancelRequest = YES;
static NSInteger numberOfTimesToRetry = 3;
static NSMutableDictionary *timesOfRetryURLs;
static UACache *uacache = nil;

@implementation UANetworking

+ (void)updateBaseUrl:(NSString *)baseUrl
{
    privateNetworkBaseUrl = baseUrl;
}

+ (NSString *)baseUrl
{
    return privateNetworkBaseUrl;
}

+ (void)enableInterfaceDebug:(BOOL)isDebug
{
    isEnableInterfaceDebug = isDebug;
}

+ (BOOL)isDebug
{
    return isEnableInterfaceDebug;
}

+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost
{
    cacheGet = isCacheGet;
    cachePost = shouldCachePost;
}

+ (void)setNumberOfTimesToRetryOnTimeout:(NSInteger)number
{
    numberOfTimesToRetry = number;
}

+ (void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
{
    shouldAutoEncode = shouldAutoEncode;
}
+ (BOOL)shouldEncode
{
    return shouldAutoEncode;
}

+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders
{
    httpHeaders = httpHeaders;
}

+ (void)configRequestType:(RequestType)requestType
             responseType:(ResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest
{
    requestType = requestType;
    responseType = responseType;
    shouldAutoEncode = shouldAutoEncode;
    shouldCallbackOnCancelRequest = shouldCallbackOnCancelRequest;
}

+ (NSMutableDictionary *)allTimesOfRetryURLs
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (timesOfRetryURLs == nil)
        {
            timesOfRetryURLs = [[NSMutableDictionary alloc] init];
        }
    });
    return timesOfRetryURLs;
}

+ (UACache *)uaNetworkingCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (uacache == nil)
        {
            uacache = [UACache cacheWithName:@"ua_default_cache_reachability"];
        }
    });
    return uacache;
}

#pragma mark - shareManager
+(instancetype)shareManager
{
    static UANetworking *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
    });
    return manager;
}


#pragma mark - 重写initWithBaseURL
- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url])
    {
        //#warning 可根据具体情况进行设置
        NSAssert(url,@"您需要为您的请求设置baseUrl");
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        /**设置相应的缓存策略*/
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        /**分别设置请求以及相应的序列化器*/
        switch (requestType) {
            case RequestTypeJSON: {
                self.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
            }
            case RequestTypePlainText: {
                self.requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
            }
            default: {
                break;
            }
        }
        
        //AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        //response.removesKeysWithNullValues = YES;
        switch (responseType) {
            case ResponseTypeJSON: {
                self.responseSerializer = [AFJSONResponseSerializer serializer];
                break;
            }
            case ResponseTypeXML: {
                self.responseSerializer = [AFXMLParserResponseSerializer serializer];
                break;
            }
            case ResponseTypeData: {
                self.responseSerializer = [AFHTTPResponseSerializer serializer];
                break;
            }
            default: {
                break;
            }
        }
        self.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        for (NSString *key in httpHeaders.allKeys)
        {
            if (httpHeaders[key] != nil)
            {
                [self.requestSerializer setValue:httpHeaders[key] forHTTPHeaderField:key];
            }
        }
        /**设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        /**设置可接受的类型*/
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                               @"text/html",
                                                                               @"text/json",
                                                                               @"text/plain",
                                                                               @"text/javascript",
                                                                               @"text/xml",
                                                                               @"image/*"]];
        
        /**设置允许同时最大并发数量，过大容易出问题*/
        //manager.operationQueue.maxConcurrentOperationCount = 5;
        
        /**设置请求超时时间*/
        [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.requestSerializer.timeoutInterval = 30.0f;
        [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    
    return self;
}

#pragma mark - <<<<<< Tool >>>>>> -
+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params
{
    NSLog(@"\n");
    NSLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",
          [self generateGETAbsoluteURL:url params:params],
          params,
          [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params
{
    NSString *format = @" params: ";
    if (params == nil || ![params isKindOfClass:[NSDictionary class]])
    {
        format = @"";
        params = @"";
    }
    
    NSLog(@"\n");
    if ([error code] == NSURLErrorCancelled)
    {
        NSLog(@"\nRequest was canceled mannully, URL: %@ %@%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              format,
              params);
    }
    else
    {
        NSLog(@"\nRequest error, URL: %@ %@%@\n errorInfos:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              format,
              params,
              [error localizedDescription]);
    }
}

// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params
{
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [(NSDictionary *)params count] == 0)
    {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params)
    {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]])
        {
            continue;
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            continue;
        }
        else if ([value isKindOfClass:[NSSet class]])
        {
            continue;
        }
        else
        {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1)
    {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1)
    {
        if ([url rangeOfString:@"?"].location != NSNotFound || [url rangeOfString:@"#"].location != NSNotFound)
        {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        }
        else
        {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}


+ (id)tryToParseData:(id)responseData
{
    if ([responseData isKindOfClass:[NSData class]])
    {
        // 尝试解析成JSON
        if (responseData == nil)
        {
            return responseData;
        }
        else
        {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            
            if (error != nil)
            {
                return responseData;
            } else
            {
                return response;
            }
        }
    }
    else
    {
        return responseData;
    }
}

+ (void)successResponse:(id)responseData callback:(requestSuccess)success
{
    if (success)
    {
        success([self tryToParseData:responseData]);
    }
}


+ (void)getWithUrl:(NSString *)url
      refreshCache:(BOOL)refreshCache
           success:(requestSuccess)success
              fail:(requestFailure)fail
{
    [self getWithUrl:url
        refreshCache:refreshCache
              params:nil
             success:success
                fail:fail];
}
+ (void)getWithUrl:(NSString *)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
           success:(requestSuccess)success
              fail:(requestFailure)fail
{
    [self getWithUrl:url
        refreshCache:refreshCache
              params:params
            progress:nil
             success:success
                fail:fail];
}
+ (void)getWithUrl:(NSString *)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
          progress:(GetProgress)progress
           success:(requestSuccess)success
              fail:(requestFailure)fail
{
    [self _requestWithType:HttpRequestTypeGet
                    urlStr:url
                 paraments:params
              refreshCache:refreshCache
                  progress:progress
              successBlock:success
              failureBlock:fail];
}
+ (void)postWithUrl:(NSString *)url
       refreshCache:(BOOL)refreshCache
             params:(NSDictionary *)params
            success:(requestSuccess)success
               fail:(requestFailure)fail
{
    [self postWithUrl:url
         refreshCache:refreshCache
               params:params
             progress:nil
              success:success
                 fail:fail];
}
+ (void)postWithUrl:(NSString *)url
       refreshCache:(BOOL)refreshCache
             params:(NSDictionary *)params
           progress:(PostProgress)progress
            success:(requestSuccess)success
               fail:(requestFailure)fail
{
    [self _requestWithType:HttpRequestTypePost
                    urlStr:url
                 paraments:params
              refreshCache:refreshCache
                  progress:progress
              successBlock:success
              failureBlock:fail];
}


#pragma mark - <<<<<< GET/POST >>>>>> -
/**
 *  网络请求的实例方法 - (带缓存)
 *
 *  @param type         get / post
 *  @param urlStr       请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 */

+ (void)_requestWithType:(HttpRequestType)type
                  urlStr:(NSString *)urlStr
               paraments:(id)paraments
            refreshCache:(BOOL)refreshCache
                progress:(downloadProgress)progress
            successBlock:(requestSuccess)successBlock
            failureBlock:(requestFailure)failureBlock
{
    
    NSString *urlString = [urlStr copy];
        
    NSString *absolute = [self absoluteUrlWithPath:urlString];
    if ([self baseUrl] == nil)
    {
        if ([NSURL URLWithString:urlString] == nil)
        {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            if (failureBlock)
            {
                failureBlock([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
            }
            return;
        }
    }
    else
    {
        NSURL *absouluteURL = [NSURL URLWithString:absolute];
        if (absouluteURL == nil)
        {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            if (failureBlock)
            {
                failureBlock([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
            }
            return;
        }
    }
    
    if ([self shouldEncode])
    {
        urlString = [self encodeUrl:urlString];
    }
    
    //设置请求超时重试次数
    if (![[self allTimesOfRetryURLs] objectForKey:urlString])
    {
        [[self allTimesOfRetryURLs] setObject:@(numberOfTimesToRetry) forKey:urlString];
    }
    
    switch (type)
    {
        case HttpRequestTypeGet:
        {
            if (cacheGet && !refreshCache)
            {
                //获取缓存
                id responsedic = [UANetworking cacheJsonWithURL:urlString];
                if (responsedic !=nil )
                {
                    if (successBlock)
                    {
                        successBlock(responsedic);
                    }
                    return;
                }
            }
            
            
            [[UANetworking shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                
                if (progress)
                {
                    progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                }
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successResponse:responseObject callback:successBlock];
                
                if (cacheGet)
                {
                    [UANetworking saveJsonResponseToCacheFile:responseObject URL:urlString];
                }
                [[self allTimesOfRetryURLs] removeObjectForKey:urlString]; //移除关联的超时重试次数
                
                if ([self isDebug])
                {
                    [self logWithSuccessResponse:responseObject
                                             url:urlString
                                          params:paraments];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //判断超时重试条件,满足则发起重试请求
                NSInteger timesOfRetry = [[[self allTimesOfRetryURLs] objectForKey:urlString] integerValue];
                if (error.code == CODE_TIMEOUT && timesOfRetry > 0)
                {
                    [task cancel];
                    
                    [self _requestWithType:type
                                    urlStr:urlStr
                                 paraments:paraments
                              refreshCache:refreshCache
                                  progress:progress
                              successBlock:successBlock
                              failureBlock:failureBlock];
                    NSLog(@"%@超时重试%@",urlStr,@(timesOfRetry));
                    //设置请求超时重试次数
                    timesOfRetry--;
                    [[self allTimesOfRetryURLs] setObject:@(timesOfRetry) forKey:urlString];
                    return;
                }
                [[self allTimesOfRetryURLs] removeObjectForKey:urlString]; //移除关联的超时重试次数
                
                [self handleCallbackWithError:error fail:failureBlock];
                
                if ([self isDebug])
                {
                    [self logWithFailError:error url:absolute params:paraments];
                }
            }];
            break;
        }
        case HttpRequestTypePost:
        {
            if (cachePost && !refreshCache)
            {
                // 获取缓存
                id responsedic = [UANetworking cacheJsonWithURL:urlString];
                if (responsedic !=nil)
                {
                    if (successBlock)
                    {
                        successBlock(responsedic);
                    }
                    return;
                }
            }
            
            [[UANetworking shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                
                if (progress)
                {
                    progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
                }
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successResponse:responseObject callback:successBlock];
                
                if (cachePost)
                {
                    [UANetworking saveJsonResponseToCacheFile:responseObject URL:urlString];
                }
                [[self allTimesOfRetryURLs] removeObjectForKey:urlString]; //移除关联的超时重试次数
                
                if ([self isDebug])
                {
                    [self logWithSuccessResponse:responseObject
                                             url:urlString
                                          params:paraments];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //判断超时重试条件,满足则发起重试请求
                NSInteger timesOfRetry = [[[self allTimesOfRetryURLs] objectForKey:urlString] integerValue];
                if (error.code == CODE_TIMEOUT && timesOfRetry > 0)
                {
                    [task cancel];
                    
                    [self _requestWithType:type
                                    urlStr:urlStr
                                 paraments:paraments
                              refreshCache:refreshCache
                                  progress:progress
                              successBlock:successBlock
                              failureBlock:failureBlock];
                    NSLog(@"%@超时重试%@",urlStr,@(timesOfRetry));
                    //设置请求超时重试次数
                    timesOfRetry--;
                    [[self allTimesOfRetryURLs] setObject:@(timesOfRetry) forKey:urlString];
                    return;
                }
                [[self allTimesOfRetryURLs] removeObjectForKey:urlString]; //移除关联的超时重试次数
                
                [self handleCallbackWithError:error fail:failureBlock];
                
                if ([self isDebug])
                {
                    [self logWithFailError:error url:absolute params:paraments];
                }
            }];
        }
    }
}
#pragma mark - <<<<<< uploadImage >>>>>> -
+ (void)uploadImageWithUrlStr:(NSString *)urlStr
                    paraments:(NSDictionary *)params
                        image:(UIImage *)image
                  targetWidth:(CGFloat)width
                     progress:(uploadProgress)progress
                      success:(requestSuccess)success
                      failure:(requestFailure)failure
{
    NSArray *imageArray = [NSArray arrayWithObject:image];
    [self uploadImageWithUrlStr:urlStr
                      paraments:params
                     imageArray:imageArray
                    targetWidth:width
                       progress:progress
                   successBlock:success
                    failurBlock:failure];
}

#pragma mark - 多图上传
/**
 *  上传图片
 *
 *  @param urlStr    上传的url---请填写完整的url
 *  @param paraments   上传图片等预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @param width      图片要被压缩到的宽度
 *  @param progress     上传进度
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *
 */
+ (void)uploadImageWithUrlStr:(NSString *)urlStr
                    paraments:(NSDictionary *)paraments
                   imageArray:(NSArray *)imageArray
                  targetWidth:(CGFloat)width
                     progress:(uploadProgress)progress
                 successBlock:(requestSuccess)successBlock
                  failurBlock:(requestFailure)failureBlock
{
    NSString *urlString = [urlStr copy];
    NSLog(@"请求URL： %@/%@",[self baseUrl],urlString);
    
    if ([self baseUrl] == nil)
    {
        if ([NSURL URLWithString:urlString] == nil)
        {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            if (failureBlock)
            {
                failureBlock([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
            }
            return;
        }
    }
    else
    {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], urlString]] == nil)
        {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            if (failureBlock)
            {
                failureBlock([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
            }
            return;
        }
    }
    
    if ([self shouldEncode])
    {
        urlString = [self encodeUrl:urlString];
    }
    NSString *absolute = [self absoluteUrlWithPath:urlString];
    
    urlString = [NSString stringWithFormat:@"%@/%@",[self baseUrl],urlString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:paraments constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /**出于性能考虑,将上传图片进行压缩*/
        for (NSUInteger i = 0; i < imageArray.count; i ++)
        {
            UIImage *image = imageArray[i];
            //image的分类方法
            UIImage *resizedImage =  [UIImage IMGCompressed:image width:width];
            NSData  *imgData = UIImageJPEGRepresentation(resizedImage, .5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            NSString *name = [NSString stringWithFormat:@"upload_image_%ld.png",(long)i];
            
            //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
            //[formData appendPartWithFileData:imgData name:name fileName:fileName mimeType:@"image/png"];
            [formData appendPartWithFileData:imgData name:name fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress)
        {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        [self successResponse:responseObject callback:successBlock];
        
        if ([self isDebug])
        {
            [self logWithSuccessResponse:responseObject
                                     url:absolute
                                  params:paraments];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self handleCallbackWithError:error fail:failureBlock];
        if ([self isDebug])
        {
            [self logWithFailError:error url:absolute params:nil];
        }
    }];
}
+ (void)uploadDataWithUrlStr:(NSString *)urlStr
                        data:(NSData *)data
                      params:(NSDictionary *)params
                    progress:(uploadProgress)progress
                     success:(requestSuccess)success
                     failure:(requestFailure)failure
{
    NSString *urlString = [urlStr copy];
    
    if ([self baseUrl] == nil)
    {
        if ([NSURL URLWithString:urlString] == nil)
        {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            if (failure)
            {
                failure([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
            }
            return;
        }
    }
    else
    {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], urlString]] == nil)
        {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            if (failure)
            {
                failure([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
            }
            return;
        }
    }
    
    if ([self shouldEncode])
    {
        urlString = [self encodeUrl:urlString];
    }
    
    NSString *absolute = [self absoluteUrlWithPath:urlString];
    urlString = [NSString stringWithFormat:@"%@/%@",[self baseUrl],urlString];
    
    AFHTTPSessionManager *manager = [self manager];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"dataFile" fileName:@"video.mp4" mimeType:@".mp4"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress)
        {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        NSLog(@"uploadProgress is %lld,总字节 is %lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponse:responseObject callback:success];
        
        if ([self isDebug])
        {
            [self logWithSuccessResponse:responseObject
                                     url:absolute
                                  params:params];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self handleCallbackWithError:error fail:failure];
        if ([self isDebug])
        {
            [self logWithFailError:error url:absolute params:nil];
        }
    }];
}

+ (void)uploadFileWithUrlStr:(NSString *)urlStr
               uploadingFile:(NSString *)uploadingFile
                    progress:(uploadProgress)progress
                     success:(requestSuccess)success
                     failure:(requestFailure)failure
{
    NSString *urlString = [urlStr copy];
    
    if ([NSURL URLWithString:uploadingFile] == nil)
    {
        if (failure)
        {
            failure([NSError errorWithDomain:@"uploadingFile无效，无法生成URL。请检查待上传文件是否存在" code:400 userInfo:@{}]);
        }
        return;
    }
    
    NSURL *uploadURL = nil;
    if ([self baseUrl] == nil)
    {
        uploadURL = [NSURL URLWithString:urlString];
    }
    else
    {
        uploadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], urlString]];
    }
    
    if (uploadURL == nil)
    {
        if (failure)
        {
            failure([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
        }
        return;
    }
    
    if ([self shouldEncode])
    {
        urlString = [self encodeUrl:urlString];
    }
    
    AFHTTPSessionManager *manager = [self manager];
    manager.requestSerializer.timeoutInterval = 60.0f;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress)
        {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        [self successResponse:responseObject callback:success];
        
        if (error)
        {
            [self handleCallbackWithError:error fail:failure];
            
            if ([self isDebug])
            {
                [self logWithFailError:error url:response.URL.absoluteString params:nil];
            }
        }
        else
        {
            if ([self isDebug])
            {
                [self logWithSuccessResponse:responseObject
                                         url:response.URL.absoluteString
                                      params:nil];
            }
        }
    }];
}

+ (void)downloadWithUrlStr:(NSString *)urlStr
                saveToPath:(NSString *)saveToPath
                  progress:(downloadProgress)progressBlock
                   success:(requestSuccess)success
                   failure:(requestFailure)failure
{
    NSString *urlString = [urlStr copy];
    
    
    if ([self baseUrl] == nil)
    {
        if ([NSURL URLWithString:urlString] == nil)
        {
            if (failure)
            {
                failure([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
            }
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return;
        }
    }
    else
    {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], urlString]] == nil)
        {
            NSLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            if (failure)
            {
                failure([NSError errorWithDomain:@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL" code:400 userInfo:@{}]);
            }
            return;
        }
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    AFHTTPSessionManager *manager = [self manager];
    [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock)
        {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error == nil)
        {
            if (success)
            {
                success(filePath.absoluteString);
            }
            
            if ([self isDebug])
            {
                NSLog(@"Download success for url %@",
                      [self absoluteUrlWithPath:urlString]);
            }
        }
        else
        {
            [self handleCallbackWithError:error fail:failure];
            
            if ([self isDebug])
            {
                NSLog(@"Download fail for url %@, reason : %@",
                      [self absoluteUrlWithPath:urlString],
                      [error description]);
            }
        }
    }];
}
#pragma mark - 视频上传

/**
 *  视频上传
 *
 *  @param operations   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */

+ (void)uploadVideoWithOperaitons:(NSDictionary *)operations
                        videoPath:(NSString *)videoPath
                        urlString:(NSString *)urlString
                     successBlock:(requestSuccess)successBlock
                     failureBlock:(requestFailure)failureBlock
                   uploadProgress:(uploadProgress)progress
{
    /**获得视频资源*/
    AVURLAsset *avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:videoPath]];
    
    /**压缩*/
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    
    AVAssetExportSession *avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
    
    /**创建日期格式化器*/
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    /**转化后直接写入Library---caches*/
    NSString *videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/output-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    
    avAssetExport.outputURL = [NSURL URLWithString:videoWritePath];
    avAssetExport.outputFileType = AVFileTypeMPEG4;
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        
        switch ([avAssetExport status])
        {
            case AVAssetExportSessionStatusCompleted:
            {
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    //获得沙盒中的视频内容
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoWritePath] name:@"write you want to writre" fileName:videoWritePath mimeType:@"video/mpeg4" error:nil];
                    
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                    if (progress)
                    {
                        progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
                    }
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    
                    successBlock(responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    failureBlock(error);
                }];
                break;
            }
            default:
                break;
        }
    }];
}

#pragma mark - 文件下载

/**
 *  文件下载
 *
 *  @param operations   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString        请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */

+ (void)downLoadFileWithOperations:(NSDictionary *)operations
                          savaPath:(NSString *)savePath
                         urlString:(NSString *)urlString
                      successBlock:(requestSuccess)successBlock
                      failureBlock:(requestFailure)failureBlock
                  downLoadProgress:(downloadProgress)progress
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress)
        {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return  [NSURL URLWithString:savePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error)
        {
            failureBlock(error);
        }
    }];
}

+ (NSString *)requestHTTPMethodWithType:(HttpRequestType)type
{
    switch (type)
    {
        case HttpRequestTypeGet:
        {
            return @"GET";
        }
            break;
        case HttpRequestTypePost:
        {
            return @"POST";
        }
            break;
            
        default:
            break;
    }
    return @"unKnow";
}

#pragma mark -  取消所有的网络请求
/**
 *  取消所有的网络请求
 *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
 */

+ (void)cancelAllRequest
{
    [[UANetworking shareManager].operationQueue cancelAllOperations];
}

#pragma mark -   取消指定的url请求
/**
 *  取消指定的url请求
 *
 *  @param type 该请求的请求类型
 *  @param string      该请求的完整url
 */

+ (void)cancelHttpRequestWithType:(HttpRequestType)type urlString:(NSString *)string
{
    NSString *requestType = [self requestHTTPMethodWithType:type];
    NSError *error;
    
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    NSString *urlToPeCanced = [[[[UANetworking shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    
    for (NSOperation *operation in [UANetworking shareManager].operationQueue.operations)
    {
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]])
        {
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            
            //请求的url匹配
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString)
            {
                [operation cancel];
            }
        }
    }
}




#pragma mark - 缓存处理 方法
static inline NSString *cachePath()
{
    //    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WXBNetworkingCaches"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths lastObject];
    return [docPath stringByAppendingPathComponent:@"cwcYYCache"];
}

+ (void)clearCaches
{
    NSString *directoryPath = cachePath();
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil])
    {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
        
        if (error)
        {
            NSLog(@"Networking clear caches error: %@", error);
        }
        else
        {
            NSLog(@"Networking clear caches ok");
        }
    }
}

+ (unsigned long long)totalCacheSize
{
    NSString *directoryPath = cachePath();
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir])
    {
        if (isDir)
        {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil)
            {
                for (NSString *subpath in array)
                {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error)
                    {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}

+ (BOOL)saveJsonResponseToCacheFile:(id)jsonResponse URL:(NSString *)URL
{
    NSDictionary *json = jsonResponse;
    NSString *path = [self cacheFilePathWithURL:URL];
    YYCache *cache = [[YYCache alloc] initWithPath:path];
    if(json!=nil)
    {
        BOOL state = [cache containsObjectForKey:URL];
        [cache setObject:json forKey:URL];
        
        if(state)
        {
            NSLog(@"缓存写入/更新成功");
        }
        return state;
    }
    return NO;
}


+ (id)cacheJsonWithURL:(NSString *)URL
{
    id cacheJson;
    NSString *path = [self cacheFilePathWithURL:URL];
    YYCache *cache = [[YYCache alloc] initWithPath:path];
    BOOL state = [cache containsObjectForKey:URL];
    if(state)
    {
        cacheJson = [cache objectForKey:URL];
    }
    return cacheJson;
}

+ (NSString *)cacheFilePathWithURL:(NSString *)URL
{
    NSString *path = cachePath();
    [self checkDirectory:path];//check路径
    
    //文件名
    NSString *cacheFileNameString = [NSString stringWithFormat:@"URL:%@ AppVersion:%@",URL,[self appVersionString]];
    NSString *cacheFileName = [NSString md5StringFromString:cacheFileNameString];
    path = [path stringByAppendingPathComponent:cacheFileName];
    
    //   DNSLog(@"缓存 path = %@",path);
    return path;
}

+ (void)checkDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir])
    {
        [self createBaseDirectoryAtPath:path];
    }
    else
    {
        if (!isDir)
        {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

+ (void)createBaseDirectoryAtPath:(NSString *)path
{
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error)
    {
        NSLog(@"create cache directory failed, error = %@", error);
    }
    else
    {
        [self addDoNotBackupAttribute:path];
    }
}

+ (void)addDoNotBackupAttribute:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error)
    {
        NSLog(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)appVersionString
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+ (NSString *)encodeUrl:(NSString *)url
{
    return [self cwc_URLEncode:url];
}

+ (NSString *)cwc_URLEncode:(NSString *)url
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
#pragma clang diagnostic pop
    if (newString)
    {
        return newString;
    }
    
    return url;
}

+ (NSString *)absoluteUrlWithPath:(NSString *)path
{
    if (path == nil || path.length == 0)
    {
        return @"";
    }
    
    if ([self baseUrl] == nil || [[self baseUrl] length] == 0)
    {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"])
    {
        absoluteUrl = [NSString stringWithFormat:@"%@%@",
                       [self baseUrl], path];
    }
    
    return absoluteUrl;
}

+ (void)handleCallbackWithError:(NSError *)error fail:(requestFailure)fail
{
    if ([error code] == NSURLErrorCancelled)
    {
        if (shouldCallbackOnCancelRequest)
        {
            if (fail)
            {
                fail(error);
            }
        }
    }
    else
    {
        if (fail)
        {
            fail(error);
        }
    }
}

#pragma mark - <<<<<< Tool >>>>>> -

+ (NSString *)reachabilitySateString
{
    [self AFNReachability];
    
    id abilitySateString = [[self uaNetworkingCache] objectForKey:NetworkStatusString];
    return abilitySateString;
}

+ (BOOL)isNetworkStatus
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

//使用AFN框架来检测网络状态的改变
+ (void)AFNReachability
{
    //1.创建网络监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //2.监听网络状态的改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *network = @"未知";
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                network = @"未知";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                network = @"没有网络";
                //                alertSureInfo(@"当前没有网络！");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                network = @"3G";
                //                alertSureInfo(@"正在使用手机流量！");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                network = @"WIFI";
                //                alertSureInfo(@"已连接到WiFi网络！");
                break;
        }
        NSLog(@"%@", network);
        [[self uaNetworkingCache] setObject:network forKey:NetworkStatusString];
    }];
    
    //3.开始监听
    [manager startMonitoring];
}


@end
