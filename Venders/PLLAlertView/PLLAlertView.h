//
//  PLLAlertView.h
//  EXG_App
//
//  Created by penglingling on 15/6/15.
//  Copyright (c) 2015年 penglingling. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PLLAlertViewMaskType) {
    PLLAlertViewMaskTypeAllowUIEnabled,          //允许用户点击背景取消掉alertView
    PLLAlertViewMaskTypeNotAllowUIEnabled,       //不允许，只能通过按钮
};

typedef NS_ENUM(NSInteger, PLLAlertViewStatus) {
    PLLAlertViewStatusSuccess,                  //成功状态
    PLLAlertViewStatusNormal,                   //普通状态
    PLLAlertViewStatusError,                    //出错状态
};

typedef void(^PLLAlertViewCallback)(NSInteger buttonIndex);

typedef void(^PLLAlertDissmissCallback)(void);

@interface PLLAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString*)message
               buttonTitleArr:(NSArray*)buttonTitleArr
                  atSuperView:(UIView*)atSuperView
                       status:(PLLAlertViewStatus)status
                     maskType:(PLLAlertViewMaskType)maskType
                     callback:(PLLAlertViewCallback)callback;


- (void)show;

@end
