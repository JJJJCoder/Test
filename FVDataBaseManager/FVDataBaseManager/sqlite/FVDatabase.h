//
//  FVDatabase.h
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "FVDatabaseProtocol.h"
#import "FVDatabaseFile.h"

@interface FVDatabase : NSObject

+ (instancetype)sharedInstance;

- (void)inStore:(id<FVDatabaseProtocol>)store database:(void(^)(FMDatabase *db))block;
- (void)inStroe:(id<FVDatabaseProtocol>)store transaction:(void(^)(FMDatabase *db, BOOL *rollBack))block;

- (void)createTableForStore:(id<FVDatabaseProtocol>)store;
- (void)replaceRowInStore:(id<FVDatabaseProtocol>)store values:(NSArray*)values;

#define FVDB ([FVDatabase sharedInstance])

@end
