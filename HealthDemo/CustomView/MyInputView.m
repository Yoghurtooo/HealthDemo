//
//  myInputView.m
//  HealthDemo
//
//  Created by ycw on 2023/7/25.
//

#import "MyInputView.h"

NSString *const kBodyWeight = @"体重";
NSString *const kBodyFat = @"体脂";
NSString *const kMyBMI = @"BMI";

@interface MyInputView()

@property(nonatomic, assign) CGFloat labelWidth; //文本label长度
@property(nonatomic, assign) CGFloat stackHeight; //每行高度
@property(nonatomic, assign) CGFloat stackPadding; //行内各个控件间距
@property(nonatomic, assign) UIView* stack; //存储label跟textField

@end

@implementation MyInputView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    [self commonInit];
    
    return self;
}

//控件布局初始化
- (void)commonInit{
    _labelWidth = 44;
    _stackPadding = 8;
    _stackHeight = 44;
    
    UILabel *label = [[UILabel alloc] init];
    _bodyWeightLabel = label;
    UITextField *tf = [[UITextField alloc] init];
    [tf setKeyboardType:(UIKeyboardTypeDecimalPad)];
    _bodyWeightTF = tf;
    
    UILabel *label2 = [[UILabel alloc] init];
    _bodyFatLabel = label2;
    UITextField *tf2 = [[UITextField alloc] init];
    [tf2 setKeyboardType:(UIKeyboardTypeDecimalPad)];
    _bodyFatTF = tf2;
    
    UILabel *label3 = [[UILabel alloc] init];
    _myBMILabel = label3;
    UITextField *tf3 = [[UITextField alloc] init];
    [tf3 setKeyboardType:(UIKeyboardTypeDecimalPad)];
    _myBMITF = tf3;
    
    NSArray<UILabel *> *labelArr = @[_bodyWeightLabel,_bodyFatLabel,_myBMILabel];
    NSArray<UITextField *> *tfArr = @[_bodyWeightTF,_bodyFatTF,_myBMITF];
    NSArray<NSString *> *textArr = @[kBodyWeight,kBodyFat,kMyBMI];
    
    for (int i = 0; i<textArr.count; i++) {
        NSString* text = [textArr objectAtIndex:i];
        [self createInputModelWithLabelText:text label:[labelArr objectAtIndex:i] textField:[tfArr objectAtIndex:i] index:i];
    }
    
}

//创建每行的输入框和Label
- (void)createInputModelWithLabelText:(NSString *)text label:(UILabel *)label textField:(UITextField *)tf index:(int)index{
    
    label.font = [UIFont systemFontOfSize:18];
    label.text = text;
//    label.textAlignment = NSTextAlignmentCenter;
    
//    [tf setValue:@8 forKey:@"paddingLeft"];
    tf.textAlignment = NSTextAlignmentCenter;
    
    UIView* stack = [[UIView alloc] init];
    _stack = stack;
    [stack addSubview:label];
    [stack addSubview:tf];
    [self addSubview:stack];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(_labelWidth));
        make.leading.mas_equalTo(stack);
        make.centerY.mas_equalTo(stack);
    }];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(label.mas_trailing).offset(_stackPadding);
        make.trailing.mas_equalTo(stack);
        make.centerY.mas_equalTo(stack);
    }];
    
    [stack mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(@(_stackHeight));
           make.leading.mas_equalTo(self);
           make.trailing.mas_equalTo(self);
           make.top.mas_equalTo(self).offset((_stackHeight + _stackPadding)*index);
       }];

    //下划线
    UIView *underline = [[UIView alloc] init];
    underline.backgroundColor = [UIColor grayColor];
    [self addSubview:underline];
    
    [underline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.leading.mas_equalTo(tf);
        make.trailing.mas_equalTo(tf);
        make.top.mas_equalTo(tf.mas_bottom);
    
    }];
    
}


@end
