//
//  GiftListCollectionViewCell.m
//  differennt
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "GiftListCollectionViewCell.h"

@implementation GiftListCollectionViewCell
/*
 {
 BrandName = "D&G";
 Cover = "http://211.149.223.24:7667/UploadFile/Pic/20151216/239fc37d-89d1-410a-8e1b-c73ea64e477c.jpg";
 GoodsId = 8;
 GoodsSizeId = 17;
 Id = 7;
 Name = "\U5546\U54c1\U540d\U79f05";
 OriginalPrice = 100;
 Size = 26;
 Summary = "\U5546\U54c1\U540d\U79f05\U5546\U54c1\U540d\U79f05";
 }
 */
- (void)awakeFromNib {
    // Initialization code
}
- (void)configUi:(NSDictionary *)info {
    [self.pic sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",info[@"Cover"]]];
    self.brandLabel.text = [NSString stringWithFormat:@"%@",info[@"BrandName"]];
    self.nameLabel.text  = [NSString stringWithFormat:@"%@",info[@"Name"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@",info[@"OriginalPrice"]];
}
@end
