//
//  NSString+DBUse.h
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DBUse)

+ (NSString *)databaseCreateTable:(NSString *)tableName columnDescription:(NSString *)column;

+ (NSString *)databaseReplaceIntoTable:(NSString *)tableName columnCount:(NSUInteger)columnCount;


@end
