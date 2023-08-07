//
//  ViewController.m
//  HealthDemo
//
//  Created by ycw on 2023/7/25.
//

#import "HomeVC.h"
#import "MyInputView.h"

#import "AlertTool.h"
#import "CheckTool.h"
#import "Constants.h"
#import "HealthKitTool.h"
#import "HistoryRecord.h"
#import "HistoryRecordDB.h"
#import "HistoryTableVC.h"

//#import <MapKit/MapKit.h>


@interface HomeVC ()

@property (nonatomic, strong) MyInputView *myInputView;
@property (nonatomic, strong) UILabel *syncLabel;
@property (nonatomic, strong) UISwitch *syncSwitch;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *historyBtn;
@property (nonatomic, strong) UIImageView *thunderImageView;
@property (nonatomic, strong) UIView *stack; //存储syncLabel+syncSwitch+thunderImageView

@end



@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"首页";

    [self createViews];//创建view
    [self createConstraints];//创建约束

    //获取同步信息
    BOOL isSync = [[NSUserDefaults standardUserDefaults] boolForKey:kIsSync];
    [_syncSwitch setOn:isSync];
//    NSLog(@"%d", isSync);

    [_syncSwitch addTarget:self action:@selector(recordIsSync:) forControlEvents:UIControlEventValueChanged];
    [_historyBtn addTarget:self action:@selector(toHistoryTableVC) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn addTarget:self action:@selector(saveRecord) forControlEvents:UIControlEventTouchUpInside];
}

- (void)saveRecord {
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

    //创建Model对象
    CGFloat bw = _myInputView.bodyWeightTF.text.floatValue;
    CGFloat bf = _myInputView.bodyFatTF.text.floatValue;
    CGFloat bmi = _myInputView.myBMITF.text.floatValue;
    HistoryRecord *record = [[HistoryRecord alloc] initWithBodyWeight:bw bodyFat:bf myBMI:bmi];

    //数据库操作
    BOOL saveResult = [HistoryRecordDB insertObject:record];

    //提示信息
    if (saveResult) {
        //保存成功
        //清空输入框数据
        NSArray<UITextField *> *arr = @[_myInputView.bodyWeightTF, _myInputView.bodyFatTF, _myInputView.myBMITF];

        for (UITextField *tf in arr) {
            tf.text = @"";
        }

        //是否开始同步
        //同步AppleHealth
        if (_syncSwitch.isOn) {
            NSLog(@"开始同步");
            [HealthKitTool saveRecord:record
                       withCompletion:^(BOOL success, NSError *_Nullable error) {
                //结果回调函数
                dispatch_async(dispatch_get_main_queue(), ^{
                                   NSString *str = @"";

                                   if (!success && saveResult) {
                                       //本地保存成功，但是同步失败
                                       str = @"保存本地数据成功，但是同步失败，请稍后再试";
                                   } else {
                                       //本地保存成功，同步成功
                                       str = @"保存成功";
                                   }

                                   //显示提示框
                                   [AlertTool showRemindAlertInVC:self withMessage:str];
                               });
            }];
        } else {
            NSLog(@"不同步");
            [AlertTool showRemindAlertInVC:self withMessage:@"保存成功"];
        }
    } else {
        //保存失败，提示框
        [AlertTool showRemindAlertInVC:self withMessage:@"保存失败，请重试"];
    }
}

//记录当前同步switch状态
- (void)recordIsSync:(id)sender {
    if (![HealthKitTool isAvailable]) {
        //无法使用健康同步
        [_syncSwitch setOn:NO animated:YES];

        [AlertTool showRemindAlertInVC:self withMessage:@"该设备无法使用Apple Health同步功能"];
        return;
    }

    //记录同步信息
    BOOL isSync = _syncSwitch.isOn;
//    NSLog(@"开始前%d",isSync);
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    [us setBool:isSync forKey:kIsSync];
    [us synchronize];
}

//前往历史页面
- (void)toHistoryTableVC {
    HistoryTableVC *historyTVC = [[HistoryTableVC alloc] init];

    historyTVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController pushViewController:historyTVC animated:YES];
}

//子控件初始化
- (void)createViews {
//    self.view.backgroundColor = [UIColor systemGray6Color];

    ///输入框行
    MyInputView *input = [[MyInputView alloc] init];

    _myInputView = input;
    [self.view addSubview:input];

    ///同步行
    UILabel *label = [[UILabel alloc] init];
    _syncLabel = label;
    label.text = @"Apple Health同步";
    label.font = [UIFont systemFontOfSize:18];

    UISwitch *sw = [[UISwitch alloc] init];
    _syncSwitch = sw;
    sw.enabled = YES;

    UIImageView *thunder = [[UIImageView alloc] init];
    _thunderImageView = thunder;
    [thunder setImage:[UIImage imageNamed:@"thunder"]];
    thunder.backgroundColor = [UIColor yellowColor];
    thunder.layer.borderWidth = 1;
    thunder.layer.borderColor = [UIColor systemGrayColor].CGColor;

    UIView *stack = [[UIView alloc] init];
    _stack = stack;
    [stack addSubview:label];
    [stack addSubview:sw];
    [stack addSubview:thunder];

    [self.view addSubview:stack];

    ///按钮
    UIButton *save = [[UIButton alloc] init];
    _saveBtn = save;
    [save setTitle:@"保 存" forState:UIControlStateNormal];
    save.backgroundColor = [UIColor systemBlueColor];
    save.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    save.layer.masksToBounds = YES;
    save.layer.cornerRadius = 8;

    UIButton *history = [[UIButton alloc] init];
    _historyBtn = history;
    [history setTitle:@"历史记录" forState:UIControlStateNormal];
    history.backgroundColor = [UIColor systemGreenColor];
    history.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    history.layer.masksToBounds = YES;
    history.layer.cornerRadius = 8;

    [self.view addSubview:save];
    [self.view addSubview:history];
}

- (void)createConstraints {
    //输入框约束
    [_myInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(64);
//        make.top.mas_equalTo(@(100));
        make.leading.mas_equalTo(self.view).offset(64);
        make.trailing.mas_equalTo(self.view).offset(-64);
    }];

    //同步行约束
    [_syncSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(48);
        make.centerY.mas_equalTo(_stack);
        make.trailing.mas_equalTo(_stack);
    }];

    [_thunderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(16);
        make.trailing.mas_equalTo(_syncSwitch);
        make.bottom.mas_equalTo(_syncSwitch.mas_top).offset(8);
    }];

    [_syncLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(@(64));
//        make.width.mas_equalTo(@(64));
        make.centerY.mas_equalTo(_stack);
        make.trailing.mas_equalTo(_syncSwitch.mas_leading);
        make.leading.mas_equalTo(_stack);
    }];

    [_stack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(64);
        make.top.mas_equalTo(_myInputView.mas_bottom);
        make.leading.mas_equalTo(_myInputView);
        make.trailing.mas_equalTo(_myInputView);
    }];

    //按钮约束
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(32);
        make.leading.mas_equalTo(_myInputView);
        make.trailing.mas_equalTo(_myInputView);
        make.top.mas_equalTo(_stack.mas_bottom).offset(16);
    }];

    [_historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(32);
        make.leading.mas_equalTo(_myInputView);
        make.trailing.mas_equalTo(_myInputView);
        make.top.mas_equalTo(_saveBtn.mas_bottom).offset(16);
    }];
}

@end
