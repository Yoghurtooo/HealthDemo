//
//  DatabaseManager.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <Foundation/Foundation.h>

#import "Constants.h"
#import "HistoryRecord.h"
#import "MyInputView.h"
#import "MyWCDBObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBTool : NSObject

//+ (WCTDatabase *)shareDatabase;

//插入数据
+ (BOOL)insertObject:(id)object inTable:(nonnull NSString *)tableName withClass:(Class)className;
//删除数据
+ (BOOL)deleteObject:(id)object inTable:(nonnull NSString *)tableName withClass:(Class)className;
//更新数据
+ (BOOL)updateObject:(id)object inTable:(nonnull NSString *)tableName withClass:(Class)className;
//获取全部数据
+ (NSMutableArray<id> *)getObjectsInTable:(nonnull NSString *)tableName withClass:(Class)className;
//创建表
+ (BOOL)createTableWithName:(nonnull NSString *)tableName withClass:(Class)className;

- (instancetype)__unavailable init;
@end

NS_ASSUME_NONNULL_END
