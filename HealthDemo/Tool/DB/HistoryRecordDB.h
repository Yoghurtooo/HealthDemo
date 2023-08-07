//
//  HistoryRecordDB.h
//  HealthDemo
//
//  Created by ycw on 2023/8/7.
//

#import <Foundation/Foundation.h>
#import "HistoryRecord.h"
NS_ASSUME_NONNULL_BEGIN

@interface HistoryRecordDB : NSObject

//插入数据
+ (BOOL)insertObject:(HistoryRecord *)object;
//删除数据
+ (BOOL)deleteObject:(HistoryRecord *)object;
//更新数据
+ (BOOL)updateObject:(HistoryRecord *)object;
//获取全部数据,通过某列进行降序/升序排序
+ (NSMutableArray<HistoryRecord *> *)getObjectsByOrder:(BOOL)isDESC withColumn:(NSString *)columnName;
//扩展其他方式查询
//......

- (instancetype)__unavailable init;

@end

NS_ASSUME_NONNULL_END
