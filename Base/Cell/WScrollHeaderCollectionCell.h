//
//  ZWScrollHeaderCollectionCell.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WScrollHeaderCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *itemBtn;
@property (weak, nonatomic) IBOutlet UILabel *separatorLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorHeightLayout;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
