//
//  UIView+UIView_EmpyFalseDataView.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+EmpyFalseDataView.h"
#import <objc/runtime.h>

@implementation UIView (EmpyFalseDataView)

static char emptyDataViewKey;
static char networkReloadViewKey;
static char networkReloadBtnKey;

- (void)setupEmptyDataViewWith:(UIImage *)image tipText:(NSString *)tip yOffset:(float)yOffset {
    UIView *emptyDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    emptyDataView.backgroundColor = [UIColor whiteColor];
//    emptyDataView.userInteractionEnabled = NO;
//    emptyDataView.hidden = YES;
    
    UIImage *icon;
    if (image) {
        icon = image;
    } else {
        icon = [UIImage imageNamed:kResourceSrcName(@"msg_ic_data")];
    }
    
    NSString *tipText;
    if (tip && ![tip isEqualToString:@""]) {
        tipText = tip;
    } else {
        tipText = kEmptyDataTip;
    }
    
    CGSize iconSize = CGSizeMake(kFixRatioWidthByIphone6(icon.size.width), kFixRatioHeightByIphone6(icon.size.height));
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - iconSize.width) / 2, (CGRectGetHeight(self.frame) - iconSize.height) / 2 - 44 + yOffset, icon.size.width, icon.size.height)];
    verifyImageView.image = icon;
    [emptyDataView addSubview:verifyImageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(verifyImageView.frame), CGRectGetWidth(self.frame), 20)];
    tipLabel.text = tipText;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kColorRGB(153, 153, 153, 1);
    tipLabel.font = [UIFont systemFontOfSize:15];
    [emptyDataView addSubview:tipLabel];
    
    [self addSubview:emptyDataView];
    [self setEmptyDataViewKey:emptyDataView];
}

- (void)setupNetworkReloadViewWith:(UIImage *)image tipText:(NSString *)tip yOffset:(float)yOffset {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    view.backgroundColor = [UIColor whiteColor];
//    view.hidden = YES;
    
    UIImage *icon;
    if (image) {
        icon = image;
    } else {
        icon = [UIImage imageNamed:kResourceSrcName(@"msg_network")];
    }
    
    NSString *tipText;
    if (tip && ![tip isEqualToString:@""]) {
        tipText = tip;
    } else {
        tipText = kNetworkConnectFailTip;
    }
    
    CGSize iconSize = CGSizeMake(kFixRatioWidthByIphone6(icon.size.width), kFixRatioHeightByIphone6(icon.size.height));
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - iconSize.width) / 2, (CGRectGetHeight(self.frame) - iconSize.height) / 2 - 64 + yOffset, icon.size.width, icon.size.height)];
    verifyImageView.image = icon;
    verifyImageView.userInteractionEnabled = NO;
    [view addSubview:verifyImageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(verifyImageView.frame) + 25, CGRectGetWidth(self.frame), 20)];
    tipLabel.text = tipText;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kColorRGB(153, 153, 153, 1);
    tipLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:tipLabel];
    
    CGSize btnSize = CGSizeMake(kFixRatioHeightByIphone6(112), kFixRatioHeightByIphone6(32));
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.frame = CGRectMake((CGRectGetWidth(self.frame) - 112) / 2, CGRectGetMaxY(tipLabel.frame) + 13, btnSize.width, btnSize.height);
    [reloadButton setImage:[UIImage imageNamed:kResourceSrcName(@"msg_ic_loading")] forState:UIControlStateNormal];
    [reloadButton setImage:[UIImage imageNamed:kResourceSrcName(@"msg_ic_loading_sel")] forState:UIControlStateSelected];
    [view addSubview:reloadButton];
    
    [self addSubview:view];
    [self setNetworkReloadViewKey:view];
    [self setNetworkReloadBtnKey:reloadButton];
}

- (void)setEmptyDataViewKey:(UIView *)view {
    objc_setAssociatedObject(self, &emptyDataViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNetworkReloadViewKey:(UIView *)view {
    objc_setAssociatedObject(self, &networkReloadViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNetworkReloadBtnKey:(UIButton *)view {
    objc_setAssociatedObject(self, &networkReloadBtnKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)getEmptyDataViewKey {
    return objc_getAssociatedObject(self, &emptyDataViewKey);
}

- (UIView *)getNetworkReloadViewKey {
    return objc_getAssociatedObject(self, &networkReloadViewKey);
}

- (UIButton *)getNetworkReloadBtnKey {
    return objc_getAssociatedObject(self, &networkReloadBtnKey);
}

@end
