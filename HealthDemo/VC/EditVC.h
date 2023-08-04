//
//  EditVC.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import <UIKit/UIKit.h>
#import "HistoryRecord.h"


NS_ASSUME_NONNULL_BEGIN

@interface EditVC : UIViewController

- (instancetype)initWithRecord:(HistoryRecord *)record;

@end

NS_ASSUME_NONNULL_END
