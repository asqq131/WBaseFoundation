//
//  ZWScrollHeaderCollectionCell.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WScrollHeaderCollectionCell.h"
#import "WConstants.h"

@implementation WScrollHeaderCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _itemBtn.userInteractionEnabled = NO;
    _itemBtn.backgroundColor = [UIColor whiteColor];
    _itemBtn.titleLabel.font = [UIFont systemFontOfSize: kIsIphone4s ? 14 : 15];
    [_itemBtn setTitleColor:kColorRGB(51, 51, 51, 1) forState:UIControlStateNormal];
    [_itemBtn setTitleColor:kColorRGB(54, 201, 251, 1) forState:UIControlStateSelected];
    [_itemBtn setTitle:[NSString stringWithFormat:@"btn"] forState:UIControlStateNormal];
    
    _separatorHeightLayout.constant = 0.5;
}

@end
