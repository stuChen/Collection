//
//  IndexViewController.m
//  differennt
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexTableViewCell.h"
#import "SearchBrandViewController.h"
#import "GoodsViewController.h"
#import "AllCategorysViewController.h"
#import "CategoryViewController.h"
#import "LoginViewController.h"
#import "SubjectViewController.h"

@interface IndexViewController ()<UIGestureRecognizerDelegate> {
    __weak IBOutlet UIScrollView *_brandsScroll;
    NSArray *_brandsArray;
    NSArray *_SubjectsArray;
    __weak IBOutlet UITableView *_table;
}

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self status];
    [self loadData];
}

- (void)status {
    self.navigationItem.title = LocatizedStirngForkey(@"index");

    
    [self addLeftBtn:YES
             BackBtn:NO
             shopBag:[self creatShopItemWithAction]
              Search:[self creatSearchItemWithAction]
                 ALL:nil];
    
}
#pragma mark - 点击事件
/**
 *  品牌搜索
 */
- (IBAction)SearchBrand:(id)sender {
    SearchBrandViewController *vc = [[SearchBrandViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  全部品牌
 */
- (IBAction)Allcategorys:(id)sender {
    AllCategorysViewController *vc = [[AllCategorysViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 数据请求
- (void)loadData {
    [RequestManager PostUrl:URI_GetIndexData loding:nil dic:nil response:^(id response) {
        if (response) {
            if ([response[@"ReturnCode"] integerValue] == 1) {
                _brandsArray = response[@"ReturnData"][@"Brands"];
                [self loadBrandsWithData];
                _SubjectsArray = response[@"ReturnData"][@"Subjects"];
                [_table reloadData];
                
            }
        }
    }];
}
//加载品牌
- (void)loadBrandsWithData {
    CGFloat _brandsWidth = _brandsScroll.bounds.size.height * 128 / 80;
    for (int i = 0; i < _brandsArray.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(_brandsWidth * i, 0, _brandsWidth, _brandsScroll.bounds.size.height)];
        img.contentMode  = UIViewContentModeScaleAspectFit;
        img.tag          = 100 + i;
        [img sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",_brandsArray[i][@"Cover"]]];
         //sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_brandsArray[i][@"Cover"]]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        [_brandsScroll addSubview:img];
    }
    _brandsScroll.contentSize = CGSizeMake(_brandsScroll.bounds.size.height * _brandsArray.count, _brandsScroll.bounds.size.height);
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _SubjectsArray ? _SubjectsArray.count : 0;
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
    return 180 * ScreenWidth / 320;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"IndexTableViewCell";
    IndexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IndexTableViewCell" owner:nil options:nil].firstObject;
    }
    [cell configUi:_SubjectsArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SubjectViewController *vc = [[SubjectViewController alloc] init];
    vc.subjectId              = [NSString stringWithFormat:@"%@",_SubjectsArray[indexPath.row][@"Id"]];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1);
    [UIView animateWithDuration:.7 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
}
@end
