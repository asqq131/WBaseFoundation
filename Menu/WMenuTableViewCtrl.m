//
//  MenuTableTableViewController.m
//  sub-EXG
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "WMenuTableViewCtrl.h"

#import <QuartzCore/QuartzCore.h>
#import "MenuTableViewCell.h"
#import "MenuTableHeaderView.h"
#import "WFrostedRootViewCtrl.h"

#define kCellHeight (kIsIphone4s ? 49.0/647.0*kScreenSize.height : 49.0)

@interface WMenuTableViewCtrl () {
    NSArray *_itemsArray;
    MenuTableHeaderView *_menuTableHeaderView;
}

@end

@implementation WMenuTableViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGUI];
}

- (void)initGUI {
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 用户信息view
    _menuTableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"MenuTableHeaderView" owner:nil options:nil] objectAtIndex:0];
    _menuTableHeaderView.dataDict = nil; // 测试赋值nil
    self.tableView.tableHeaderView = _menuTableHeaderView;
    
    _itemsArray = @[@{@"text": @"消息中心", @"image": @"ic_news"},
                    @{@"text": @"版本号", @"image": @"ic_version"},
                    @{@"text": @"给软件评分", @"image": @"ic_score"},
                    @{@"text": @"免责声明", @"image": @"ic_disclaimer"},
                    @{@"text": @"修改密码", @"image": @"ic_change_password"},
                    @{@"text": @"版权说明", @"image": @"ic_edition"}];
    
    // logout button
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(0, kScreenSize.height + 20 - kCellHeight, kScreenSize.width*0.78, kCellHeight);
    logoutBtn.backgroundColor = [UIColor clearColor];
    logoutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:kIsIphone4s ? 13 : 15];
    logoutBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kIsIphone4s ? 43 : 58, 0, 0);
    [logoutBtn setTitle:@"注销账户" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:kColorRGB(181, 181, 181, 1) forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logoutBtn];
    
    CGSize iconSize = kIsIphone4s ? CGSizeMake(17, 17) : CGSizeMake(24, 24);
    UIImageView *logoutImage = [[UIImageView alloc] initWithFrame:CGRectMake(kIsIphone4s ? 15 : 19, kCellHeight/2 - iconSize.height/2, iconSize.width, iconSize.height)];
    logoutImage.image = [UIImage imageNamed:@"ic_cancellation"];
    [logoutBtn addSubview:logoutImage];
    
    NSString *cellNibName;
    if (kIsIphone4s) {
        cellNibName = @"MenuTableViewCell480";
    } else
        cellNibName = @"MenuTableViewCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:cellNibName bundle:nil] forCellReuseIdentifier:@"MenuTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableView Delegate and DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
    
    // 右箭头图标
    cell.disclosureIndicatorImageView.hidden = (indexPath.row == 1);
    
    // 底部分割线
    cell.separatorBottomLine.hidden = !(indexPath.row == _itemsArray.count-1);
    // 版本号
    cell.versionLabel.hidden = !(indexPath.row == 1);
    
    // 消息中心小红点的显示与否
//    if (indexPath.row == 0) {
//        cell.msgRoundView.hidden = !_hasNewMessage;
//    }
    
    // 第一行、第三行cell显示顶部分割线，其余行隐藏
    if (indexPath.row == 0 || indexPath.row == 3) {
        cell.separatorTopLine.hidden = NO;
    } else
        cell.separatorTopLine.hidden = YES;
    
    cell.stringLabel.text = _itemsArray[indexPath.row][@"text"];
    cell.icon.image = [UIImage imageNamed:_itemsArray[indexPath.row][@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) return;
    
    [self.frostedViewController showHome];
    
    //创建一个消息对象
    NSNotification *notice = [NSNotification notificationWithName:kNotificationNameByMenuSelected object:indexPath userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

#pragma mark - 直接展示登录页所在的navigationController
- (void)logout {
    
}

@end
