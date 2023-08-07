//
//  HistoryTableVC.m
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <Masonry/Masonry.h>

#import "HistoryTableVC.h"


@interface HistoryTableVC ()

@property (nonatomic, strong) UITableView *tableView;

@end

//cellID
NSString *const cellId = @"historyCellID";

@implementation HistoryTableVC

- (UITableView *)tableView {
    //懒加载
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView registerClass:HistoryCell.class forCellReuseIdentifier:cellId];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }

    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createViews];
}

- (void)viewWillAppear:(BOOL)animated {
    //请求本地数据库数据
    [self.tableView.mj_header beginRefreshing];
}

- (void)createViews {
    //bar设置
    self.navigationItem.title = @"历史记录";
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"chevron.left"]];
    [backBtn setTarget:self];
    [backBtn setAction:@selector(backRootVC)];
    self.navigationItem.leftBarButtonItem = backBtn;

    //添加tableview；
    [self.view addSubview:self.tableView];
    //设置约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    //下拉刷新
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    [header setAutomaticallyChangeAlpha:YES];
    self.tableView.mj_header = header;
}

- (void)requestData {
    //请求本地数据库数据
    self.recordArr = [HistoryRecordDB getObjectsByOrder:YES withColumn:kCreatedTimeCol];
}

- (void)backRootVC {
//    NSLog(@"退出界面");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

//    if (cell == nil) {
//        cell = [[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }

    //获取index对应数据
    HistoryRecord *record = self.recordArr[indexPath.row];

    //更新cell数据
    cell.indexPath = indexPath;
    cell.record = record;

    //设置代理
    cell.delegate = self;

    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 128;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

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
        for (HistoryRecord *obj in self.recordArr) {
            if (obj.createdTime == record.createdTime) {
                [self.recordArr removeObject:obj];
                break;
            }
        }

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
