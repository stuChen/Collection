//
//  ShopCarTableViewCell.h
//  differennt
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWTableViewCell.h>
#import "ShopCarModel.h"

@interface ShopCarTableViewCell : SWTableViewCell 
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *BrandLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *SizeLabel;
@property (weak, nonatomic) IBOutlet UIButton *SelectBtn;

- (void)configUiWithData:(ShopCarModel *)infoData state:(BOOL)deleteState;
@end
