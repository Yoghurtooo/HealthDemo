//
//  HistoryRecord+WCTTableCoding.h
//  HealthDemo
//
//  Created by ycw on 2023/7/26.
//

#import "HistoryRecord.h"
#import <WCDBObjc.h>

@interface HistoryRecord (WCTTableCoding) <WCTTableCoding>

/*
WCDB_PROPERTY(<#property1#>)
WCDB_PROPERTY(<#property2#>)
WCDB_PROPERTY(<#property3#>)
WCDB_PROPERTY(<#property4#>)
WCDB_PROPERTY(<#.........#>)
 */

//WCDB_PROPERTY(identifier)
WCDB_PROPERTY(bodyWeight)
WCDB_PROPERTY(bodyFat)
WCDB_PROPERTY(myBMI)
WCDB_PROPERTY(updatedTime)
WCDB_PROPERTY(createdTime)

@end
