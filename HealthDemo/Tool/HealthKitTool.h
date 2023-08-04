//
//  HealKitTool.h
//  HealthDemo
//
//  Created by ycw on 2023/8/2.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import "HistoryRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface HealthKitTool : NSObject

//获取当前HealthKit是否可用
+ (BOOL)isAvailable;
//请求同步数据到HealthApp权限
+ (void)requestPermissions;
//保存数据到HealthApp
+ (void)saveRecord:(HistoryRecord *)record withCompletion:(void (^)(BOOL success, NSError *_Nullable error))completion;

- (instancetype)__unavailable init;

@end

NS_ASSUME_NONNULL_END
