//
//  GoodsDetailViewController.m
//  differennt
//
//  Created by apple on 15/12/12.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "ShopCarData.h"
#import <UMSocial.h>

@interface GoodsDetailViewController () <UMSocialUIDelegate>{
    
    __weak IBOutlet UIScrollView *_mainScroll;
    __weak IBOutlet UILabel *_BrandLabel;
    __weak IBOutlet UILabel *_GoodsNameLabel;
    __weak IBOutlet UILabel *_PriceLabel;
    __weak IBOutlet UIScrollView *_BannerScroll;
    __weak IBOutlet UIPageControl *_BannerPageControl;
    __weak IBOutlet UIButton *_giftBtn;
    __weak IBOutlet UIButton *_shareBtn;
    __weak IBOutlet UIScrollView *_sizeView;
    __weak IBOutlet UIButton *_AddShopCarBtn;
    __weak IBOutlet UILabel *_GoodsDescription;
    __weak IBOutlet UILabel *_goodsNumberLabel;
    __weak IBOutlet UILabel *_sizeGuideLabel;
    __weak IBOutlet UILabel *_goodsInfoLabel;
    __weak IBOutlet UIScrollView *_MoreVersaceScroll;
    
    //商品总信息
    NSDictionary *_goodsInfoData;
    NSArray *_bannerArray;
    NSArray *_sizeArray;
    //选择尺码
    NSInteger _chooseSizeIndex;
    NSArray *_moreVeraseceArray;
}

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftBtn:YES
             BackBtn:YES
             shopBag:[self creatShopItemWithAction]
              Search:[self creatItemWithAction:nil imageName:@"搜索"]
                 ALL:nil];
    
    [self getData];
}
#pragma mark - 加载数据
- (void)loadData {
    //顶部价格
    _BrandLabel.text     = [NSString stringWithFormat:@"%@",_goodsInfoData[@"BrandName"]];
    _GoodsNameLabel.text = [NSString stringWithFormat:@"%@",_goodsInfoData[@"Name"]];
    _PriceLabel.text     = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",_goodsInfoData[@"OriginalPrice"]] floatValue]];
    //banner
    if (_goodsInfoData[@"Banners"]) {
        _bannerArray = _goodsInfoData[@"Banners"];
    }
    [self addBannerView];
    
    //尺寸表
    if (_goodsInfoData[@"Sizes"]) {
        _sizeArray = _goodsInfoData[@"Sizes"];
    }
    [self addSizeView];
    //商品信息
    _GoodsDescription.text = [NSString stringWithFormat:@"%@",_goodsInfoData[@"Summary"]];
    _goodsNumberLabel.text = [NSString stringWithFormat:@"·  %@",_goodsInfoData[@"GoodsNo"]];
    _sizeGuideLabel.text   = [NSString stringWithFormat:@"·  %@",_goodsInfoData[@"SizeGuide"]];
    if ([_goodsInfoData[@"Extras"] isKindOfClass:[NSArray class]]) {
        NSString *goodsInfoMessage = @"";
        for (NSString *str in _goodsInfoData[@"Extras"]) {
            goodsInfoMessage = [NSString stringWithFormat:@"·  %@\n",str];
        }
        _goodsInfoLabel.text = [NSString stringWithFormat:@"%@",goodsInfoMessage];
    }
    //推荐商品
    if (_goodsInfoData[@"BrandGoods"]) {
        _moreVeraseceArray = _goodsInfoData[@"BrandGoods"];
    }
    [self addBrandGoods];
    
}
#pragma mark - banner加载
- (void)addBannerView {
    for (int i = 0; i < _bannerArray.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, _BannerScroll.bounds.size.height)];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_bannerArray[i][@"Path"]]] placeholderImage:[UIImage imageNamed:@""]];
        img.contentMode  = UIViewContentModeScaleAspectFit;
        img.tag          = 100 + i;
        [_BannerScroll addSubview:img];
    }
    _BannerPageControl.numberOfPages = _bannerArray.count;
}
#pragma mark - 尺寸加载
- (void)addSizeView {
    for (int i = 0; i < _sizeArray.count; i++) {
        UIButton *button       = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth * i / 5, 0, ScreenWidth / 5, _sizeView.bounds.size.height - 2)];
        [button setTitle:[NSString stringWithFormat:@"%@",_sizeArray[i][@"Size"]] forState:UIControlStateNormal];
        [button setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:FONT_NAME size:button.titleLabel.font.pointSize];
        button.tag             = i;
        [button addTarget:self action:@selector(sizeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sizeView addSubview:button];
    }
    UIView *_bottomView         = [[UIView alloc] initWithFrame:CGRectMake(0, _sizeView.bounds.size.height - 2, ScreenWidth / 5, 2)];
    _bottomView.backgroundColor = MAINCOLOR;
    _bottomView.tag             = 250;
    [_sizeView addSubview:_bottomView];
    _sizeView.contentSize       = CGSizeMake(ScreenWidth * _sizeArray.count / 5, _sizeView.bounds.size.height);
    //尺码选择默认置为 0
    _chooseSizeIndex = 0;
}
//点击选择尺寸按钮
- (void)sizeButtonClick:(UIButton *)sizeBtn {
    UIView *_bottomView = [_sizeView viewWithTag:250];
    [UIView animateWithDuration:0.25 animations:^{
        _bottomView.frame = CGRectMake(sizeBtn.tag * ScreenWidth / 5, _sizeView.bounds.size.height - 2, ScreenWidth / 5, 2);
    }];
    //尺码选择
    _chooseSizeIndex = sizeBtn.tag;
}
#pragma mark - 推荐商品加载
- (void)addBrandGoods {
    CGFloat _imageWidth = _MoreVersaceScroll.bounds.size.height * 18 / 34;
    for (int i = 0; i < _moreVeraseceArray.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(_imageWidth * i, 0, _imageWidth, _MoreVersaceScroll.bounds.size.height)];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_moreVeraseceArray[i][@"Cover"]]] placeholderImage:[UIImage imageNamed:@""]];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [_MoreVersaceScroll addSubview:img];
    }
    _MoreVersaceScroll.contentSize = CGSizeMake(_moreVeraseceArray.count * _imageWidth, _MoreVersaceScroll.bounds.size.height);
}
#pragma mark - 点击事件
/**
 *  分享
 *
 *  @param sender 分享
 */
