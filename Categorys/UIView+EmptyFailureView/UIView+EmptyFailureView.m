//
//  UIView+UIView_EmpyFalseDataView.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+EmptyFailureView.h"
#import <objc/runtime.h>
#import "WConstants.h"

@implementation UIView (EmpyFalseDataView)

static char emptyDataViewKey;
static char emptyDataViewBtnKey;
static char emptyDataViewTipKey;
static char networkReloadViewKey;
static char networkReloadBtnKey;
static char networkReloadTipKey;

#pragma mark EmptyDataView

- (void)setupEmptyDataViewWithImageString:(NSString *)imageString
                                  tipText:(NSString *)tip
                                  btnText:(NSString *)btnText
                                   margin:(UIEdgeInsets)margin
                             yImageOffset:(float)yOffset {
    
    UIView *emptyDataView = [UIView new];
    emptyDataView.backgroundColor = [UIColor clearColor];
    emptyDataView.translatesAutoresizingMaskIntoConstraints = NO;
    [self sendSubviewToBack:emptyDataView];
    [self addSubview:emptyDataView];
    
    UIImage *icon;
    if (![imageString isEqualToString:@""] && imageString) {
        icon = [UIImage imageNamed:imageString];
    } else {
        icon = [UIImage imageNamed:kResourceSrcName(@"msg_ic_data")];
    }
    
    NSString *tipText;
    if (tip && ![tip isEqualToString:@""]) {
        tipText = tip;
    } else {
        tipText = kEmptyDataTip;
    }
    
    CGSize iconSize = CGSizeMake(icon.size.width, icon.size.height);
    UIImageView *verifyImageView = [UIImageView new];
    verifyImageView.translatesAutoresizingMaskIntoConstraints = NO;
    verifyImageView.image = icon;
    [emptyDataView addSubview:verifyImageView];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tipLabel.text = tipText;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = [UIColor colorWithRed:182.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0];
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    [emptyDataView addSubview:tipLabel];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.translatesAutoresizingMaskIntoConstraints = NO;
    reloadButton.backgroundColor = [UIColor colorWithRed:65.0f/255.0f green:116.0f/255.0f blue:221.0f/255.0f alpha:1.0];
    reloadButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    reloadButton.layer.masksToBounds = YES;
    reloadButton.layer.cornerRadius = 4.0f;
    [reloadButton setTitle:btnText forState:UIControlStateNormal];
    [reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reloadButton.hidden = !btnText || [btnText isEqualToString:@""];
    [emptyDataView addSubview:reloadButton];
    
    CGFloat topDistance = yOffset;
    CGFloat btnTopDistance = 65.0f;
    CGFloat imageLeftPadding = (CGRectGetWidth(self.frame) - iconSize.width) / 2;
    CGFloat btnPadding = 30.0f;
    CGFloat btnWidth = kScreenSize.width - btnPadding * 2;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(emptyDataView, verifyImageView, tipLabel, reloadButton);
    NSDictionary *metrics = @{@"topMargin":@(kScale(margin.top)),
                              @"leftMargin":@(kScale(margin.left)),
                              @"bottomMargin":@(kScale(margin.bottom)),
                              @"rightMargin":@(kScale(margin.right)),
                              @"imageWidth":@(kScale(iconSize.width)),
                              @"imageHeight":@(kScale(iconSize.height)),
                              @"btnTopDistance":@(kScale(btnTopDistance)),
                              @"btnWidth":@(kScale(btnWidth)),
                              @"btnPadding":@(kScale(btnPadding)),
                              @"topDistance":@(kScale(topDistance)),
                              @"imageLeftPadding":@(kScale(imageLeftPadding)),
                              @"tipLeftPadding":@(kScale(imageLeftPadding - 25)),
                              @"tipWidth":@(kScale(iconSize.width + 40))};
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topMargin-[emptyDataView]-bottomMargin-|"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftMargin-[emptyDataView]-rightMargin-|"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    // verifyImageView
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:
      @"V:|-topDistance-[verifyImageView(imageHeight)]-[tipLabel]-btnTopDistance-[reloadButton(44)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-imageLeftPadding-[verifyImageView(imageWidth)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    // tipLabel
    
//    [self addConstraints:
//     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-tipLeftPadding-[tipLabel(tipWidth)]"
//                                             options:0
//                                             metrics:metrics
//                                               views:viewsDictionary]];
    
    [tipLabel addConstraint:[NSLayoutConstraint constraintWithItem:tipLabel
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:kScale(iconSize.width + 40)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tipLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0]];
    
    // button
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-btnPadding-[reloadButton(btnWidth)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [[self getEmptyDataViewKey] removeFromSuperview];
    [self setEmptyDataViewKey:emptyDataView];
    [self setEmptyDataTipKey:tipLabel];
    [self setEmptyDataBtnKey:reloadButton];
}

- (void)setEmptyViewHidden:(BOOL)hidden {
    [self getEmptyDataViewTipKey].hidden = hidden;
    [self getEmptyDataViewBtnKey].hidden = hidden;
    [self getEmptyDataViewKey].hidden = hidden;
}

- (void)showEmptyViewWithTip:(NSString *)tip btnString:(NSString *)btnString {
    [self getEmptyDataViewTipKey].text = tip;
    [[self getEmptyDataViewBtnKey] setTitle:btnString forState:UIControlStateNormal];
    [self setEmptyViewHidden:NO];
    
    [self getEmptyDataViewBtnKey].hidden = !btnString || [btnString isEqualToString:@""];
}

- (void)emptyButtonAddTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [[self getEmptyDataViewBtnKey] addTarget:target action:action forControlEvents:controlEvents];
}

#pragma mark - NetworkReloadView

- (void)setupNetworkReloadViewWithImageString:(NSString *)imageString
                                      tipText:(NSString *)tip
                                      btnText:(NSString *)btnText
                                       margin:(UIEdgeInsets)margin
                                 yImageOffset:(float)yOffset {
    
    UIView *networkReloadView = [UIView new];
    networkReloadView.backgroundColor = [UIColor clearColor];
    networkReloadView.translatesAutoresizingMaskIntoConstraints = NO;
    [self sendSubviewToBack:networkReloadView];
    [self addSubview:networkReloadView];
    
    UIImage *icon;
    if (![imageString isEqualToString:@""] && imageString) {
        icon = [UIImage imageNamed:imageString];
    } else {
        icon = [UIImage imageNamed:kResourceSrcName(@"msg_network")];
    }
    
    NSString *tipText;
    if (tip && ![tip isEqualToString:@""]) {
        tipText = tip;
    } else {
        tipText = kNetworkConnectFailTip;
    }
    
    CGSize iconSize = CGSizeMake(icon.size.width, icon.size.height);
    UIImageView *verifyImageView = [UIImageView new];
    verifyImageView.translatesAutoresizingMaskIntoConstraints = NO;
    verifyImageView.image = icon;
    [networkReloadView addSubview:verifyImageView];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tipLabel.text = tipText;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = [UIColor colorWithRed:182.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0];
    tipLabel.font = [UIFont systemFontOfSize:16.0f];
    [networkReloadView addSubview:tipLabel];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.translatesAutoresizingMaskIntoConstraints = NO;
//    reloadButton.backgroundColor = [UIColor colorWithRed:65.0f/255.0f green:116.0f/255.0f blue:221.0f/255.0f alpha:1.0];
    reloadButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    reloadButton.layer.masksToBounds = YES;
    reloadButton.layer.cornerRadius = 4.0f;
//    [reloadButton setTitle:btnText forState:UIControlStateNormal];
//    [reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reloadButton setImage:[UIImage imageNamed:kResourceSrcName(@"msg_ic_loading")] forState:UIControlStateNormal];
    [reloadButton setImage:[UIImage imageNamed:kResourceSrcName(@"msg_ic_loading_sel")] forState:UIControlStateSelected];
    [networkReloadView addSubview:reloadButton];
    
    CGFloat topDistance = yOffset;
    CGFloat btnTopDistance = 35.0f;
    CGFloat tipTopDistance = 15.0f;
    CGFloat imageLeftPadding = (CGRectGetWidth(self.frame) - iconSize.width) / 2;
    CGFloat btnPadding = 30.0f;
    CGFloat btnWidth = kScreenSize.width - btnPadding * 2;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(networkReloadView, verifyImageView, tipLabel, reloadButton);
    NSDictionary *metrics = @{@"topMargin":@(kScale(margin.top)),
                              @"leftMargin":@(kScale(margin.left)),
                              @"bottomMargin":@(kScale(margin.bottom)),
                              @"rightMargin":@(kScale(margin.right)),
                              @"imageWidth":@(kScale(iconSize.width)),
                              @"imageHeight":@(kScale(iconSize.height)),
                              @"btnTopDistance":@(kScale(btnTopDistance)),
                              @"btnWidth":@(kScale(btnWidth)),
                              @"btnPadding":@(kScale(btnPadding)),
                              @"topDistance":@(kScale(topDistance)),
                              @"imageLeftPadding":@(kScale(imageLeftPadding)),
                              @"tipLeftPadding":@(kScale(imageLeftPadding - 25)),
                              @"tipWidth":@(kScale(iconSize.width + 40)),
                              @"tipTopDistance":@(kScale(tipTopDistance))};
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topMargin-[networkReloadView]-bottomMargin-|"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftMargin-[networkReloadView]-rightMargin-|"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    // verifyImageView
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:
      @"V:|-topDistance-[verifyImageView(imageHeight)]-tipTopDistance-[tipLabel]-btnTopDistance-[reloadButton(44)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-imageLeftPadding-[verifyImageView(imageWidth)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    // tipLabel
    
    [tipLabel addConstraint:[NSLayoutConstraint constraintWithItem:tipLabel
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:kScale(iconSize.width + 40)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tipLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    
    // button
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-btnPadding-[reloadButton(btnWidth)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [[self getNetworkReloadViewKey] removeFromSuperview];
    [self setNetworkReloadViewKey:networkReloadView];
    [self setNetworkReloadBtnKey:reloadButton];
    [self setNetworkReloadTipKey:tipLabel];
}

- (void)setNetworkReloadViewHidden:(BOOL)hidden {
    [self getNetworkReloadTipKey].hidden = hidden;
    [self getNetworkReloadBtnKey].hidden = hidden;
    [self getNetworkReloadViewKey].hidden = hidden;
}

- (void)showNetworkReloadViewWithTip:(NSString *)tip btnString:(NSString *)btnString {
    [self getNetworkReloadTipKey].text = tip;
    [[self getNetworkReloadBtnKey] setTitle:btnString forState:UIControlStateNormal];
    [self setNetworkReloadViewHidden:NO];
    
//    [self getNetworkReloadBtnKey].hidden = !btnString || [btnString isEqualToString:@""];
}

- (void)networkReloadButtonAddTarget:(nullable id)target
                              action:(SEL)action
                    forControlEvents:(UIControlEvents)controlEvents {
    [[self getEmptyDataViewBtnKey] addTarget:target action:action forControlEvents:controlEvents];
}

#pragma mark - runtime set get

// EmptyDataView

- (void)setEmptyDataViewKey:(UIView *)view {
    objc_setAssociatedObject(self, &emptyDataViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setEmptyDataBtnKey:(UIButton *)btn {
    objc_setAssociatedObject(self, &emptyDataViewBtnKey, btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setEmptyDataTipKey:(UILabel *)label {
    objc_setAssociatedObject(self, &emptyDataViewTipKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// NetworkReloadView

- (void)setNetworkReloadViewKey:(UIView *)view {
    objc_setAssociatedObject(self, &networkReloadViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNetworkReloadBtnKey:(UIButton *)btn {
    objc_setAssociatedObject(self, &networkReloadBtnKey, btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNetworkReloadTipKey:(UILabel *)label {
    objc_setAssociatedObject(self, &networkReloadTipKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// EmptyDataView

- (UIView *)getEmptyDataViewKey {
    return objc_getAssociatedObject(self, &emptyDataViewKey);
}

- (UIButton *)getEmptyDataViewBtnKey {
    return objc_getAssociatedObject(self, &emptyDataViewBtnKey);
}

- (UILabel *)getEmptyDataViewTipKey {
    return objc_getAssociatedObject(self, &emptyDataViewTipKey);
}

// NetworkReloadView

- (UIView *)getNetworkReloadViewKey {
    return objc_getAssociatedObject(self, &networkReloadViewKey);
}

- (UIButton *)getNetworkReloadBtnKey {
    return objc_getAssociatedObject(self, &networkReloadBtnKey);
}

- (UILabel *)getNetworkReloadTipKey {
    return objc_getAssociatedObject(self, &networkReloadTipKey);
}

@end
