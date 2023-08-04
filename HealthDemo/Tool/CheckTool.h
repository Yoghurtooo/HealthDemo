//
//  CheckTool.h
//  HealthDemo
//
//  Created by ycw on 2023/8/2.
//

#import <Foundation/Foundation.h>
#import "MyInputView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    InputComplianceCorrect,//格式正确
    InputComplianceErrorIncomplete,//未输入完整
    InputComplianceErrorDatatype,//输入数据格式错误
    InputComplianceErrorBoth //未输入完整+输入数据格式错误
} InputCompliance;//输入合规性枚举

@interface CheckTool : NSObject

//检查InputView中所有textView的输入数据是否合规
+ (InputCompliance)checkComplianceForInputView:(MyInputView *)myInputView;

+ (instancetype)__unavailable init;

@end

NS_ASSUME_NONNULL_END
