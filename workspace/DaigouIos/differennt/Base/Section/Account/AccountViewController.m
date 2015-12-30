//
//  AccountViewController.m
//  differennt
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController () {
    
    __weak IBOutlet UIView *headerView;
    __weak IBOutlet UILabel *Namelabel;
    __weak IBOutlet UILabel *IdLabel;
    __weak IBOutlet UITableView *table;
    NSArray *_titleArray;
}

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
//    // 触发cell的布局过程，会基于布局约束计算所有视图的frame。
//    [headerView setNeedsLayout];
//    [headerView layoutIfNeeded];
//    // 得到cell的contentView需要的真实高度
//    CGFloat height        = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    _titleArray = @[@[@"账户设置",@"收货地址"],@[@"心愿单",@"订单",@"退货单"],@[@"代金券",@"邀请码"]];
    
    
    headerView.frame      = CGRectMake(0, 0, ScreenWidth, 142 * ScreenWidth / 320);
    table.tableHeaderView = nil;
    table.tableHeaderView = headerView;
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44 * ScreenWidth / 320;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"account";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDeque];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:FONT_NAME size:15];
    cell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
