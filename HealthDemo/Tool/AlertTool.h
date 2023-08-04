//
//  AlertTool.h
//  HealthDemo
//
//  Created by ycw on 2023/8/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlertTool : NSObject

//在vc上展示简单提示信息框（只有OK选项的提示框）
+ (void)showRemindAlertInVC:(UIViewController *)vc withMessage:(NSString *)msg;

+ (instancetype) __unavailable init;
@end

NS_ASSUME_NONNULL_END
