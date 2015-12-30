//
//  GlobalSearchViewController.m
//  differennt
//
//  Created by apple on 15/12/12.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "GlobalSearchViewController.h"
#import "HistroyTableViewCell.h"

#define GLOBAL_HISTORY @"GlobalSearchData"

@interface GlobalSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    
    __weak IBOutlet LocalizedTextfield *SearchText;
    NSArray *_dataArray;
    __weak IBOutlet UITableView *table;
}

@end

@implementation GlobalSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftBtn:YES
             BackBtn:YES
             shopBag:[self creatShopItemWithAction]
              Search:nil
                 ALL:nil];
    SearchText.delegate = self;
    //获取数据内容
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChange)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    [self loadHistoryData];
}

- (void)loadHistoryData {
    _dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:GLOBAL_HISTORY];
    [table reloadData];
}

//监听输入内容
- (void)textChange {
    
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (SearchText.text.length > 0) {
        [UserData AddHistroyDataForKey:GLOBAL_HISTORY value:SearchText.text];
    }
}
#pragma mark - 点击事件
- (void)removeKey:(UIButton *)sender {
    NSArray *array = [UserData DeleteHistroyDataForKey:GLOBAL_HISTORY value:_dataArray[sender.tag]];
    _dataArray = array;
    [table deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];

}
#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray ? _dataArray.count : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return LocatizedStirngForkey(@"搜索历史");
}
//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40 * ScreenWidth / 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"HistroyTableViewCell";
    HistroyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HistroyTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.backgroundColor             = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.titleLabel.text             = _dataArray[indexPath.row];
    cell.ClearBtn.tag                = indexPath.row;
    [cell.ClearBtn addTarget:self action:@selector(removeKey:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
