//
//  CategoryViewController.m
//  differennt
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "CategoryViewController.h"
#import "ExactSearchViewController.h"
#import "ExactData.h"
#import "BrandGoodsCollectionViewCell.h"
#import "GoodsDetailViewController.h"

@interface CategoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    //品牌详情高度
    __weak IBOutlet UIView *_topView;
    __weak IBOutlet NSLayoutConstraint *_DetailLayout;
    __weak IBOutlet UICollectionView *_collectionView;
    CGFloat _LastScrollContentOffsetY;
    CGFloat _headViewHeight;
    __weak IBOutlet NSLayoutConstraint *_bottomLineHeight;
    //精确搜索
    ExactSearchViewController *_exactSearch;
    
    //数据
    NSDictionary *_dataInfo;
    NSMutableArray *_goodsArray;
    CGFloat _CellWidth;
}

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftBtn:YES BackBtn:YES shopBag:nil Search:nil ALL:nil];
    [self addRightItems:[self creatShopItemWithAction],[self creatSearchItemWithAction],[self creatItemWithAction:@selector(exactSearch) title:@"精确搜索"], nil];
    
    _bottomLineHeight.constant           = 0.5;
    _LastScrollContentOffsetY            = 0;
    _DetailLayout.constant               = (ScreenHeight * 40) / 568;
    _CellWidth                           = ScreenWidth / 2;
    _collectionView.alwaysBounceVertical = YES;//数据不足一屏  始终可以下拉
    _collectionView.dataSource           = self;
    _collectionView.delegate             = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"BrandGoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BrandGoodsCollectionViewCell"];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    _collectionView.mj_header.automaticallyChangeAlpha = YES;
    //上拉加载
//    MJRefreshBackGifFooter *_footer = [MJRefreshBackGifFooter forwardingTargetForSelector:@selector(getData)];

    //请求数据
    [self getData];
}
#pragma mark -点击事件
/**
 *  精确搜索
 */
- (void)exactSearch {
    if (!_exactSearch) {
        _exactSearch = [[ExactSearchViewController alloc] init];
        [[UIApplication sharedApplication].windows.firstObject.rootViewController addChildViewController:_exactSearch];
        [[UIApplication sharedApplication].windows.firstObject.rootViewController.view addSubview:_exactSearch.view];
    }
    [_exactSearch show];
}
#pragma mark - 加载数据
- (void)loadData {
    //品牌
    UILabel *titleLabel  = [[UILabel alloc] init];
    titleLabel.font      = [UIFont fontWithName:FONT_NAME size:15];
    titleLabel.textColor = MAINCOLOR;
    titleLabel.text      = [NSString stringWithFormat:@"%@",_dataInfo[@"Name"]];
    [titleLabel sizeToFit];
    titleLabel.center    = CGPointMake(ScreenWidth / 2, ScreenWidth / 16);
    titleLabel.tag       = 111;
    [_topView addSubview:titleLabel];
    //图片
    CGFloat _imageHeight   = 7 * ScreenWidth / 32;
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _imageHeight, _imageHeight)];
    [headImage setCenter:CGPointMake(ScreenWidth / 2, 8 + _imageHeight / 2)];
    [headImage sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",_dataInfo[@"Cover"]]];//sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataInfo[@"Cover"]] ] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    headImage.alpha       = 0;
    headImage.contentMode = UIViewContentModeScaleAspectFit;
    headImage.tag         = 112;
    [_topView addSubview:headImage];
    //描述
    UILabel *detailLabel      = [[UILabel alloc] init];
    detailLabel.font          = [UIFont fontWithName:FONT_NAME size:15];
    detailLabel.textColor     = MAINCOLOR;
    detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
    detailLabel.numberOfLines = 0;
    detailLabel.text          = [NSString stringWithFormat:@"%@",_dataInfo[@"Description"]];
    CGSize size               = [detailLabel sizeThatFits:CGSizeMake(ScreenWidth - 16, MAXFLOAT)];
    detailLabel.frame         = CGRectMake(8, _imageHeight + 16, size.width, size.height);
    detailLabel.tag           = 113;
    detailLabel.alpha         = 0;
    [_topView addSubview:detailLabel];
    //上面view的高度
    _headViewHeight = _imageHeight + 24 + size.height + 1;
}


#pragma mark - get data
- (void)getData {
    [RequestManager PostUrl:URI_GetBrandGoods loding:nil dic:@{@"brandId":[NSNumber numberWithInteger:[_BrandId integerValue]]} response:^(id response) {
        if (response) {
            if ([response[@"ReturnCode"] integerValue] == 1) {
                
                _dataInfo = response[@"ReturnData"];
                if (!_goodsArray) {
                    _goodsArray = [[NSMutableArray alloc] initWithArray:response[@"ReturnData"][@"Goods"]];
                }
                [self loadData];
                [_collectionView reloadData];
            }
        }
    }];
}
#pragma mark - collection delegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _goodsArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"BrandGoodsCollectionViewCell";
    BrandGoodsCollectionViewCell * cell = (BrandGoodsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell configUI:_goodsArray[indexPath.row]];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_CellWidth, 1.8 * _CellWidth);
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
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
    vc.goodsId = [NSString stringWithFormat:@"%@",_goodsArray[indexPath.row][@"GoodsId"]];
    [self.navigationController pushViewController:vc animated:YES];
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
#pragma mark - scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.y < -50) {
        if (_DetailLayout.constant <= (ScreenHeight * 40) / 568) {
            _DetailLayout.constant = _headViewHeight;//(ScreenHeight * 220) / 568;
            [UIView animateWithDuration:0.25 animations:^{
                [_topView viewWithTag:111].alpha = 0;
                [_topView viewWithTag:112].alpha = 1;
                [_topView viewWithTag:113].alpha = 1;
               [self.view layoutIfNeeded];
            }];
        }
    }
    if (scrollView.contentOffset.y - _LastScrollContentOffsetY > 50) {
        if (_DetailLayout.constant > (ScreenHeight * 40) / 568) {
            _DetailLayout.constant = (ScreenHeight * 40) / 568;
            [UIView animateWithDuration:0.25 animations:^{
                [_topView viewWithTag:111].alpha = 1;
                [_topView viewWithTag:112].alpha = 0;
                [_topView viewWithTag:113].alpha = 0;
                [self.view layoutIfNeeded];
            }];
        }
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _LastScrollContentOffsetY = scrollView.contentOffset.y;
}
- (void)dealloc {
    DLog(@"不发送给你说的");
}
@end
