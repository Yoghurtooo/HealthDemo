//
//  historyCell.m
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <Masonry.h>
#import "HistoryCell.h"

typedef void (^BtnNormalConstraint)(MASConstraintMaker *);

@interface HistoryCell ()

@property (nonatomic, strong) UILabel *bodyWeightLabel;
@property (nonatomic, strong) UILabel *bodyFatLabel;
@property (nonatomic, strong) UILabel *myBMILabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *delBtn;

@end


@implementation HistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)toEditVC {
    [self.delegate toEditVCWithRecord:self.record];
}

- (void)delRecord {
    [self.delegate delRecord:self.record];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self createViews];
        [self createConstraints];
    }

    return self;
}

//创建视图
- (void)createViews {
    UIButton *editBtn = [[UIButton alloc] init];

    _editBtn = editBtn;
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editBtn.titleLabel.numberOfLines = 0;
    editBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [editBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    editBtn.backgroundColor = [UIColor systemGreenColor];
    editBtn.layer.masksToBounds = YES;
    editBtn.layer.cornerRadius = 8;
    [editBtn setEnabled:YES];

    [_editBtn addTarget:self action:@selector(toEditVC) forControlEvents:UIControlEventTouchUpInside];

    UIButton *delBtn = [[UIButton alloc] init];
    _delBtn = delBtn;
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    delBtn.titleLabel.numberOfLines = 0;
    delBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [delBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    delBtn.backgroundColor = [UIColor systemRedColor];
    delBtn.layer.masksToBounds = YES;
    delBtn.layer.cornerRadius = 8;
    [delBtn setEnabled:YES];

    [_delBtn addTarget:self action:@selector(delRecord) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:delBtn];
    [self.contentView addSubview:editBtn];

    //Label
    UILabel *bodyWeightLabel = [[UILabel alloc] init];
    _bodyWeightLabel = bodyWeightLabel;

    UILabel *bodyFatLabel = [[UILabel alloc] init];
    _bodyFatLabel = bodyFatLabel;

    UILabel *myBMILabel = [[UILabel alloc] init];
    _myBMILabel = myBMILabel;

    UILabel *timeLabel = [[UILabel alloc] init];
    _timeLabel = timeLabel;

    [self.contentView addSubview:bodyWeightLabel];
    [self.contentView addSubview:bodyFatLabel];
    [self.contentView addSubview:myBMILabel];
    [self.contentView addSubview:timeLabel];
}

//创建约束
- (void)createConstraints {
    BtnNormalConstraint cons = ^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(32));
        make.height.mas_equalTo(@(64));
        make.centerY.mas_equalTo(self.contentView);
    };

    [_delBtn mas_makeConstraints:cons];
    [_delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).offset(-16);
    }];


    [_editBtn mas_makeConstraints:cons];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(_delBtn.mas_leading).offset(-8);
    }];

    int kPadding = 16;
    int kLabelWidth = 128;

    [_bodyWeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(kLabelWidth));
        make.top.mas_equalTo(self.contentView).offset(kPadding);
        make.leading.mas_equalTo(self.contentView).offset(kPadding);
    }];

    [_bodyFatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(kLabelWidth));
        make.top.mas_equalTo(self.contentView).offset(kPadding);
        make.leading.mas_equalTo(_bodyWeightLabel.mas_trailing).offset(kPadding);
    }];

    [_myBMILabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(kLabelWidth));
        make.top.mas_equalTo(_bodyWeightLabel.mas_bottom).offset(kPadding);
        make.leading.mas_equalTo(self.contentView).offset(kPadding);
    }];

    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.greaterThanOrmas_equalTo(@(120));
        make.top.mas_equalTo(_myBMILabel.mas_bottom).offset(kPadding);
        make.leading.mas_equalTo(self.contentView).offset(kPadding);
        make.trailing.mas_equalTo(_editBtn.mas_leading).offset(kPadding);
    }];
}

- (void)setRecord:(HistoryRecord *)record {
    _record = record;

    _bodyWeightLabel.text = [NSString stringWithFormat:@"体重  %.1f", self.record.bodyWeight];
    _bodyFatLabel.text = [NSString stringWithFormat:@"体脂  %.1f", self.record.bodyFat];
    _myBMILabel.text = [NSString stringWithFormat:@"BMI   %.1f", self.record.myBMI];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.record.createdTime];
//    NSLog(@"%f",date.timeIntervalSince1970);

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"时间: yyyy-MM-dd HH:mm:ss"];
//    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间

    NSString *dateString = [dateFormatter stringFromDate:date];
    _timeLabel.text = dateString;
}

@end
