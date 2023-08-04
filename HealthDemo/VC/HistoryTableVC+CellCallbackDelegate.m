//
//  HistoryTableVC+HistoryTableVC_CellCallbackDelegate.m
//  HealthDemo
//
//  Created by ycw on 2023/8/1.
//

#import "HistoryTableVC+CellCallbackDelegate.h"
#import "DBTool.h"

@implementation HistoryTableVC (CellCallbackDelegate)

- (void)toEditVCWithRecord:(HistoryRecord *)record{
    EditVC *editVC = [[EditVC alloc]initWithRecord:record];
    editVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)delRecord:(HistoryRecord *)record withIndex:(NSIndexPath *)indexPath{
    //内存数据
    [self.recordArr removeObjectAtIndex:indexPath.row];
    [self.tableView.mj_header beginRefreshing];
    
    //数据库数据
    [DBTool deleteObject:record inTable:kHistoryRecordTable withClass:HistoryRecord.class];
}

- (void)showAlert:(UIViewController *)alert{
    [self presentViewController:alert animated:YES completion:nil];
}

@end
