//
//  ShopCarData.m
//  differennt
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "ShopCarData.h"

@implementation ShopCarData

+ (NSArray *)loadShopCarData {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:ShopCarKey]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:ShopCarKey];
    }
    return nil;
}

+ (void)addShopCar:(NSDictionary *)goodsInfo info:(NSDictionary *)info {
    
    NSMutableArray *_shopCarData = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:ShopCarKey]) {
        [_shopCarData addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:ShopCarKey]];
    }
    __block NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:goodsInfo];
    [info enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [dict setObject:obj forKey:key];
    }];
    [_shopCarData addObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:_shopCarData forKey:ShopCarKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
