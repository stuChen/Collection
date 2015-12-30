//
//  ShopCarModel.h
//  differennt
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarModel : NSObject

- (instancetype)initWithDictionary: (NSDictionary *) data ;

@property (nonatomic , strong) NSArray  * Banners;
@property (nonatomic , copy  ) NSString * SizeGuide;
@property (nonatomic , strong) NSArray  * Sizes;
@property (nonatomic , copy  ) NSString * BrandName;
@property (nonatomic , strong) NSString * Id;
@property (nonatomic , copy  ) NSString * Name;
@property (nonatomic , strong) NSArray  * BrandGoods;
@property (nonatomic , copy  ) NSString * Summary;
@property (nonatomic , strong) NSString * BrandId;
@property (nonatomic , copy  ) NSString * Detail;
@property (nonatomic , strong) NSString * OriginalPrice;
@property (nonatomic , copy  ) NSString * GoodsNo;
@property (nonatomic , copy  ) NSString * Cover;


//正常选择
@property (nonatomic , assign) BOOL isChoose;
//删除选择
@property (nonatomic , assign) BOOL isDeleteChoose;
@end
