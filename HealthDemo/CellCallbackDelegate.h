//
//  CellCallbackDelegate.h
//  HealthDemo
//
//  Created by ycw on 2023/8/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CellCallbackDelegate <NSObject>

//跳转编辑页面
- (void)toEditVCWithRecord:(HistoryRecord *)record;
//通过index删除对应记录
- (void)delRecord:(HistoryRecord *)record withIndex:(NSIndexPath *)indexPath;
//在vc中展示提示框
- (void)showAlert:(UIViewController *)alert;

@end

NS_ASSUME_NONNULL_END
