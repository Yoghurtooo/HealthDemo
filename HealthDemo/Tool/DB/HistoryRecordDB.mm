//
//  HistoryRecordDB.m
//  HealthDemo
//
//  Created by ycw on 2023/8/7.
//

#import "Constants.h"
#import "DBTool.h"
#import "HistoryRecord+WCTTableCoding.h"
#import "HistoryRecordDB.h"

//当前DB操作类，操作的表名
NSString *const tableName = kHistoryRecordTable;

@implementation HistoryRecordDB

+ (BOOL)insertObject:(HistoryRecord *)object {
    WCTDatabase *database = [DBTool shareDatabase];
    BOOL result = [database createTable:tableName withClass:HistoryRecord.class];

    return result;
}

+ (BOOL)deleteObject:(HistoryRecord *)object {
    WCTDatabase *database = [DBTool shareDatabase];
    WCTTable *table = [database getTable:tableName withClass:HistoryRecord.class];
    //开始删除
    BOOL result = [table deleteObjectsWhere:HistoryRecord.createdTime == object.createdTime];

    return result;
}

+ (BOOL)updateObject:(HistoryRecord *)object {
    WCTDatabase *database = [DBTool shareDatabase];
    WCTTable *table = [database getTable:tableName withClass:HistoryRecord.class];

    object.updatedTime = [NSDate date].timeIntervalSince1970;
    BOOL result = [table updateProperties:HistoryRecord.allProperties toObject:object where:HistoryRecord.createdTime == object.createdTime];
    return result;
}

+ (NSMutableArray<HistoryRecord *> *)getObjectsByOrder:(BOOL)isDESC withColumn:(NSString *)columnName {
    WCTDatabase *database = [DBTool shareDatabase];
    WCTTable *table = [database getTable:tableName withClass:HistoryRecord.class];
    WCDB::Order order = isDESC ? WCTOrderedDescending : WCTOrderedAscending;

    return [[NSMutableArray alloc] initWithArray:[table getObjectsOrders:WCDB::Column(columnName).asOrder(order)]];
}

@end
