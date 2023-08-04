//
//  DatabaseManager.m
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import "DBTool.h"
#import <WCDBObjc.h>
#import "HistoryRecord+WCTTableCoding.h"
#import <HealthKit/HealthKit.h>

@interface DBTool()
@end

static WCTDatabase *database = nil;

@implementation DBTool

//获取数据库单例对象
+ (WCTDatabase *)shareDatabase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:kDatabaseSubPath];
//        NSLog(path);
        database = [[WCTDatabase alloc] initWithPath:path];
    });
    return database;
}

+ (BOOL)createTableWithName:(NSString *)tableName withClass:(Class)className{
    WCTDatabase *database = [DBTool shareDatabase];
    BOOL result = [database createTable:tableName withClass:className];
    return result;
}

+ (BOOL)insertObject:(id)object inTable:(NSString *)tableName withClass:(Class)className{
    WCTDatabase *database = [DBTool shareDatabase];
    [database createTable:tableName withClass:className];
    WCTTable *table = [database getTable:tableName withClass:className];
    //开始存储
    BOOL saveResult = [table insertObject:object];
    return saveResult;
}

+ (BOOL)deleteObject:(id)object inTable:(NSString *)tableName withClass:(Class)className{
    WCTDatabase *database = [DBTool shareDatabase];
    WCTTable *table = [database getTable:tableName  withClass:className];
    //开始删除
    MyWCDBObject *obj = (MyWCDBObject *)object;
    BOOL result = [table deleteObjectsWhere: WCDB::Expression(WCDB::Column("createdTime") == obj.createdTime)];
    return result;
}

+ (BOOL)updateObject:(id)object inTable:(NSString *)tableName withClass:(Class)className{
    WCTDatabase *database = [DBTool shareDatabase];
    WCTTable *table = [database getTable:tableName  withClass:className];
    
    BOOL result = NO;
    if ([tableName isEqualToString:kHistoryRecordTable]) {
        //历史记录表
        HistoryRecord *record = (HistoryRecord *)object;
        record.updatedTime = [NSDate now].timeIntervalSince1970;
        result = [table updateProperties: HistoryRecord.allProperties toObject:record where:HistoryRecord.createdTime == record.createdTime];
    }
    return result;
}

+ (NSMutableArray<id> *)getObjectsInTable:(NSString *)tableName withClass:(Class)className{
    WCTDatabase *database = [DBTool shareDatabase];
    [database createTable:tableName withClass:className];
    WCTTable *table = [database getTable:tableName withClass:className];
    return [[NSMutableArray alloc] initWithArray:[table getObjectsOrders:WCDB::Column("createdTime").asOrder(WCTOrderedDescending)]];
}


@end
