//
//  HXInputStudentsNameStore.m
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "HXInputStudentsNameStore.h"
#import "NSString+DBUse.h"
@implementation HXInputStudentsNameStore

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [FVDB createTableForStore:self];
        });
    }
    return self;
}

- (NSArray<StudentModel *> *)queryStudentsWithTeacherID:(NSInteger)teacherID
{
    NSMutableArray *ret = [NSMutableArray array];
    [FVDB inStore:self database:^(FMDatabase *db) {
        NSString *cmd = [NSString stringWithFormat:@"select * from %@ weher id = %@",self.tableName,@(teacherID)];
        FMResultSet *set = [db executeQuery:cmd];
        while (set.next)
        {
            StudentModel *post = [self makeModelFromSet:set];
            [ret addObject:post];
        }
        [set close];
    }];
    return ret.copy;
}

- (void)writeDateWithStudentList:(NSArray<StudentModel *>*)stus
{
    [FVDB inStore:self database:^(FMDatabase *db) {
       [stus enumerateObjectsUsingBlock:^(StudentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           NSArray *values = @[
                               @(obj.teacherID),
                               obj.name
                               ];
           NSString *cmd = [NSString databaseReplaceIntoTable:self.tableName columnCount:values.count];
           [db executeUpdate:cmd withArgumentsInArray:values];
       }];
    }];
}

- (StudentModel *)makeModelFromSet:(FMResultSet *)set
{
    StudentModel *model = [[StudentModel alloc] init];
    model.teacherID = [set intForColumn:@"id"];
    model.name = [set stringForColumn:@"name"];
    return model;
}

- (NSString *)databaseName
{
    return @"smartInput.sqlite";
}

- (NSString *)tableName
{
    return @"t_smartInput";
}

- (NSString *)columnDescription
{
    return @""
    "id integer primary key,"
    "name varchar(64) not null";
}

@end
