//
//  HistoryCell.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "HistoryRecord.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CellCallbackDelegate <NSObject>

//跳转编辑页面
- (void)toEditVCWithRecord:(HistoryRecord *)record;
//通过index删除对应记录
- (void)delRecord:(HistoryRecord *)record;

@end

@interface HistoryCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath; //当前cell在TableView的indexPath
@property (nonatomic, strong) HistoryRecord *record; //数据
@property (nonatomic, weak) id<CellCallbackDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
