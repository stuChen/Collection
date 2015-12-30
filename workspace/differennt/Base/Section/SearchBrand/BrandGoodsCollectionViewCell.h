//
//  BrandGoodsCollectionViewCell.h
//  differennt
//
//  Created by apple on 15/12/12.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet LocalizedLabel *BrandLabel;
@property (weak, nonatomic) IBOutlet LocalizedLabel *NameLabel;
@property (weak, nonatomic) IBOutlet LocalizedLabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *Pic;
- (void)configUI:(NSDictionary *)dic;
@end
