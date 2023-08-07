//
//  HistoryTableVC.m
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <Masonry/Masonry.h>
#import "HistoryTableVC+CellCallbackDelegate.h"
#import "HistoryTableVC.h"


@interface HistoryTableVC ()

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
    [backBtn setEnabled:YES];
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

    if (cell == nil) {
        cell = [[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

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

/*
   // Override to support conditional editing of the table view.
   - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
   }
 */

/*
   // Override to support editing the table view.
   - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
   }
 */

/*
   // Override to support rearranging the table view.
   - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
   }
 */

/*
   // Override to support conditional rearranging of the table view.
   - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
   }
 */

/*
 #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end
