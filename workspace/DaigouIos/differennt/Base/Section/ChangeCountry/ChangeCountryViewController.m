//
//  ChangeCountryViewController.m
//  differennt
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "ChangeCountryViewController.h"
#import "ChangeCountryTableViewCell.h"
#import "AppDelegate.h"
#import "LocatizedManager.h"

@interface ChangeCountryViewController () {
    NSArray *_dataArray;
}

@end

@implementation ChangeCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = @[@[@"中国",@"中国-Chinese 简体中文",@"zh-Hans"],
                   @[@"美国",@"United kingdom -English 英文",@"en"],
                   @[@"日本",@"Japan-Japanese 日语",@"ja"],
                   @[@"韩国",@"Korea-Korea 韩语",@"ko"]];
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40 * ScreenWidth / 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"ChangeCountryTableViewCell";
    ChangeCountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ChangeCountryTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.pic.image      = [UIImage imageNamed:_dataArray[indexPath.row][0]];
    cell.nameLabel.text = _dataArray[indexPath.row][1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:_dataArray[indexPath.row][2] forKey:kUserLanguage];
    [def synchronize];
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //切换语言
        [[LocatizedManager shareInstance] initUserLanguage];
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app initRootVc:NO];
        
        [SVProgressHUD dismiss];
    });
}

@end
