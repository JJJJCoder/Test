//
//  FVDatabaseProtocol.h
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FVDatabaseProtocol <NSObject>

/** 数据库名称 */
- (NSString *)databaseName;
/** 表名称 */
- (NSString *)tableName;
/** 列描述 */
- (NSString *)columnDescription;

@end
