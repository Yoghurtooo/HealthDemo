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

NSString *const tableName = kHistoryRecordTable;

@implementation HistoryRecordDB

+ (BOOL)insertObject:(HistoryRecord *)object {
    WCTDatabase *database = [DBTool shareDatabase];
    BOOL result = [database insertObject:object intoTable:tableName];

    return result;
}

+ (BOOL)deleteObject:(HistoryRecord *)object {
    WCTDatabase *database = [DBTool shareDatabase];
    //开始删除
    BOOL result = [database deleteFromTable:tableName where:HistoryRecord.createdTime == object.createdTime];

    return result;
}

+ (BOOL)updateObject:(HistoryRecord *)object {
    WCTDatabase *database = [DBTool shareDatabase];

    object.updatedTime = [NSDate date].timeIntervalSince1970;
    BOOL result = [database updateTable:tableName setProperties:HistoryRecord.allProperties toObject:object where:HistoryRecord.createdTime == object.createdTime];

    return result;
}

+ (NSMutableArray<HistoryRecord *> *)getObjectsByOrder:(BOOL)isDESC withColumn:(NSString *)columnName {
    WCTDatabase *database = [DBTool shareDatabase];
    WCTTable *table = [database getTable:kHistoryRecordTable withClass:HistoryRecord.class];
    WCDB::Order order = isDESC ? WCTOrderedDescending : WCTOrderedAscending;

    NSArray<HistoryRecord *> *arr = [database getObjectsOfClass:HistoryRecord.class fromTable:tableName orders:WCDB::Column(columnName).asOrder(order)];

    return [[NSMutableArray alloc] initWithArray:arr];
}

@end
