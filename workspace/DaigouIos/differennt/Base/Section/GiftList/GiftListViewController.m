//
//  GiftListViewController.m
//  differennt
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "GiftListViewController.h"
#import "GiftListCollectionViewCell.h"

@interface GiftListViewController () <UICollectionViewDataSource,UICollectionViewDelegate>{
    
    __weak IBOutlet UICollectionView *_collectionView;
    CGFloat _CellWidth;
    NSArray *_dataArray;
}

@end

@implementation GiftListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftBtn:YES
             BackBtn:YES
             shopBag:[self creatItemWithAction:nil imageName:@"购物包"]
              Search:[self creatItemWithAction:nil imageName:@"搜索"]
                 ALL:[self creatItemWithAction:nil imageName:@"ALL)"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _CellWidth                                = ScreenWidth / 3;
    _collectionView.delegate                  = self;
    _collectionView.dataSource                = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"GiftListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GiftListCollectionViewCell"];
    [self getData];
    
}

#pragma mark - get data
- (void)getData {
    [RequestManager PostUrl:URI_GetWishLists loding:nil dic:@{@"deviceCode":USERID ? @"" : @"asdaasdasd"} response:^(id response) {
        if (response) {
            if ([response[@"ReturnCode"] integerValue] == 1) {
                _dataArray = response[@"ReturnData"];
                [_collectionView reloadData];
            }
        }
    }];
}


#pragma mark - collection delegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray ? _dataArray.count : 0;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GiftListCollectionViewCell";
    GiftListCollectionViewCell * cell = (GiftListCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell configUi:_dataArray[indexPath.row]];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_CellWidth, _CellWidth * 2.34375);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
}
//元的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
