//
//  ExactSearchSecondViewController.m
//  differennt
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "ExactSearchSecondViewController.h"
#import "ExactData.h"
#import "NSObject+HaveVariable.h"

@interface ExactSearchSecondViewController () {
    
    __weak IBOutlet UITableView *_table;
    ExactData *_JsonData;
}

@end

@implementation ExactSearchSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (![ShareData sharedManager].AllClassifiesForMan) {
        [self getData];
    }
    else {
        _JsonData = [WHC_DataModel dataModelWithDictionary:[ShareData sharedManager].AllClassifiesForMan className:[ExactData class]];
        [_table reloadData];
    }
}
#pragma mark - get data
- (void)getData {
    [RequestManager PostUrl:URI_GetAllClassifies loding:nil dic:nil response:^(id response) {
        if (response) {
            _JsonData = [WHC_DataModel dataModelWithDictionary:response className:[ExactData class]];
            if ([_JsonData.ReturnCode integerValue] == 1) {
                //保存到单例
                [ShareData sharedManager].AllClassifiesForMan = response;
                [_table reloadData];
            }
        }
    }];
}
#pragma mark - 点击事件

- (IBAction)bak:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getCellData].count;
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
    id nowData = [self getCellData][indexPath.row];
    cell.textLabel.text = [nowData valueForKey:@"Name"];
    if (![nowData isKindOfClass:[ReturnData class]]) {
        cell.textLabel.text = [NSString stringWithFormat:@"         %@",[nowData valueForKey:@"Name"]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //判断是否展开
    id nowData = [self getCellData][indexPath.row];
    //行
    if ([nowData isKindOfClass:[ReturnData class]]) {
        ReturnData *data = nowData;
        data.isShow = !data.isShow;
        [tableView reloadData];
        if (data.isShow) {
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
    else {
        
    }
}

#pragma mark - 获取当前cell层级
- (NSArray *)getCellData {
    NSMutableArray *NowData = [[NSMutableArray alloc] init];
    for (ReturnData *data in _JsonData.ReturnData) {
        [NowData addObject:data];
        if (data.isShow) {
            for (Children *child in data.Children) {
                [NowData addObject:child];
            }
        }
    }
    return NowData;
}

@end
