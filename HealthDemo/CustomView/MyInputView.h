//
//  myInputView.h
//  HealthDemo
//
//  Created by ycw on 2023/7/25.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyInputView : UIView

@property(nonatomic, strong) UITextField *bodyWeightTF;
@property(nonatomic, strong) UITextField *bodyFatTF;
@property(nonatomic, strong) UITextField *myBMITF;

@property(nonatomic, strong) UILabel *bodyWeightLabel;
@property(nonatomic, strong) UILabel *bodyFatLabel;
@property(nonatomic, strong) UILabel *myBMILabel;

@end

NS_ASSUME_NONNULL_END
