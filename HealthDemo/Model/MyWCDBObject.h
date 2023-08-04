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
@property(nonatomic, assign) int64_t updatedTime;
//记录创建时间
@property(nonatomic, assign) int64_t createdTime;

@end

NS_ASSUME_NONNULL_END
