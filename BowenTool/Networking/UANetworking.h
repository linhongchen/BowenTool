//
//  UANetworking.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/22.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<YYKit/YYCache.h>)
#import <YYKit/YYCache.h>
#else
#import "YYCache.h"
#endif

#if __has_include(<AFNetworking/AFNetworkActivityIndicatorManager.h>)
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#else
#import "AFNetworkActivityIndicatorManager.h"
#endif

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

/**缓存的block*/
typedef void(^requestCache) (id jsonCache);

/**定义请求成功的block*/
typedef void(^requestSuccess)(id response);

/**定义请求失败的block*/
typedef void(^requestFailure)(NSError *error);

/**定义上传进度block*/
typedef void (^uploadProgress)(int64_t bytesWritten,
                               int64_t totalBytesWritten);

/**定义下载进度block*/
typedef void(^downloadProgress)(int64_t bytesRead,
                                int64_t totalBytesRead);
typedef downloadProgress GetProgress;
typedef downloadProgress PostProgress;


/**定义请求类型的枚举*/
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    HttpRequestTypeGet = 0,
    HttpRequestTypePost
};
typedef NS_ENUM(NSUInteger, RequestType) {
    RequestTypeJSON = 1,        // 默认
    RequestTypePlainText  = 2,  // 普通text/html
};
typedef NS_ENUM(NSUInteger, ResponseType) {
    ResponseTypeJSON = 1, // 默认
    ResponseTypeXML  = 2, // XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    ResponseTypeData = 3
};

@interface UANetworking : AFHTTPSessionManager

/**
 *  BaseURL
 *  用于指定网络请求接口的基础url，如：
 *  http://baidu.com或者http://192.168.7.15:8080
 *  通常在AppDelegate中启动时就设置一次就可以了。如果接口有来源
 *  于多个服务器，可以调用更新
 *
 *  @param baseUrl 网络接口的基础url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;

/**
 *  获取当前的baseUrl
 */
+ (NSString *)baseUrl;

/**
 *
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *
 *  @param requestType 请求格式，默认为JSON
 *  @param responseType 响应格式，默认为JSO，
 *  @param shouldAutoEncode 默认为NO，是否自动encode url
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)configRequestType:(RequestType)requestType
             responseType:(ResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest;

/**
 *  开启或关闭是否自动将URL使用UTF8编码，用于处理链接中有中文时无法请求的问题
 *
 *  @param shouldAutoEncode YES or NO,默认为NO
 */
