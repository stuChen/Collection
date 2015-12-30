//
//  ShareData.h
//  differennt
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareData : NSObject

+ (ShareData *)sharedManager;
/**
 *  商品全部分类
 */
@property (strong,nonatomic)NSDictionary *AllClassifiesForMan;
@property (strong,nonatomic)NSDictionary *AllClassifiesForWoman;

@end
