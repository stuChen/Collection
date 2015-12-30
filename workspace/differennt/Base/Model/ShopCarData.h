//
//  ShopCarData.h
//  differennt
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ShopCarKey @"ShopCarDataInfo"
@interface ShopCarData : NSObject

+ (NSArray *)loadShopCarData;
+ (void)addShopCar:(NSDictionary *)goodsInfo info:(NSDictionary *)info;

@end
