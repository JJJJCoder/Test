//
//  NSString+DBUse.m
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "NSString+DBUse.h"

@implementation NSString (DBUse)

+ (NSString *)databaseCreateTable:(NSString *)tableName columnDescription:(NSString *)column
{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",tableName,column];
}

+ (NSString *)databaseReplaceIntoTable:(NSString *)tableName columnCount:(NSUInteger)columnCount
{
    NSParameterAssert(columnCount);
    return [NSString stringWithFormat:@"REPLACE INTO %@ VALUES (%@?)",tableName,[@"?," repeatTimes:columnCount - 1]];
}

- (NSString *)repeatTimes:(NSUInteger)count
{
    NSMutableString *mulStr = [NSMutableString string];
    for (int i = 0; i < count; i++)
    {
        [mulStr appendString:self];
    }
    return mulStr.copy;
}

@end
