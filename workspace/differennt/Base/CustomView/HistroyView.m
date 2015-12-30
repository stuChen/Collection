//
//  HistroyView.m
//  differennt
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "HistroyView.h"
#import "HistroyTableViewCell.h"

@implementation HistroyView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


- (void)searchKey:(NSString *)key inKey:(NSString *)inKey {
    //查询缓存
//    _dataArray = [UserData GetHistroyDataForKey:inKey value:key];
    _dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:inKey];
    _currentKey = inKey;
    if (!_dataArray || _dataArray.count == 0) {
        self.hidden = YES;
    }
    else {
        self.hidden = NO;
        self.table.dataSource = self;
        self.table.delegate = self;
        if (_dataArray.count <= 2) {
            self.frame = CGRectMake(0,  64 + ScreenWidth / 8, ScreenWidth, (44 * _dataArray.count) + 39);
        }
        else {
            self.frame = CGRectMake(0,  64 + ScreenWidth / 8, ScreenWidth, 88 + 39);
        }
        [self.table reloadData];
    }
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
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"HistroyTableViewCell";
    HistroyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HistroyTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.titleLabel.text = _dataArray[indexPath.row];
    cell.ClearBtn.tag = indexPath.row;
    [cell.ClearBtn addTarget:self action:@selector(removeKey:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - 点击事件
- (void)removeKey:(UIButton *)sender {
    NSArray *array = [UserData DeleteHistroyDataForKey:_currentKey value:_dataArray[sender.tag]];
    _dataArray = array;
    if (!_dataArray || _dataArray.count == 0) {
        self.hidden = YES;
    }
    else {
        self.hidden = NO;
        [self.table reloadData];
    }
}
@end
