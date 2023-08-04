//
//  HealKitTool.m
//  HealthDemo
//
//  Created by ycw on 2023/8/2.
//

#import "HealthKitTool.h"

@implementation HealthKitTool
+ (BOOL)isAvailable {
    return HKHealthStore.isHealthDataAvailable;
}

+ (void)requestPermissions {
    //健康权限申请
    //NSLog(@"可以使用");
    if ([self isAvailable]) {
        HKQuantityType *bodyWeightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
        HKQuantityType *bodyFatType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];

        HKHealthStore *store = [[HKHealthStore alloc] init];
        NSSet *auth = [NSSet setWithArray:@[bodyWeightType, bodyFatType]];
        [store requestAuthorizationToShareTypes:auth
                                      readTypes:nil
                                     completion:^(BOOL success, NSError *_Nullable error) {
            if (success) {
                NSLog(@"请求权限成功");
            } else {
                NSLog(@"%@", [error description]);
            }
        }];
    } else {
        //无法使用同步功能
        NSLog(@"无法使用同步功能");
    }
}

+ (void)saveRecord:(HistoryRecord *)record withCompletion:(void (^)(BOOL success, NSError *_Nullable error))completion {
    CGFloat bw = record.bodyWeight;
    CGFloat bf = record.bodyFat;

    //时间数据
    NSDate *date = [NSDate date];

    //体重数据
    HKQuantityType *bwType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantity *bwQuantity = [HKQuantity quantityWithUnit:[HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo] doubleValue:bw];
    HKQuantitySample *bodyWeight = [HKQuantitySample quantitySampleWithType:bwType quantity:bwQuantity startDate:date endDate:date];

    //体脂数据
    HKQuantityType *bfType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    HKQuantity *bfQuantity = [HKQuantity quantityWithUnit:[HKUnit percentUnit] doubleValue:bf / 100];
    HKQuantitySample *bodyFat = [HKQuantitySample quantitySampleWithType:bfType quantity:bfQuantity startDate:date endDate:date];

    HKHealthStore *store = [[HKHealthStore alloc] init];
    
    //判断权限状态
    NSMutableArray<HKQuantitySample *> *saveSampleArr = [[NSMutableArray alloc] init];
    if ([store authorizationStatusForType:bwType] == HKAuthorizationStatusSharingAuthorized) {
        //同意同步体重数据
        [saveSampleArr addObject:bodyWeight];
    }
    if ([store authorizationStatusForType:bfType] == HKAuthorizationStatusSharingAuthorized) {
        //同意同步体脂数据
        [saveSampleArr addObject:bodyFat];
    }
    
    if (saveSampleArr.count > 0){
        //保存
        [store saveObjects:saveSampleArr withCompletion:completion];
    }else{
        NSLog(@"没有任何权限");
    }
}

@end
