//
//  AlertTool.m
//  HealthDemo
//
//  Created by ycw on 2023/8/3.
//

#import "AlertTool.h"

@implementation AlertTool

+ (void)showRemindAlertInVC:(UIViewController *)vc withMessage:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}];
    [alert addAction:action];
    
    [vc presentViewController:alert animated:YES completion:nil];
}
@end
