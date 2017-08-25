//
//  HXNetworkManager.m
//  NetworkManager
//
//  Created by iforvert on 2016/11/30.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "HXNetworkManager.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "HXRequestUrlManager.h"
#import "NSString+md5.h"
#import "NSDictionary+Extension.h"

static NSString * const MD5Key = @"&HXTECHJSSJB@";

@interface HXNetworkManager ()

@property (nonatomic) dispatch_queue_t networkQueue;

@end

@implementation HXNetworkManager

+ (instancetype)sharedManager
{
    static id mgr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[HXNetworkManager alloc] init];
    });
    return mgr;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self createSessionManager];
        [self createDeviceCode];
        [self createBackgroundQueue];
    }
    return self;
}

- (void)createSessionManager
{
    NSURLSessionConfiguration* conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:conf];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (void)createDeviceCode
{}

- (void)createBackgroundQueue
{
    self.networkQueue = dispatch_queue_create("com.huixiangtech.comic.network", DISPATCH_QUEUE_CONCURRENT);
}

#pragma mark - Public API

- (void)submitRequest:(id<HXServerRequestProtocol>)request completion:(HXNetworkRequestHandler)handler
{
    dispatch_async(self.networkQueue, ^{
        NSDictionary *params = [self makeParamsForRequest:request];
        if (!params)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler)
                {
                    NSError *err = [NSError errorWithDomain:NSURLErrorDomain code:110 userInfo:nil];
                    [request processResult:nil error:&err];
                }
            });
            return;
        }
        NSURLRequest *urlRequest = [self makeRequestForParams:params request:request];
        // 打印浏览器请求
        NSString *urlStr = [[HXRequestUrlManager instanse] hostForRequest];
        urlStr = [urlStr stringByAppendingString:[request funcName]];
        NSLog(@"%@", [NSString stringWithFormat:@"%@?%@",urlStr ,[self changeDictionaryToString:params]]);
        
        [[self.sessionManager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            dispatch_async(self.networkQueue, ^{
                NSError *requestErr;
                if (error)
                {
                    // 错误
                    requestErr = error;
                }
                else if (![responseObject isKindOfClass:[NSData class]])
                {
                    // 错误
                    requestErr = [NSError errorWithDomain:@"error" code:300 userInfo:@{}];
                }
                else
                {
                    // 成功
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    [request processResult:result error:&requestErr];
                }
            });
        }] resume];
    });
}

#pragma mark - Helper func

- (NSURLRequest*)makeRequestForParams:(NSDictionary*)params request:(id<HXServerRequestProtocol>)rq
{
    NSString *urlStr = [[HXRequestUrlManager instanse] hostForRequest];
    urlStr = [urlStr stringByAppendingString:[rq funcName]];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlStr parameters:params error:nil];
    request.timeoutInterval = 10;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    return request;
}

- (NSDictionary*)makeParamsForRequest:(id<HXServerRequestProtocol>)request
{
    NSMutableDictionary *paraDict = [request paramDict].mutableCopy;
    NSDictionary *params = nil;
    if ([request respondsToSelector:@selector(extraParaDict)])
    {
        params = [self splitEncryptionDict:[request paramDict] normalPara:[request extraParaDict] URL:[request funcName]];
    }
    else
    {
        params = [self split:paraDict URL:[request funcName]];
    }
    return params;
}

- (NSDictionary *)splitEncryptionDict:(NSDictionary *)encryptionDict normalPara:(NSDictionary *)normalPara URL:(NSString *)path
{
    NSArray *array =[encryptionDict allValuesSortedByKeys];
    NSString *consisting = [array componentsJoinedByString:@""];
    NSMutableString *md5string = [NSMutableString new];
    [md5string appendFormat:@"%@%@%@", path, consisting, MD5Key];
    NSMutableString *mstring = [NSMutableString stringWithFormat:@"%@%@", [NSString md5:md5string], MD5Key];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:normalPara];
    [mDic setObject:[NSString md5:mstring] forKey:@"signature"];
    for (NSString *key in encryptionDict.allKeys)
    {
        [mDic setObject:encryptionDict[key] forKey:key];
    }
    return mDic;
}

- (NSDictionary *)split:(NSDictionary *)dictionary URL:(NSString *)path
{
    NSArray *array =[dictionary allValuesSortedByKeys];
    NSString *consisting = [array componentsJoinedByString:@""];
    NSMutableString *md5string = [NSMutableString new];
    [md5string appendFormat:@"%@%@%@", path, consisting, MD5Key];
    NSString *string = [NSString md5:md5string];
    NSMutableString *mstring = [NSMutableString stringWithFormat:@"%@%@", string, MD5Key];
    
    NSString *signature = [NSString md5:mstring];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [mDic setObject:signature forKey:@"signature"];
    return mDic;
}

- (NSMutableString *)changeDictionaryToString:(NSDictionary *)parameter
{
    NSMutableString *mutableStr = [NSMutableString string];
    for (NSString *key in parameter)
    {
        NSString *str = [NSString stringWithFormat:@"%@=%@&",key, parameter[key]];
        [mutableStr appendString:str];
    }
    if (mutableStr.length > 0)
    {
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length - 1, 1)];
    }
    return mutableStr;
}

@end
