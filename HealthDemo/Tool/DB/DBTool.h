//
//  DatabaseManager.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <Foundation/Foundation.h>

#import <WCDBObjc/WCDBObjc.h>
#import "Constants.h"
#import "HistoryRecord.h"
#import "MyInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBTool : NSObject

//数据库对象
+ (WCTDatabase *)shareDatabase;
//创建表
+ (BOOL)createTableWithName:(nonnull NSString *)tableName withClass:(Class)className;

- (instancetype)__unavailable init;

@end

NS_ASSUME_NONNULL_END
