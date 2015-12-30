//
//  MenuViewController.m
//  differennt
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import <REFrostedViewController/UIViewController+REFrostedViewController.h>
#import <REFrostedViewController.h>
#import "FatherNavigationController.h"

@interface MenuViewController () {
    NSArray *titleArray;
    NSIndexPath *selectIndexPath;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    titleArray = @[@[LocatizedStirngForkey(@"Home Page"),@"IndexViewController"],
                   @[LocatizedStirngForkey(@"New Goods"),@""],
                   @[LocatizedStirngForkey(@"Brand A-Z"),@"SearchBrandViewController"],
                   @[LocatizedStirngForkey(@"All brands"),@""],
                   @[LocatizedStirngForkey(@"AllCategorys"),@""],
                   @[LocatizedStirngForkey(@"Aspiration List"),@"GiftListViewController"],
                   @[LocatizedStirngForkey(@"Shopping Bag"),@""],
                   @[LocatizedStirngForkey(@"Order Form"),@""],
                   @[LocatizedStirngForkey(@"Country Change"),@""],
                   @[LocatizedStirngForkey(@"account"),@"AccountViewController"],
                   @[LocatizedStirngForkey(@"PhoneMK"),@""],
                   @[LocatizedStirngForkey(@"Man Zone"),@""]];
}
#pragma mark - 点击事件
- (IBAction)LeftBtn:(id)sender {
    [self.frostedViewController hideMenuViewController];
}
//切换语言
- (IBAction)ChangeCountry:(id)sender {
//    id brand = NSClassFromString(@"ChangeCountryViewController");
//    FatherNavigationController *nav = (FatherNavigationController *)self.frostedViewController.contentViewController;
//    //判断是否包含
//    UIViewController *popVc;
//    for (int i = 0; i < nav.viewControllers.count; i++) {
//        UIViewController *vc = nav.viewControllers[i];
//        if ([vc isKindOfClass:brand]) {
//            popVc = vc;
//        }
//    }
//    [self.frostedViewController hideMenuViewControllerWithCompletionHandler:^{
//        popVc ? [nav popToViewController:popVc animated:YES] : [nav pushViewController:[[brand alloc] init] animated:YES];
//    }];
    [self pushInToVCwithName:@"ChangeCountryViewController"];
}
//进入到某个页面
- (void)pushInToVCwithName:(NSString *)className {
    id brand = NSClassFromString(className);
    FatherNavigationController *nav = (FatherNavigationController *)self.frostedViewController.contentViewController;
    //判断是否包含
    UIViewController *popVc;
    for (int i = 0; i < nav.viewControllers.count; i++) {
        UIViewController *vc = nav.viewControllers[i];
        if ([vc isKindOfClass:brand]) {
            popVc = vc;
        }
    }
    [self.frostedViewController hideMenuViewControllerWithCompletionHandler:^{
        popVc ? [nav popToViewController:popVc animated:YES] : [nav pushViewController:[[brand alloc] init] animated:YES];
    }];

}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
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
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"left";
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MenuTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.TitleLabel.text = titleArray[indexPath.row][0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectIndexPath) {
        MenuTableViewCell *cell1 = [tableView cellForRowAtIndexPath:selectIndexPath];
        cell1.SelectImage.hidden = YES;
    }
    MenuTableViewCell *cell2 = [tableView cellForRowAtIndexPath:indexPath];
    cell2.SelectImage.hidden = NO;
    selectIndexPath          = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        id brand = NSClassFromString(@"SearchBrandViewController");
        FatherNavigationController *nav = (FatherNavigationController *)self.frostedViewController.contentViewController;
        //判断是否包含
        UIViewController *popVc;
        for (int i = 0; i < nav.viewControllers.count; i++) {
            UIViewController *vc = nav.viewControllers[i];
            if ([vc isKindOfClass:brand]) {
                popVc = vc;
            }
        }
        [self.frostedViewController hideMenuViewControllerWithCompletionHandler:^{
            popVc ? [nav popToViewController:popVc animated:YES] : [nav pushViewController:[[brand alloc] init] animated:YES];
        }];
        
    }
    if (indexPath.row == 5) {
        [self pushInToVCwithName:@"GiftListViewController"];
    }
    if (indexPath.row == 9) {
        [self pushInToVCwithName:@"AccountViewController"];
    }
    if (indexPath.row == 10) {
//        [self pushInToVCwithName:@"LoginViewController"];
        id brand = NSClassFromString(@"LoginViewController");
        UIViewController *vc = [[brand alloc]init];
        FatherNavigationController *nav = [[FatherNavigationController alloc] initWithRootViewController:vc];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)dealloc {
    DLog(@"asd");
}

@end
