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
#import "MWPhotoBrowser.h"

@interface GoodsDetailViewController () <UMSocialUIDelegate,UIScrollViewDelegate,MWPhotoBrowserDelegate>{
    
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
    //图片浏览器
    NSMutableArray *_photoArray;
    //当前图片下标
    NSInteger _CurrentImageIndex;
    //视频播放按钮
    UIImageView *_playImage;
    //滚动图片数组
    NSMutableArray *_ScrollImageArray;
    
    //
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
    //
    _BannerScroll.delegate = self;
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
        [self addBannerView];
    }
    
    
    //尺寸表
    if (_goodsInfoData[@"Sizes"]) {
        _sizeArray = _goodsInfoData[@"Sizes"];
        [self addSizeView];
    }
    
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
        [self addBrandGoods];
    }
    
    
}
#pragma mark - banner加载
- (void)addBannerView {
    if (_bannerArray && _bannerArray.count > 0) {
        for (int i = 0; i < 3; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, _BannerScroll.bounds.size.height)];
            img.contentMode  = UIViewContentModeScaleAspectFit;
            img.tag          = 100 + i;
            img.userInteractionEnabled  = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerImageClick:)];
            [img addGestureRecognizer:tap];
            [_BannerScroll addSubview:img];
            if (!_ScrollImageArray) {
                _ScrollImageArray = [[NSMutableArray alloc] init];
            }
            [_ScrollImageArray addObject:img];
        }
        _BannerScroll.contentSize        = CGSizeMake(ScreenWidth * 3, _BannerScroll.bounds.size.height);
        _BannerPageControl.numberOfPages = _bannerArray.count;
        _BannerPageControl.hidden        = NO;
        //下标
        _CurrentImageIndex = 0;
        [self reloadImagesForScroll];
    }
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
        [img sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",_moreVeraseceArray[i][@"Cover"]]];//sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_moreVeraseceArray[i][@"Cover"]]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        img.contentMode             = UIViewContentModeScaleAspectFit;
        [_MoreVersaceScroll addSubview:img];
    }
    _MoreVersaceScroll.contentSize = CGSizeMake(_moreVeraseceArray.count * _imageWidth, _MoreVersaceScroll.bounds.size.height);
}
//获取视频封面，本地视频，网络视频都可以用

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL {
    
    AVURLAsset *asset                  = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen         = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time                        = CMTimeMakeWithSeconds(2.0, 600);
    NSError *error                     = nil;
    CMTime actualTime;
    CGImageRef image                   = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumbImg                  = [[UIImage alloc] initWithCGImage:image];
    return thumbImg;
}
#pragma mark - 点击事件
//banner图片点击
- (void)bannerImageClick:(UITapGestureRecognizer *)sender {
    
    if (!_photoArray) {
        _photoArray = [[NSMutableArray alloc] init];
    }
    else {
        [_photoArray removeAllObjects];
    }
    // Create browser
    for (int i = 0 ; i < _bannerArray.count; i++) {
        
        NSDictionary *info = _bannerArray[i];
        if ([info[@"BannerType"] integerValue] == 2) {
            
            NSURL *videoUrl = [NSURL URLWithString:@"http://150.138.145.84/103/6/25/letv-uts/14/ver_00_22-310109858-avc-478848-aac-32002-2708240-175937512-c0bbdb76423f2addc0ffcdd0f73b6588-1425111139731.letv?crypt=90aa7f2e127&b=519&nlh=3072&nlt=45&bf=20&p2p=1&video_type=mp4&termid=2&tss=no&geo=CN-15-187-1&platid=3&splatid=301&its=0&qos=4&fcheck=0&mltag=1&proxy=709953090,709972146,709953108&uid=1931268481.rp&keyitem=GOw_33YJAAbXYE-cnQwpfLlv_b2zAkYctFVqe5bsXQpaGNn3T1-vhw..&ntm=1450357800&nkey=897b1bf6d0b2d7e1d95ca395c7045276&nkey2=a1bc6a6adebff1d871eea367cc5468e2&mmsid=27418169&tm=1450339636&key=6f023a5b599c93fa80e3de96cee21c9d&playid=0&vtype=13&cvid=1054671859447&payff=0&p1=0&p2=04&ostype=android&hwtype=un&uuid=133962817715&errc=0&gn=1079&buss=4701&cips=115.28.209.129"];//info[@"path"]];
            MWPhoto *photo = [[MWPhoto alloc]initWithImage:[self thumbnailImageForVideo:videoUrl]];
            photo.videoURL = videoUrl;
            [_photoArray addObject:photo];
        }
        else {
            MWPhoto *photo     = [MWPhoto photoWithURL:[NSURL URLWithString:info[@"Path"]]];
            [_photoArray addObject:photo];
    }
    }
    MWPhotoBrowser *browser         = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton     = YES;
    browser.displayNavArrows        = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls      = NO;
    browser.zoomPhotosToFill        = NO;
    browser.enableGrid              = NO;
    browser.startOnGrid             = NO;
    browser.enableSwipeToDismiss    = YES;
    browser.autoPlayOnAppear        = NO;
    [browser setCurrentPhotoIndex:_CurrentImageIndex];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle    = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}
/**
 *  加入心愿单
 *
 *  @param sender 按钮
 */
