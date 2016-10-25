//
//  MenuTableViewCell.m
//  sub-EXG
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MenuTableViewCell.h"

@interface MenuTableViewCell ()

/*
 * 版本号距离右侧layout
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutRightByVersion;

/*
 * 顶部分割线宽度layout
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineWLayout;

/*
 * 顶部分割线高度layout
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineHLayout;

/*
 * 底部分割线宽度layout
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineWLayout;

/*
 * 底部分割线高度layout
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHLayout;

@end

@implementation MenuTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    
    _disclosureIndicatorImageView.image = [UIImage imageNamed:kResourceSrcName(@"ic_into")];
    _stringLabel.font = [UIFont systemFontOfSize:kIsIphone4s ? 13 : 15];
    _stringLabel.textColor = kColorRGB(181, 181, 188, 1);
    _versionLabel.font = _stringLabel.font;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 顶部和底部分割线宽度layout限制
    _topLineWLayout.constant = kScreenSize.width*0.78-19;
    _bottomLineWLayout.constant = _topLineWLayout.constant;
    
    _layoutRightByVersion.constant = kScreenSize.width*0.22/2 + CGRectGetWidth(_versionLabel.frame) + 5;
    
    _msgRoundView.layer.masksToBounds = YES;
    _msgRoundView.layer.cornerRadius = 4.0;
    
    _bottomLineHLayout.constant = 0.5;
    _topLineHLayout.constant = _bottomLineHLayout.constant;
    
    // 获取当前工程版本号，并设置
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    _versionLabel.text = [NSString stringWithFormat:@"V%@", currentVersion];
    
    _msgRoundView.hidden = YES;
}

@end
