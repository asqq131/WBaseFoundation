//
//  NSCalendar+Timestamp.h
//  efangxue_teacher
//
//  Created by mac on 15/11/13.
//  Copyright (c) 2015年 macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponents (Timestamp)

+ (NSDateComponents *)dateCalendarWithTimestamp:(NSString *)timestamp;

+ (NSDateComponents *)dateCalendarWithDate:(NSDate *)date;

@end
