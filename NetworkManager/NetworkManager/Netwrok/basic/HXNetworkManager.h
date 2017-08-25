//
//  HXNetworkManager.h
//  NetworkManager
//
//  Created by iforvert on 2016/11/30.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "HXServerRequestProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HXNetworkRequestHandler)(NSError* _Nullable error);

@interface HXNetworkManager : NSObject

@property (nonatomic, readonly) AFHTTPSessionManager* sessionManager;

+ (instancetype)sharedManager;

// 异步网络请求, handler在主线程中被调用
- (void)submitRequest:(id<HXServerRequestProtocol>)request completion:(nullable HXNetworkRequestHandler)handler;

@end

NS_ASSUME_NONNULL_END

#define HXNetwork ([HXNetworkManager sharedManager])
