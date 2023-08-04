//
//  CheckTool.m
//  HealthDemo
//
//  Created by ycw on 2023/8/2.
//

#import "CheckTool.h"

@implementation CheckTool

+ (InputCompliance)checkComplianceForInputView:(MyInputView *)myInputView {
    NSArray<NSString *> *strArr = @[myInputView.bodyWeightTF.text, myInputView.bodyFatTF.text, myInputView.myBMITF.text];
    InputCompliance result = InputComplianceCorrect;

    //检查输入的数据类型
    NSString *regex = @"^[1-9][0-9]*.?[0-9]{0,2}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    for (NSString *str in strArr) {
        //依次对textfield的内容进行输入数据类型检查
        BOOL ret = [pred evaluateWithObject:str];

        if (!ret) {
            //输入数据类型不合规
            result = InputComplianceErrorDatatype;
            break;
        }
    }

    //检查输入完整性
    for (NSString *str in strArr) {
        BOOL ret = (str.length == 0);

        if (ret) {
            //输入数据不完整
            if (result == InputComplianceErrorDatatype) {
                //两个问题都有
                result = InputComplianceErrorBoth;
            } else {
                result = InputComplianceErrorIncomplete;
            }

            break;
        }
    }

    return result;
}

@end
