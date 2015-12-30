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
    
    //获取分类的沙盒文件路径
    NSArray* myPaths    = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* myDocPath = [myPaths objectAtIndex:0];
    NSString* path      = [myDocPath stringByAppendingPathComponent:@"ShopCarInfo.plist"];
    
    NSArray *archData        = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (archData) {
        return archData;
    }
    return nil;
}

+ (void)addShopCar:(NSDictionary *)goodsInfo info:(NSDictionary *)info {
    
    
    //获取分类的沙盒文件路径
    NSArray* myPaths    = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* myDocPath = [myPaths objectAtIndex:0];
    NSString* path      = [myDocPath stringByAppendingPathComponent:@"ShopCarInfo.plist"];
    
    NSMutableArray *_shopCarData = [[NSMutableArray alloc] init];
    NSArray *archData            = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (archData) {
        [_shopCarData addObjectsFromArray:archData];
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:goodsInfo];
    [dict setObject:info forKey:ShopCarSizeKey];
    [_shopCarData addObject:dict];

    BOOL flag = [NSKeyedArchiver archiveRootObject:_shopCarData toFile:path];//归档一个字符串
    if (flag) {
        
    }
}

@end
