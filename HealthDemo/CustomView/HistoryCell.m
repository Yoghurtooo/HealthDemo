//
//  historyCell.m
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import "HistoryCell.h"
#import <Masonry.h>

typedef void(^BtnNormalConstraint)(MASConstraintMaker*);

@interface HistoryCell()

@property(nonatomic, strong) UILabel *bodyWeightLabel;
@property(nonatomic, strong) UILabel *bodyFatLabel;
@property(nonatomic, strong) UILabel *myBMILabel;
@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UIButton *editBtn;
@property(nonatomic, strong) UIButton *delBtn;

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

- (void)toEditVC{
    [self.delegate toEditVCWithRecord:self.record];
}

- (void)delRecord{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"是否确认删除？" preferredStyle:UIAlertControllerStyleAlert];
    
    //确认删除
    UIAlertAction *submit = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        self.delRecordByIndex(self.indexPath);
        [self.delegate delRecord:self.record withIndex:self.indexPath];
    }];
    
    //取消删除
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancel];
    [alert addAction:submit];
    
    [self.delegate showAlert:alert];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier historyRecord:(HistoryRecord *)record{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self updateViewWithRecord:record];
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
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
        
        
        BtnNormalConstraint cons = ^(MASConstraintMaker *make){
            make.width.equalTo(@(32));
            make.height.equalTo(@(64));
            make.centerY.equalTo(self.contentView);
        };
        
        [delBtn mas_makeConstraints:cons];
        [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView).offset(-16);
        }];
        

        [editBtn mas_makeConstraints:cons];
        [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(delBtn.mas_left).offset(-8);
        }];
        
        
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
        
        int kPadding = 16;
        int kLabelWidth = 128;
        
        [bodyWeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@(kLabelWidth));
            make.top.equalTo(self.contentView).offset(kPadding);
            make.left.equalTo(self.contentView).offset(kPadding);
        }];
        
        [bodyFatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@(kLabelWidth));
            make.top.equalTo(self.contentView).offset(kPadding);
            make.left.equalTo(bodyWeightLabel.mas_right).offset(kPadding);
        }];
        
        [myBMILabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(kLabelWidth));
            make.top.equalTo(bodyWeightLabel.mas_bottom).offset(kPadding);
            make.left.equalTo(self.contentView).offset(kPadding);
        }];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.greaterThanOrEqualTo(@(120));
            make.top.equalTo(myBMILabel.mas_bottom).offset(kPadding);
            make.left.equalTo(self.contentView).offset(kPadding);
            make.right.equalTo(editBtn.mas_left).offset(kPadding);
        }];
        
        
    }
    
    return self;
}

- (void)updateViewWithRecord:(HistoryRecord *)record{
    self.record = record;
    _bodyWeightLabel.text = [NSString stringWithFormat: @"体重  %.1f", self.record.bodyWeight];
    _bodyFatLabel.text = [NSString stringWithFormat: @"体脂  %.1f", self.record.bodyFat];
    _myBMILabel.text = [NSString stringWithFormat: @"BMI   %.1f", self.record.myBMI];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.record.createdTime];
//    NSLog(@"%f",date.timeIntervalSince1970);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"时间: yyyy-MM-dd HH:mm:ss"];
//    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    _timeLabel.text = dateString;
    
}


@end
