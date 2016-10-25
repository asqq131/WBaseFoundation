//
//  ZWBaseTableViewCtrl.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WBaseTableViewCtrl.h"

@interface WBaseTableViewCtrl () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation WBaseTableViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

//    CGFloat tableVewHeight = kScreenSize.height + 20 - 64;
//    if (self.navigationController.viewControllers.firstObject.class == self.class) {
//        tableVewHeight = kScreenSize.height - 44;
//    }
//    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, tableVewHeight)];
//    tableView.tableFooterView = [[UIView alloc] init];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view addSubview:_tableView = tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

@end
