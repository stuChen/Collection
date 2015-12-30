//
//  SubjectViewController.m
//  differennt
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "SubjectViewController.h"
#import "JXBAdPageView.h"
#import "SubjectCollectionViewCell.h"

@interface SubjectViewController () <UICollectionViewDelegate,UICollectionViewDataSource> {
    
    __weak IBOutlet JXBAdPageView *ADScroll;
    __weak IBOutlet UICollectionView *_collectionView;
    CGFloat _collectionCellWidth;
    NSMutableArray *_goodsArray;
}

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftBtn:YES
             BackBtn:YES
             shopBag:[self creatItemWithAction:nil imageName:@"购物包"]
              Search:[self creatItemWithAction:nil imageName:@"搜索"]
                 ALL:[self creatItemWithAction:nil imageName:@"ALL)"]];
    
    
//    ADScroll.bWebImage = YES;
//    ADScroll.iDisplayTime = 2;
//    //取出图片
//    __block NSMutableArray *imageArray = [[NSMutableArray alloc]initWithCapacity:bannnerList.count];
//    [bannnerList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [imageArray addObject:[NSString stringWithFormat:@"http://app.differennt.com/%@",obj[@"imgurl"]]];
//    }];
//    [ADScroll startAdsWithBlock:imageArray block:^(NSInteger clickIndex){
//        //                NSLog(@"%d",clickIndex);
//        // 主线程执行：
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // something
//            [self BannerClickedWithIndex:clickIndex];
//        });
//    }];
    _collectionView.alwaysBounceVertical = YES;//数据不足一屏  始终可以下拉
    _collectionView.dataSource           = self;
    _collectionView.delegate             = self;
    _collectionCellWidth                 = ScreenWidth / 2;
//    [_collectionView registerNib:[UINib nibWithNibName:@"BrandGoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BrandGoodsCollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"SubjectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SubjectCollectionViewCell"];
//    [_collectionView registerClass:self.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@""];
    
    [self getData];
}

#pragma mark - get data
- (void)getData {
    [RequestManager PostUrl:URI_GetSubjectGoods loding:nil dic:@{@"subjectId":[NSNumber numberWithInteger:[_subjectId integerValue]]} response:^(id response) {
        if (response) {
            if (!_goodsArray) {
                _goodsArray = [[NSMutableArray alloc] init];
            }
            [_goodsArray addObjectsFromArray:response[@"ReturnData"][@"Goods"]];
            [_collectionView reloadData];
        }
    }];
}

#pragma mark - collection delegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _goodsArray ? _goodsArray.count : 0;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//collection header高宽
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}
//header
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"SubjectCollectionViewCell";
    SubjectCollectionViewCell * cell = (SubjectCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.pic sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",_goodsArray[indexPath.row][@"Cover"]]];
      
     //sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_goodsArray[indexPath.row][@"Cover"]]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
//    [cell.pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_goodsArray[indexPath.row][@"Cover"]]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collectionCellWidth, 1.8 * _collectionCellWidth);
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
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
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
