//
//  PayOrderInfo.h
//  Base
//
//  Created by bodecn on 15/11/25.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


@interface PayOrderInfo : NSObject
/**
 *  支付宝调用
 *
 *  @param generateTradeNO        商品订单流水号（由商家自行制定）
 *  @param productName            商品订单标题
 *  @param productDescription     商品订单描述
 *  @param productPrice           商品订单价格
 */
+ (void)AlipayWithGenerateTradeNO:(NSString *)generateTradeNO
                      productName:(NSString *)productName
               productDescription:(NSString *)productDescription
                     productPrice:(CGFloat  )productPrice
                     callBackData:(void (^)(NSDictionary *response))callBackData;
@end
