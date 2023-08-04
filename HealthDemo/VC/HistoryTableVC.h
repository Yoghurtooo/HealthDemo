//
//  HistoryTableVC.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <UIKit/UIKit.h>
#import "HistoryCell.h"
#import "Constants.h"
#import <MJRefresh/MJRefresh.h>
#import "DBTool.h"
#import "EditVC.h"
#import "HistoryRecord.h"
//#import "HistoryRecord+WCTTableCoding.h"
#import "CellCallbackDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface HistoryTableVC : UITableViewController

//数据源
@property(nonatomic, strong) NSMutableArray<HistoryRecord *> *recordArr;

//请求数据
- (void)requestData;

@end

NS_ASSUME_NONNULL_END
