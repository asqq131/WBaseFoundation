//
//  menuTableHeaderView.h
//  sub-EXG
//
//  Created by mac on 15/9/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ETeacher;
@interface MenuTableHeaderView : UIView

@property (nonatomic, strong) NSDictionary *dataDict;

/*
 * 教师头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

/*
 * 性别图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

/*
 * 姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/*
 * 头像上的编辑按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *editButton;

/*
 * 教龄
 */
@property (weak, nonatomic) IBOutlet UILabel *seniorityNameLabel;

/*
 * 擅长
 */
@property (weak, nonatomic) IBOutlet UILabel *specialtyNameLabel;

@end