- (IBAction)ShareBtnClick:(id)sender {
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"sad"] applicationActivities:nil];

    // Exclude all activities except AirDrop.
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter,
                                    UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage,
                                    UIActivityTypeMail,
                                    UIActivityTypePrint,
                                    UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact,
                                    UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList,
                                    UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo,
                                    UIActivityTypePostToTencentWeibo];
    activityViewController.excludedActivityTypes = excludedActivities;

    [self presentViewController:activityViewController animated:YES completion:nil];
    /*
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"566a285fe0f55a041f000fa6"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToFacebook,UMShareToTwitter,UMShareToInstagram,nil]
                                       delegate:self];
    */
}

/**
 *  加入购物车
 *
 *  @param sender 购物车按钮
 */
- (IBAction)addGoodsToShopCar:(UIButton *)sender {
    if (!USERID) {
        //添加到购物车本地数据
        [ShopCarData addShopCar:_goodsInfoData info:_sizeArray[_chooseSizeIndex]];
    }
    
    CGPoint point     = [self.view convertPoint:sender.center fromView:_mainScroll];
    CGPoint lastPoint = CGPointMake(ScreenWidth - 16, 44);
    [self goodsLayerAnimation:point lastPoint:lastPoint];
}
/**
 *  购物动画
 *
 *  @param rect 按钮坐标
 */
- (void)goodsLayerAnimation:(CGPoint)center lastPoint:(CGPoint)lastPoint{

    NSInteger _currentIndex       = _BannerScroll.contentOffset.x / ScreenWidth;
    
    if ([_BannerScroll viewWithTag:100 + _currentIndex]) {
        UIImageView *imageViewForScroll = (UIImageView *)[_BannerScroll viewWithTag:100 + _currentIndex];
        UIImageView *imageView          = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 5, ScreenWidth / 5)];
        imageView.image                 = imageViewForScroll.image;
        imageView.layer.cornerRadius    = ScreenWidth / 10;
        imageView.backgroundColor       = [UIColor blackColor];
        imageView.layer.masksToBounds   = YES;
        imageView.center                = center;
        [[UIApplication sharedApplication].keyWindow addSubview:imageView];
        
        [UIView animateWithDuration:.75 animations:^{
            imageView.center            = lastPoint;
            CGAffineTransform roteForm  = CGAffineTransformMakeRotation(M_PI_2);
            CGAffineTransform scaleForm = CGAffineTransformScale(roteForm, 0.1, 0.1);
            imageView.transform         = scaleForm;
            
            
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            [self shopCarAnimation];
        }];
    }
}

/**
 *  购物车动画
 */
- (void)shopCarAnimation {
    UIBarButtonItem *item       = self.navigationItem.rightBarButtonItems[1];
    CABasicAnimation *animation = [[CABasicAnimation alloc]init];
    animation.keyPath           = @"transform.translation.y";
    animation.duration          = 0.25;
    animation.fromValue         = @-5;
    animation.toValue           = @5;
    animation.autoreverses      = YES;
    [item.customView.layer addAnimation:animation forKey:nil];
}

#pragma mark - get data
- (void)getData {
    [RequestManager PostUrl:URI_GetGoodsDetail loding:nil dic:@{@"goodsId":[NSNumber numberWithInteger:[_goodsId integerValue]]} response:^(id response) {
        if (response) {
            if ([response[@"ReturnCode"] integerValue] == 1) {
                _goodsInfoData = response[@"ReturnData"];
                [self loadData];
            }
        }
    }];
}
#pragma mark - 分享代理
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end
