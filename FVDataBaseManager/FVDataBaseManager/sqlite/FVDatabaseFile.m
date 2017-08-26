//
//  FVDatabaseFile.m
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "FVDatabaseFile.h"

@implementation FVDatabaseFile

+ (FVDatabaseFile *)objectWithFileName:(NSString *)fileName
{
    FVDatabaseFile *file = [[FVDatabaseFile alloc] init];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [libraryPath stringByAppendingPathComponent:fileName];
    file.filePath = filePath;
    return file;
}

- (void)protectFromIcloud
{
    
}

@end
