//
//  BrandGoodsCollectionViewCell.m
//  differennt
//
//  Created by apple on 15/12/12.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "BrandGoodsCollectionViewCell.h"

@implementation BrandGoodsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configUI:(NSDictionary *)dic {
    [self.Pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"Cover"]]] placeholderImage:[UIImage imageNamed:@"图层-1"]];
//    self.Pic.image = [UIImage imageNamed:@"图层-1"];
    self.BrandLabel.text = @"LVLVLVLV";
    self.NameLabel.text  = [NSString stringWithFormat:@"%@",dic[@"GoodsName"]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.f",[dic[@"OriginalPrice"] floatValue]];
}
@end
