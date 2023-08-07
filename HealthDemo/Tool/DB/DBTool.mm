//
//  DatabaseManager.m
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <HealthKit/HealthKit.h>
#import <WCDBObjc.h>
#import "DBTool.h"
#import "HistoryRecord+WCTTableCoding.h"

@interface DBTool ()
@end

static WCTDatabase *database = nil;

@implementation DBTool

//获取数据库单例对象
+ (WCTDatabase *)shareDatabase {
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:kDatabaseSubPath];
        //        NSLog(path);
        database = [[WCTDatabase alloc] initWithPath:path];
        [database createTable:kHistoryRecordTable withClass:HistoryRecord.class];
    });
    return database;
}

+ (BOOL)createTableWithName:(NSString *)tableName withClass:(Class)className {
    WCTDatabase *database = [DBTool shareDatabase];
    BOOL result = [database createTable:tableName withClass:className];
    return result;
}

@end