- (IBAction)AddGift:(UIButton *)sender {
    sender.selected = !sender.selected;
    [UIView animateWithDuration:0.25 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }completion:^(BOOL finished) {
        sender.transform = CGAffineTransformIdentity;
    }];
    [self AddWishList];
    
}
/**
 *  分享
 *
 *  @param sender 分享
 */
- (IBAction)ShareBtnClick:(id)sender {
    
//    NSString *textToShare = @"请大家登录《iOS云端与网络通讯》服务网站。";
    UIImage *imageToShare = [UIImage imageNamed:@"placeHolder.png"];
    NSURL *urlToShare     = [NSURL URLWithString:@"http://www.bodecn.net"];
    NSArray *activityItems = @[ imageToShare, urlToShare];
    // 首先初始化activityItems参数
//    	    NSArray *activityItems = [[NSArray alloc]initWithObjects:
//                                      	                              @"移动开发技术尽在DevDiv移动技术开发社区",
//                                      	                              @"http://www.DevDiv.com",
//                                      	                              [UIImage imageNamed:@"placeHolder.png"], nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [activityViewController setCompletionHandler:^(NSString *activityType, BOOL completed){

    }];
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
/**
 *  添加心愿单
 */
- (void)AddWishList {
    NSString *deviceCode = USERID ? @"" : @"asdaasdasd";
    [RequestManager PostUrl:URI_AddWishList
                     loding:nil
                        dic:@{@"strGoodSizeIds":[NSString stringWithFormat:@"%@",_sizeArray[_chooseSizeIndex][@"GoodsSizeId"]],@"deviceCode":deviceCode} response:^(id response) {
        if (response) {
            if ([response[@"ReturnCode"] integerValue] == 1) {
                [SVProgressHUD showSuccessWithStatus:@"加入心愿单成功！"];
            }
        }
    }];
}
#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _BannerScroll) {
        
        if (scrollView.contentOffset.x > scrollView.bounds.size.width) {
            _CurrentImageIndex = [self countIndex:_CurrentImageIndex up:YES];
        }
        else if (scrollView.contentOffset.x < scrollView.bounds.size.width) {
            _CurrentImageIndex = [self countIndex:_CurrentImageIndex up:NO];
        }
        [self reloadImagesForScroll];
    }
    
    
}
//重新更新下标
- (void)reloadImagesForScroll {
    UIImageView *firstImage  = (UIImageView *)_ScrollImageArray[0];
    UIImageView *secondImage = (UIImageView *)_ScrollImageArray[1];
    UIImageView *thirdImage  = (UIImageView *)_ScrollImageArray[2];
    
    if (!_playImage) {
        _playImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"播放键"]];
        _playImage.bounds = CGRectMake(0, 0, 82 * ScreenWidth / 320, 82 * ScreenWidth / 320);
    }
    else {
        [_playImage removeFromSuperview];
    }
    
    
    NSDictionary *_dict1 = _bannerArray[[self countIndex:_CurrentImageIndex up:NO]];
    NSDictionary *_dict2 = _bannerArray[_CurrentImageIndex];
    NSDictionary *_dict3 = _bannerArray[[self countIndex:_CurrentImageIndex up:YES]];
    
    if ([_dict1[@"BannerType"] integerValue] == 2) {
        [firstImage addSubview:_playImage];
        _playImage.center = CGPointMake(ScreenWidth / 2, _BannerScroll.bounds.size.height / 2);
    }
    else if ([_dict2[@"BannerType"] integerValue] == 2) {
        [secondImage addSubview:_playImage];
        _playImage.center = CGPointMake(ScreenWidth / 2, _BannerScroll.bounds.size.height / 2);
    }
    else if ([_dict3[@"BannerType"] integerValue] == 2) {
        [thirdImage addSubview:_playImage];
        _playImage.center = CGPointMake(ScreenWidth / 2, _BannerScroll.bounds.size.height / 2);
    }
    
    [firstImage sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",_bannerArray[[self countIndex:_CurrentImageIndex up:NO]][@"Path"]]];
    //sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_bannerArray[[self countIndex:_CurrentImageIndex up:NO]][@"Path"]]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [secondImage sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",_bannerArray[_CurrentImageIndex][@"Path"]]];
    //sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_bannerArray[_CurrentImageIndex][@"Path"]]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [thirdImage sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",_bannerArray[[self countIndex:_CurrentImageIndex up:YES]][@"Path"]]];
    //sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_bannerArray[[self countIndex:_CurrentImageIndex up:YES]][@"Path"]]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [_BannerScroll scrollRectToVisible:CGRectMake(_BannerScroll.frame.size.width, 0, _BannerScroll.frame.size.width, _BannerScroll.frame.size.height) animated:NO];
    
    
    _BannerPageControl.currentPage = _CurrentImageIndex;
}
/**
 *  当前下标
 *
 *  @param up 是否是+1
 *
 *  @return 当前下标
 */
- (NSInteger)countIndex:(NSInteger)index up:(BOOL)up {
    if (up) {
        index++;
        if (index >= _bannerArray.count) {
            index = 0;
        }
    }
    else {
        index--;
        if (index < 0) {
            index = _bannerArray.count - 1;
        }
    }
    return index;
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
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photoArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photoArray.count)
        return [_photoArray objectAtIndex:index];
    return nil;
}

//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//        return [_thumbs objectAtIndex:index];
//    return nil;
//}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

//- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
//    return [[_selections objectAtIndex:index] boolValue];
//}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
//    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
//    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
//}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
