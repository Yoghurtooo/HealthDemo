//
//  MyWCDBObject.h
//  HealthDemo
//
//  Created by ycw on 2023/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyWCDBObject : NSObject

//记录更新时间
@property (nonatomic, assign) UInt64 updatedTime;
//记录创建时间
@property (nonatomic, assign) UInt64 createdTime;

@end

NS_ASSUME_NONNULL_END
