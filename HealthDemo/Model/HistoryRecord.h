//
//  HistoryRecord.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <Foundation/Foundation.h>
#import "MyWCDBObject.h"


@interface HistoryRecord : MyWCDBObject

/*
 // An ORM type can be any C types or any ObjC classes which conforms to NSCoding or WCTColumnCoding protocol.
 // An ORM property must contains a setter which can be private
@property (nonatomic, retain) NSString *<#property1#>;
@property (nonatomic, assign) NSInteger <#property2#>;
@property (nonatomic, assign) float <#property3#>;
@property (nonatomic,strong) NSArray *<#property4#>;
@property (nonatomic, readonly) NSDate *<#..........#>;
 */

//@property (nonatomic, assign) int identifier;

@property(nonatomic, assign) float bodyWeight; //体重
@property(nonatomic, assign) float bodyFat; //体脂
@property(nonatomic, assign) float myBMI; //BMI

- (instancetype)initWithBodyWeight:(float)bw bodyFat:(float)bf myBMI:(float)bmi;

@end
