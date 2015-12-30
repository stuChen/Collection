//
//  ExactSearchViewController.m
//  differennt
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "ExactSearchViewController.h"
#import "IndexViewController.h"
#import "CustomPushAnimation.h"
#import "ExactSearchSecondViewController.h"

@interface ExactSearchViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ExactSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = @[@"排序",@"分类",@"品牌",@"颜色",@"尺码",@"大图模式"];
}
- (void)show {
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.view.center = CGPointMake(ScreenWidth * 1.5, ScreenHeight / 2);
    [UIView animateWithDuration:0.25 animations:^{
        self.view.center = CGPointMake(ScreenWidth * 0.5, ScreenHeight / 2);
    }];
}
#pragma mark - 点击事件

- (IBAction)ClickDone:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(ExactSeachView:didSelectDoneWithSort:)]) {
        [_delegate ExactSeachView:self.view didSelectDoneWithSort:@""];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.view.center = CGPointMake(ScreenWidth * 1.5, ScreenHeight / 2);
    }];
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
    return ScreenWidth / 6.4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"exactSearch";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellDeque];
        cell.textLabel.textColor         = [UIColor whiteColor];
        cell.detailTextLabel.textColor   = [UIColor lightTextColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor             = [UIColor clearColor];
        cell.textLabel.font              = [UIFont fontWithName:FONT_NAME size:15];
    }
    cell.accessoryType        = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text       = _dataArray[indexPath.row];
    cell.detailTextLabel.text = @"2222";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ExactSearchSecondViewController *vc = [[ExactSearchSecondViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;

//    [self presentModalViewController:vc animated:NO];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
#pragma mark - 翻转动画

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    CustomPushAnimation *animation = [CustomPushAnimation new];
    animation.isPresent = YES;
    return animation;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    CustomPushAnimation *animation = [CustomPushAnimation new];
    animation.isPresent = NO;
    return animation;
}
- (void)dealloc {
    DLog(@"精确搜索页面已销毁");
}
@end
