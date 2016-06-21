//
//  NSString+MoneyFormat.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSString+MoneyFormat.h"

@implementation NSString (MoneyFormat)

//  转化钱的显示格式
+ (NSString *)moneyFormatConversion:(NSString *)money {
    NSMutableString *muStr = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%lld",[money longLongValue]]];
    NSString *floatStr =[NSString stringWithFormat:@"%.2f",[money doubleValue]];
    NSRange range = [floatStr rangeOfString:@"."];
    NSString *str2 = @"";
    
    if (range.length > 0)
        str2 = [floatStr substringFromIndex:range.location];
    
    if (0 == [money longLongValue] / 1000) {
        [muStr insertString:str2 atIndex:muStr.length];
        
        return muStr;
    }
    
    if (0 == [money longLongValue] / 1000000) {
        [muStr insertString:@"," atIndex:muStr.length - 3];
        [muStr insertString:str2 atIndex:muStr.length];
        
        return muStr;
    }
    
    if (0 == [money longLongValue] / 1000000000) {
        [muStr insertString:@"," atIndex:muStr.length - 6];
        [muStr insertString:@"," atIndex:muStr.length - 3];
        [muStr insertString:str2 atIndex:muStr.length];
        
        return muStr;
    }
    
    if (0 == [money longLongValue] / 1000000000000) {
        
        [muStr insertString:@"," atIndex:muStr.length - 9];
        [muStr insertString:@"," atIndex:muStr.length - 6];
        [muStr insertString:@"," atIndex:muStr.length - 3];
        [muStr insertString:str2 atIndex:muStr.length];
        return muStr;
    }
    
    if (0 == [money longLongValue] / 1000000000000000) {
        [muStr insertString:@"," atIndex:muStr.length - 12];
        [muStr insertString:@"," atIndex:muStr.length - 9];
        [muStr insertString:@"," atIndex:muStr.length - 6];
        [muStr insertString:@"," atIndex:muStr.length - 3];
        [muStr insertString:str2 atIndex:muStr.length];
        
        return muStr;
    }
    
    if (0 == [money longLongValue] / 1000000000000000000){
        [muStr insertString:@"," atIndex:muStr.length - 15];
        [muStr insertString:@"," atIndex:muStr.length - 12];
        [muStr insertString:@"," atIndex:muStr.length - 9];
        [muStr insertString:@"," atIndex:muStr.length - 6];
        [muStr insertString:@"," atIndex:muStr.length - 3];
        [muStr insertString:str2 atIndex:muStr.length];
        
        return muStr;
    }
    
    return muStr;
}

@end
