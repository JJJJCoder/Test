//
//  NSDictionary+Extension.h
//  RemindTeacher_iOS
//
//  Created by 张浩 on 16/5/9.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

- (BOOL)isEmpty;

- (NSArray *)allKeysSorted;

- (NSArray *)allValuesSortedByKeys;

- (BOOL)containsObjectForKey:(id)key;

- (NSDictionary *)entriesForKeys:(NSArray *)keys;

@end

@interface NSMutableDictionary (Extension)

- (id)popObjectForKey:(id)aKey;

@end