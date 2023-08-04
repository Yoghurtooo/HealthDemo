//
//  EditVC.m
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import "EditVC.h"
#import "MyInputView.h"
#import <Masonry.h>
#import "CheckTool.h"
#import "DBTool.h"
#import "AlertTool.h"

@interface EditVC ()

@property(nonatomic, strong) MyInputView *myInputView;
@property(nonatomic, strong) UIButton *saveBtn;
@property(nonatomic, strong) HistoryRecord *record;

@end

@implementation EditVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.navigationItem.title = @"记录编辑";
    
    [self createViews];
    
    //初始化数据
    self.myInputView.bodyWeightTF.text = [NSString stringWithFormat:@"%.1f",_record.bodyWeight];
    self.myInputView.bodyFatTF.text = [NSString stringWithFormat:@"%.1f",_record.bodyFat];
    self.myInputView.myBMITF.text = [NSString stringWithFormat:@"%.1f",_record.myBMI];
    
}

- (void)createViews{
    MyInputView *myInputView = [[MyInputView alloc] init];
    _myInputView = myInputView;
    [self.view addSubview:myInputView];
    
    [myInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@200);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(32);
            make.left.equalTo(self.view).offset(64);
            make.right.equalTo(self.view).offset(-64);
    }];
    
    UIButton *saveBtn = [[UIButton alloc] init];
    _saveBtn = saveBtn;
    [saveBtn setTitle:@"保 存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = [UIColor systemBlueColor];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    saveBtn.layer.masksToBounds = YES;
    [saveBtn setEnabled:YES];
    saveBtn.layer.cornerRadius = 8;

    [saveBtn addTarget:self action:@selector(editRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(32));
        make.left.equalTo(myInputView);
        make.right.equalTo(myInputView);
        make.top.equalTo(myInputView.mas_bottom).offset(32);
    }];
}

- (void)editRecord{
    //检查输入合法性
    InputCompliance result = [CheckTool checkComplianceForInputView:self.myInputView];
    if (result != InputComplianceCorrect) {
        NSString *msg = @"";
        //不合法
        switch (result) {
            case InputComplianceErrorBoth:
            case InputComplianceErrorIncomplete:
                msg = @"请输入完成后保存数据";
                NSLog(@"请输入完成后保存数据");
                break;
            case InputComplianceErrorDatatype:
                msg = @"请检查输出格式";
                NSLog(@"请检查输出格式");
                break;
            default:
                break;
        }
        //显示提示框
        [AlertTool showRemindAlertInVC:self withMessage:msg];
        //退出
        return;
    }
    
    float bw = _myInputView.bodyWeightTF.text.floatValue;
    float bf = _myInputView.bodyFatTF.text.floatValue;
    float bmi = _myInputView.myBMITF.text.floatValue;
    self.record.bodyWeight = bw;
    self.record.bodyFat = bf;
    self.record.myBMI = bmi;
    self.record.updatedTime = [NSDate now].timeIntervalSince1970;
    
    //数据更新
    BOOL saveResult = [DBTool updateObject:self.record inTable:kHistoryRecordTable withClass:HistoryRecord.class];
    
    if (saveResult) {
        //保存成功
        //退出页面
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        //保存失败
        //显示提示框
        [AlertTool showRemindAlertInVC:self withMessage:@"保存失败，请重试"];
    }

}

- (instancetype)initWithRecord:(HistoryRecord *)record{
    self = [super init];
    
    if (self) {
        _record = record;
    }
    
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
