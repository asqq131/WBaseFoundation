//
//  MenuTableViewCell.h
//  sub-EXG
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell

/*
 * 图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;

/*
 * 标题内容
 */
@property (weak, nonatomic) IBOutlet UILabel *stringLabel;

/*
 * 版本号
 */
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

/*
 * 右箭头图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *disclosureIndicatorImageView;

/*
 * 顶部分割线
 */
@property (weak, nonatomic) IBOutlet UILabel *separatorTopLine;

/*
 * 底部分割线
 */
@property (weak, nonatomic) IBOutlet UILabel *separatorBottomLine;

/*
 * 未读消息提示标志
 */
@property (weak, nonatomic) IBOutlet UIView *msgRoundView;

@end
