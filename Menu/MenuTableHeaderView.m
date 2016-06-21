//
//  menuTableHeaderView.m
//  sub-EXG
//
//  Created by mac on 15/9/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MenuTableHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MenuTableHeaderView

- (void)awakeFromNib {
    // 设置layer，把头像改成圆形
    _picImageView.layer.masksToBounds = YES;
    _picImageView.layer.cornerRadius = 40.0;
    _picImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _picImageView.layer.borderWidth = 1.5f;
    
    // 设置layer，把编辑按钮改成圆形
    _editButton.layer.masksToBounds = YES;
    _editButton.layer.cornerRadius = 10.0;
    _editButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _editButton.layer.borderWidth = 1.5f;
    
    _picImageView.userInteractionEnabled = YES;
    _picImageView.image = [UIImage imageNamed:kResourceSrcName(@"ic_person_default")];
    
    CGFloat imageHW = CGRectGetWidth(_picImageView.frame);
    if (kScreenSize.width < 375) {
        imageHW = CGRectGetHeight(_picImageView.frame)/647*kScreenSize.height;
        _picWidthLayout.constant = imageHW;
        _picHeightLayout.constant = imageHW;
        
        _picImageView.layer.cornerRadius = imageHW/2;
        
        CGRect rect = self.frame;
        rect.size.height -= 20;
        self.frame = rect;
    }
    
    _picImageLeftLayout.constant = kScreenSize.width*0.78/2 - imageHW/2;
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    
    // 设置教师头像
    // 给一张默认图片，先使用默认图片，当图片加载完成后再替换
//    [_picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kMainAPIDomain, teacher.pic]] placeholderImage:[UIImage imageNamed:@"img_head_portrait"]];
//    
//    // 设置教师姓名
//    _nameLabel.text = teacher.name;
//    // 设置教龄
//    _seniorityNameLabel.text = teacher.seniorityName;
//    // 设置教师专长
//    if ([teacher.specialtyName isEqualToString:@""]) {
//        _specialtyNameLabel.text = @"擅长：暂未设置";
//    } else {
//        _specialtyNameLabel.text = [NSString stringWithFormat:@"擅长：%@", teacher.specialtyName];
//    }
    
    [self updateGUIConstraints];
    
    // 设置性别图标
//    _sexImageView.image = [teacher.sex isEqualToString:@"女"] ? [UIImage imageNamed:@"msg_ic_female"] : [UIImage imageNamed:@"msg_ic_male"];
}

- (void)updateGUIConstraints {
    CGFloat maxWidth = 190;
    
    // MAXFLOAT(值很大)为最大的高度，可以认为高度不限
    CGSize nameSize = [_nameLabel.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    // MAXFLOAT(值很大)为最大的高度，可以认为高度不限
    CGSize specialtySize = [_specialtyNameLabel.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    // MAXFLOAT(值很大)为最大的高度，可以认为高度不限
    CGSize senioritySize = [_seniorityNameLabel.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    // 根据屏幕宽度设置各个控件距离左侧的距离
    _nameLeftLayout.constant = kScreenSize.width*0.78/2 - nameSize.width/2;
    _specialtyLeftLayout.constant = kScreenSize.width*0.78/2 - specialtySize.width/2;
    _seniorityLeftLaytou.constant = kScreenSize.width*0.78/2 - senioritySize.width/2;
}

@end
