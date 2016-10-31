//
//  NSCalendar+Timestamp.m
//  efangxue_teacher
//
//  Created by mac on 15/11/13.
//  Copyright (c) 2015年 macmini. All rights reserved.
//

#import "NSDateComponents+Timestamp.h"

@implementation NSDateComponents (Timestamp)

+ (NSDateComponents *)dateCalendarWithTimestamp:(NSString *)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue] / 1000];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    
    return comps;
}

+ (NSDateComponents *)dateCalendarWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    
    return comps;
}

@end
