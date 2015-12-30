//
//  ShopCarTableViewCell.m
//  differennt
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "ShopCarTableViewCell.h"

@implementation ShopCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUiWithData:(ShopCarModel *)infoData state:(BOOL)deleteState {
    
    [self.goodsImage sd_setImageWithActivityAndURLString:[NSString stringWithFormat:@"%@",infoData.Cover]];
     //sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",infoData.Cover]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.BrandLabel.text     = infoData.BrandName;
    self.goodsNameLabel.text = infoData.Name;
    self.PriceLabel.text     = [NSString stringWithFormat:@"%.2f",[infoData.OriginalPrice floatValue]];
    self.SizeLabel.text      = @"N/a";
    self.SelectBtn.selected  = deleteState ? infoData.isDeleteChoose : infoData.isChoose;
}

@end
