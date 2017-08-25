//
//  HXRequestUrlManager.m
//  NetworkManager
//
//  Created by iforvert on 2016/11/30.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "HXRequestUrlManager.h"

@implementation HXRequestUrlManager
{
    NSString *_host;
}

/*
 * 单例
 */
+ (instancetype)instanse
{
    static id i = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        i = [[self alloc] init];
    });
    return i;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        _host = @"http://www.classmemo.cn/bjweb";
//        _host = @"http:// 59.108.99.173:40494/";
        _host = @"http://59.108.60.203:40494/bjweb/";
        
    }
    return self;
}

- (NSString *)hostForRequest
{
    return _host.length ? _host : nil;
}

@end
