//
//  HistoryTableVC+HistoryTableVC_CellCallbackDelegate.m
//  HealthDemo
//
//  Created by ycw on 2023/8/1.
//

#import "HistoryRecordDB.h"
#import "HistoryTableVC+CellCallbackDelegate.h"

@implementation HistoryTableVC (CellCallbackDelegate)

- (void)toEditVCWithRecord:(HistoryRecord *)record {
    EditVC *editVC = [[EditVC alloc]initWithRecord:record];

    editVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)delRecord:(HistoryRecord *)record {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"是否确认删除？" preferredStyle:UIAlertControllerStyleAlert];

    //确认删除
    UIAlertAction *submit = [UIAlertAction actionWithTitle:@"确认"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction *_Nonnull action) {
        //内存数据
        [self.recordArr removeObjectIdenticalTo:record];
        [self.tableView.mj_header beginRefreshing];

        //数据库数据
        [HistoryRecordDB deleteObject:record];
    }];

    //取消删除
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *_Nonnull action) {
    }];

    [alert addAction:cancel];
    [alert addAction:submit];

    [self presentViewController:alert animated:YES completion:nil];
}

@end
