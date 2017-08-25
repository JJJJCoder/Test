//
//  TestNetworkRequest.m
//  NetworkManager
//
//  Created by iforvert on 2016/11/30.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "TestNetworkRequest.h"

@implementation TestNetworkRequest

- (NSString *)funcName
{
    return @"bjteacher/getClassInfo";
}

- (NSDictionary *)paramDict
{
    NSDictionary *dict = @{
                           @"loginName" : @"17600203068",
                           @"userId"    : @"2909",
                           };
    return dict;
}

- (NSDictionary *)extraParaDict
{
    NSDictionary *extraDict = @{
                                @"jpushClientKey" : @"191e35f7e07011701bf",
                                @"systemVersion"  : @"2.8.7"
                                };
    return extraDict;
}

- (void)processResult:(nullable NSDictionary *)result error:(NSError *__autoreleasing  _Nullable *)error
{
    NSLog(@"%@",result);
}

@end
