//
//  NSString+md5.m
//  RemindTeacher_iOS
//
//  Created by 张浩 on 16/4/19.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (md5)

+ (NSString *)md5:(NSString *)str
{
    if (str == nil || [str length] == 0)
    {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([str UTF8String], (int)[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

@end
