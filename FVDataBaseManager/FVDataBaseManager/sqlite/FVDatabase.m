//
//  FVDatabase.m
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "FVDatabase.h"
#import "NSDate+use.h"
#import "NSString+DBUse.h"

@interface FVDatabase ()

@property (nonatomic, strong) NSDictionary <NSString*, FMDatabaseQueue*>*dbDict;

@end

@implementation FVDatabase

+ (instancetype)sharedInstance
{
    static id i;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        i = [[FVDatabase alloc] init];
    });
    return i;
}

- (void)inStore:(id<FVDatabaseProtocol>)store database:(void(^)(FMDatabase *db))block
{
    NSLog(@"1111111");
    [[self databaseQueueForFile:store.databaseName] inDatabase:^(FMDatabase * _Nonnull db) {
        if (!db.hasDateFormatter)
        {
            [db setDateFormat:[NSDate fvDataFormat]];
        }
        block(db);
    }];
}

- (void)inStroe:(id<FVDatabaseProtocol>)store transaction:(void(^)(FMDatabase *db, BOOL *rollBack))block
{
    [[self databaseQueueForFile:store.databaseName] inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        if (!db.hasDateFormatter)
        {
            [db setDateFormat:[NSDate fvDataFormat]];
        }
        block(db, rollback);
    }];
}

- (FMDatabaseQueue*)databaseQueueForFile:(NSString*)fileName
{
    FMDatabaseQueue *queue = self.dbDict[fileName];
    if (!queue)
    {
        @synchronized ([FVDatabase class])
        {
            queue = self.dbDict[fileName];
            if (!queue)
            {
                queue = [self createQueueWithFileName:fileName];
                NSMutableDictionary *mud = (self.dbDict?:@{}).mutableCopy;
                mud[fileName] = queue;
                self.dbDict = mud.copy;
            }
        }
    }
    return queue;
}

- (FMDatabaseQueue *)createQueueWithFileName:(NSString *)fileName
{
    FVDatabaseFile *dbFile = [FVDatabaseFile objectWithFileName:fileName];
    [dbFile protectFromIcloud];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbFile.filePath];
    return queue;
}

- (void)createTableForStore:(id<FVDatabaseProtocol>)store
{
    [self inStore:store database:^(FMDatabase *db) {
        NSString *query = [NSString databaseCreateTable:[store tableName] columnDescription:[store columnDescription]];
        BOOL isOK = [db executeUpdate:query];
        NSLog(@"%@",@(isOK));
    }];
}

- (void)replaceRowInStore:(id<FVDatabaseProtocol>)store values:(NSArray*)values
{
    [self inStore:store database:^(FMDatabase *db) {
        NSString *query = [NSString databaseReplaceIntoTable:store.tableName columnCount:values.count];
        [db executeQuery:query withArgumentsInArray:values];
    }];
}

@end
