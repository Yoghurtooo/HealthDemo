//
//  HistoryRecord.mm
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import "HistoryRecord+WCTTableCoding.h"
#import "HistoryRecord.h"

@implementation HistoryRecord

/*
   WCDB_IMPLEMENTATION(HistoryRecord)
   WCDB_SYNTHESIZE(<#SYNTHESIZE1#>)
   WCDB_SYNTHESIZE(<#SYNTHESIZE2#>)
   WCDB_SYNTHESIZE(<#SYNTHESIZE3#>)
   WCDB_SYNTHESIZE(<#SYNTHESIZE4#>)
   WCDB_SYNTHESIZE_COLUMN(<#SYNTHESIZE5#>, "<#column name#>")   // Custom column name

   WCDB_PRIMARY_AUTO_INCREMENT(<#SYNTHESIZE#>)

   WCDB_INDEX(<#_index_subfix#>, <#SYNTHESIZE#>)
 */
WCDB_IMPLEMENTATION(HistoryRecord)
//WCDB_SYNTHESIZE(identifier)
WCDB_PRIMARY(createdTime)
WCDB_SYNTHESIZE(bodyWeight)
WCDB_SYNTHESIZE(bodyFat)
WCDB_SYNTHESIZE(myBMI)
WCDB_SYNTHESIZE(updatedTime)
WCDB_SYNTHESIZE(createdTime)

- (instancetype)initWithBodyWeight:(CGFloat)bw bodyFat:(CGFloat)bf myBMI:(CGFloat)bmi {
    self = [super init];

    if (self) {
        _bodyWeight = bw;
        _bodyFat = bf;
        _myBMI = bmi;
        self.updatedTime = [NSDate date].timeIntervalSince1970;
        self.createdTime = [NSDate date].timeIntervalSince1970;
    }

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"体重:%fkg, 时间:%lld", self.bodyWeight, self.createdTime];
}

@end
