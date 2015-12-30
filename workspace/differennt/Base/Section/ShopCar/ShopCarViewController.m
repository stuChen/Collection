//
//  ShopCarViewController.m
//  differennt
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarTableViewCell.h"
#import "ShopCarData.h"
#import "ShopCarModel.h"

@interface ShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate> {
    NSMutableArray *_shopCarDataArray;
    __weak IBOutlet UITableView *_table;
    UIButton *_deleteBtn;
    UIButton *_giftBtn;
    
    //编辑按钮
    UIButton *_rightBtn;
    __weak IBOutlet UIView *_bottomView;
    __weak IBOutlet NSLayoutConstraint *_bottomHeight;
    __weak IBOutlet NSLayoutConstraint *_payBtnTop;
    __weak IBOutlet NSLayoutConstraint *_priceLabelTopLayout;
}

@end

@implementation ShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftBtn:YES BackBtn:YES shopBag:nil Search:nil ALL:nil];
    [self addRightItems:[self creatItemWithAction:@selector(editClick:) title:LocatizedStirngForkey(@"Edit")], nil];
    _rightBtn = self.navigationItem.rightBarButtonItems[1].customView;
    [_rightBtn setTitle:LocatizedStirngForkey(@"Done") forState:UIControlStateSelected];
    
    _table.delegate   = self;
    _table.dataSource = self;
    
    _shopCarDataArray = [[NSMutableArray alloc] init];
    if (!USERID) {
        [self loadByModel:[ShopCarData loadShopCarData]];
    }
}
#pragma mark - 加载数据，生成model
- (void)loadByModel:(NSArray *)data {
    if (data) {
        for (NSDictionary *infoData in data) {
            ShopCarModel *model = [[ShopCarModel alloc] initWithDictionary:infoData];
            [_shopCarDataArray addObject:model];
        }
        [_table reloadData];
    }
    
}
#pragma mark - 点击事件
//编辑
- (void)editClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    //改变cell
    for (int i = 0;i < _shopCarDataArray.count;i++) {
        ShopCarModel *model        = _shopCarDataArray[i];
        ShopCarTableViewCell *cell = [_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.SelectBtn.selected = sender.selected ? model.isDeleteChoose : model.isChoose;
    }
    
    
    if (!_deleteBtn) {
        _deleteBtn       = [[UIButton alloc] init];
        _giftBtn         = [[UIButton alloc] init];
        _deleteBtn.frame = CGRectMake(-ScreenWidth / 2, 0, ScreenWidth / 2, 50);
        _giftBtn.frame   = CGRectMake(ScreenWidth, 0, ScreenWidth / 2, 50);
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
        [_giftBtn setTitle:@"加入心愿单" forState:UIControlStateNormal];
        [_giftBtn setBackgroundColor:MAINCOLOR];
        [_giftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomView addSubview:_deleteBtn];
        [_bottomView addSubview:_giftBtn];
    }
    
    if (_bottomHeight.constant > 50) {
        _bottomHeight.constant        = 50;
        _payBtnTop.constant           -= 80;
        _priceLabelTopLayout.constant -= 80;
        _deleteBtn.center             = CGPointMake(-ScreenWidth / 4, 25);
        _giftBtn.center               = CGPointMake(ScreenWidth * 5 / 4, 25);
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
            _deleteBtn.center = CGPointMake(ScreenWidth / 4, 25);
            _giftBtn.center   = CGPointMake(ScreenWidth * 3 / 4, 25);
        }completion:^(BOOL finished) {
        }];
    }
    else {
        _bottomHeight.constant        = 80;
        _payBtnTop.constant           += 80;
        _priceLabelTopLayout.constant += 80;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
            _deleteBtn.center = CGPointMake(-ScreenWidth / 4, 25);
            _giftBtn.center = CGPointMake(ScreenWidth * 5 / 4, 25);
        }completion:^(BOOL finished) {
            
        }];
    }
}
//cell的点击事件
- (void)CellSelect:(UIButton *)sender {
    sender.selected     = !sender.selected;
    ShopCarModel *model = _shopCarDataArray[sender.tag - 100];
    _rightBtn.selected ? (model.isDeleteChoose = sender.selected) : (model.isChoose = sender.selected);
}
//cell右边点击事件
- (void)cellRightBtnClick:(UIButton *)sender {
    NSInteger row   = sender.tag / 10;
    NSInteger index = sender.tag % 10;
    if (index == 0) {
        
    }
    else {
        [_shopCarDataArray removeObjectAtIndex:row];
        [_table deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shopCarDataArray ? _shopCarDataArray.count : 0;
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
    return 120 * ScreenWidth / 320;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"ShopCarTableViewCell";
    ShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShopCarTableViewCell" owner:nil options:nil].firstObject;
        cell.rightUtilityButtons = [self rightButtons];
        
    }
    cell.delegate = self;
    [cell configUiWithData:_shopCarDataArray[indexPath.row] state:_rightBtn.selected];
    cell.SelectBtn.tag = indexPath.row + 100;
    [cell.SelectBtn addTarget:self action:@selector(CellSelect:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];

    return rightUtilityButtons;
}
#pragma mark - SWTableViewDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    NSIndexPath *path = [_table indexPathForCell:cell];
    if (index == 0) {
        
    }
    else {
        [_shopCarDataArray removeObjectAtIndex:path.row];
        [_table deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:path.row inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

@end
