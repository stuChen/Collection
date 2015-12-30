//
//  GiftListCollectionViewCell.h
//  differennt
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)configUi:(NSDictionary *)info;

@end
