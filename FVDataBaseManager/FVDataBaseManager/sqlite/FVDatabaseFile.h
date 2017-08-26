//
//  FVDatabaseFile.h
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FVDatabaseFile : NSObject

@property (nonatomic, strong) NSString *filePath;

+ (FVDatabaseFile *)objectWithFileName:(NSString *)fileName;

- (void)protectFromIcloud;

@end