+ (void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode;

/**
 *
 *  配置请求超时重试次数(不支持上传下载接口)
 *
 *  @param number 默认重试次数为3
 */
+ (void)setNumberOfTimesToRetryOnTimeout:(NSInteger)number;

//实例对象方法
+ (instancetype)shareManager;

#pragma mark - <<<<<< GET >>>>>> -
+ (void)getWithUrl:(NSString *)url
      refreshCache:(BOOL)refreshCache
           success:(requestSuccess)success
              fail:(requestFailure)fail;
+ (void)getWithUrl:(NSString *)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
           success:(requestSuccess)success
              fail:(requestFailure)fail;
+ (void)getWithUrl:(NSString *)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
          progress:(GetProgress)progress
           success:(requestSuccess)success
              fail:(requestFailure)fail;
#pragma mark - <<<<<< POST >>>>>> -
+ (void)postWithUrl:(NSString *)url
       refreshCache:(BOOL)refreshCache
             params:(NSDictionary *)params
            success:(requestSuccess)success
               fail:(requestFailure)fail;
+ (void)postWithUrl:(NSString *)url
       refreshCache:(BOOL)refreshCache
             params:(NSDictionary *)params
           progress:(PostProgress)progress
            success:(requestSuccess)success
               fail:(requestFailure)fail;

#pragma mark - <<<<<< uploadImage >>>>>> -
+ (void)uploadImageWithUrlStr:(NSString *)urlStr
                    paraments:(NSDictionary *)params
                        image:(UIImage *)image
                  targetWidth:(CGFloat)width
                     progress:(uploadProgress)progress
                      success:(requestSuccess)success
                      failure:(requestFailure)failure;
/**
 *  上传图片
 *
 *  @param urlStr       上传的url
 *  @param paraments    上传图片预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @param width        图片要被压缩到的宽度
 *  @param progress     上传进度
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 */
+ (void)uploadImageWithUrlStr:(NSString *)urlStr
                    paraments:(NSDictionary *)paraments
                   imageArray:(NSArray *)imageArray
                  targetWidth:(CGFloat)width
                     progress:(uploadProgress)progress
                 successBlock:(requestSuccess)successBlock
                  failurBlock:(requestFailure)failureBlock;



#pragma mark - <<<<<< 上传data数据 >>>>>> -
//上传data数据
+ (void)uploadDataWithUrlStr:(NSString *)urlStr
                        data:(NSData *)data
                      params:(NSDictionary *)params
                    progress:(uploadProgress)progress
                     success:(requestSuccess)success
                     failure:(requestFailure)failure;
#pragma mark - <<<<<< uploadFile >>>>>> -
/**
 *  上传文件操作
 *
 *  @param urlStr           上传路径
 *  @param uploadingFile    待上传文件的路径
 *  @param progress         上传进度
 *  @param success          上传成功回调
 *  @param failure          上传失败回调
 *
 */
+ (void)uploadFileWithUrlStr:(NSString *)urlStr
               uploadingFile:(NSString *)uploadingFile
                    progress:(uploadProgress)progress
                     success:(requestSuccess)success
                     failure:(requestFailure)failure;
#pragma mark - <<<<<< download >>>>>> -
/**
 *  下载文件
 *
 *  @param urlStr           下载URL
 *  @param saveToPath    下载到哪个路径下
 *  @param progressBlock 下载进度
 *  @param success       下载成功后的回调
 *  @param failure       下载失败后的回调
 */
+ (void)downloadWithUrlStr:(NSString *)urlStr
                saveToPath:(NSString *)saveToPath
                  progress:(downloadProgress)progressBlock
                   success:(requestSuccess)success
                   failure:(requestFailure)failure;


#pragma mark - <<<<<< uploadvideo >>>>>> -
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
                   uploadProgress:(uploadProgress)progress;

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
                  downLoadProgress:(downloadProgress)progress;

/**
 *  取消所有的网络请求
 */
+ (void)cancelAllRequest;

/**
 *  取消指定的url请求
 *
 *  @param type 该请求的请求类型
 *  @param string      该请求的url
 */
+ (void)cancelHttpRequestWithType:(HttpRequestType)type
                        urlString:(NSString *)string;

/**
 *  缓存
 *
 *  默认只缓存GET请求的数据，对于POST请求是不缓存的。如果要缓存POST获取的数据，需要手动调用设置
 *  对JSON类型数据有效，对于PLIST、XML不确定！
 *
 *  @param isCacheGet           默认为YES
 *  @param shouldCachePost  默认为NO
 */
+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost;


/**
 *  手动写入/更新缓存
 *
 *  @param jsonResponse 要写入的数据
 *  @param URL    请求URL
 *
 *  @return 是否写入成功
 */
+ (BOOL)saveJsonResponseToCacheFile:(id)jsonResponse URL:(NSString *)URL;

/**
 *  获取缓存的对象
 *
 *  @param URL 请求URL
 *
 *  @return 缓存对象
 */
+ (id)cacheJsonWithURL:(NSString *)URL;

/**
 *  清除缓存
 */
+ (void)clearCaches;

/**
 *  获取缓存总大小/bytes
 *
 *  @return 缓存大小
 */
+ (unsigned long long)totalCacheSize;

#pragma mark - <<<<<< Tool >>>>>> -
//获取网络状态-BOOL-是否有网络
+ (BOOL)isNetworkStatus;
//使用AFN框架来检测网络状态的改变
+ (void)AFNReachability;
+ (NSString *)reachabilitySateString;
@end


