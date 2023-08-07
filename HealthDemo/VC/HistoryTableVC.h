//
//  HistoryTableVC.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <MJRefresh/MJRefresh.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "EditVC.h"
#import "HistoryCell.h"
#import "HistoryRecord.h"
#import "HistoryRecordDB.h"
//#import "HistoryRecord+WCTTableCoding.h"
NS_ASSUME_NONNULL_BEGIN

@interface HistoryTableVC : UIViewController <UITableViewDelegate, UITableViewDataSource, CellCallbackDelegate>

//数据源
@property (nonatomic, strong) NSMutableArray<HistoryRecord *> *recordArr;

@end

NS_ASSUME_NONNULL_END
