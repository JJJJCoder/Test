//
//  HXInputStudentsNameStore.h
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FVDatabase.h"
#import "StudentModel.h"

@interface HXInputStudentsNameStore : NSObject<FVDatabaseProtocol>

- (NSArray<StudentModel *> *)queryStudentsWithTeacherID:(NSInteger)teacherID;

- (void)writeDateWithStudentList:(NSArray<StudentModel *>*)stus;

@end
