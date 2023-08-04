//
//  HistoryCell.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <UIKit/UIKit.h>
#import "HistoryRecord.h"
#import "Constants.h"
#import "CellCallbackDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCell : UITableViewCell

@property(nonatomic, strong) NSIndexPath *indexPath; //当前cell在TableView的indexPath
@property(nonatomic, strong) HistoryRecord *record; //数据

@property(nonatomic, weak) id<CellCallbackDelegate> delegate;

//利用record更新Cell的显示内容
- (void)updateViewWithRecord:(HistoryRecord *)record;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier historyRecord:(HistoryRecord *)record;

@end

NS_ASSUME_NONNULL_END
