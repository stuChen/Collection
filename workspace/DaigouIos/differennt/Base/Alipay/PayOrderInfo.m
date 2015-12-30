//
//  PayOrderInfo.m
//  Base
//
//  Created by bodecn on 15/11/25.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "PayOrderInfo.h"


@implementation PayOrderInfo


+ (void)AlipayWithGenerateTradeNO:(NSString *)generateTradeNO
                      productName:(NSString *)productName
               productDescription:(NSString *)productDescription
                     productPrice:(CGFloat  )productPrice
                     callBackData:(void (^)(NSDictionary *response))callBackData {
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner    = @"2088711834104302";
    NSString *seller     = @"bosaidong@differennt.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALM4MFszx+Q0etZ7D7H5C9S283ZiRvZcDJyxPBBAdFX1TkgoYyPhZEv53nYU1UOEIlOT2BXXvanzlQxzHc1wf19myITBbEdBcrcvCZw4+pUaH/H9U5vq4FfBvI71JLvd33Y3sfPmYcQ9SdzI972OO4gkihNruss9ey8EX629GnkZAgMBAAECgYAyRgDKlKvuCAqtP7gXZJU9BlUlUEw3r3qaOd1vcaUwt69N7oZg+kj4Rw9wcEeiuN4oM8DZ37sEgZ+97kzd5EDWOf2J+W0zvgefl2zpeIBrC8YHNeDlI3Opw0SAaitoHE3zcUAUr4EQGafVEkV6djf6VTrj1plbIULv9x3fP3g9QQJBANo8f+fJdzeiqPEZfBkpIn97ZZ0HX6BpuVvUNQN11vDierSWGNkwo8RpmTdKbI3ggn7Gf5nxifcrnxHbmyS1QkMCQQDSO08rTfbfUm2dWJt7QJOhweqtuF00gZMpVFv3wcz6fqgx9ax92ZIsyjlm+Y9yLHLcDhcHhUayZZpHbwpjfKdzAkEAlFVk1qYAK0ebLu0UhYGJGj9ETNxTKhRSUdFGC0kQRICbyJzw3McLuRfRdVxXtoNwDz1aQ8eB8AetQhUTOXseQwJAZwkabCbx79H+VzeuPGIR+R2JX0sUoz8+WOs3h948ECkzVgkKWUPhGIKkT4vQeiy+votJTi5Lz/NsAcayWMAncQJAZGg7OIPOMxRIqJ+pRC1iCgO2aq2FXHsNGkgTif411y1kvQeT6iyW8v++MXAD8N8mOtzJ6ncVjsMGAEreNbwsjA==";
    /*============================================================================*/
    /*=======================需要填写回调地址=======================================*/
    /*============================================================================*/
    NSString *notifyURL  = @"http://app.differennt.com/APP/interface/Alipay/notifyurl.php";
    /*============================================================================*/
    /*=======================需要填写回调地址=======================================*/
    /*============================================================================*/
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    /*============================================================================*/
    /*============================================================================*/
    
    
    
    
    
    
    
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order             = [[Order alloc] init];
    order.partner            = partner;
    order.seller             = seller;
    order.tradeNO            = generateTradeNO;//订单ID（由商家自行制定）
    order.productName        = productName;//商品标题
    order.productDescription = productDescription;//商品描述
    order.amount             = [NSString stringWithFormat:@"%.2f",productPrice];//商品价格
    order.notifyURL          = notifyURL;//@"http://www.xxx.com"; //回调URL
    
    order.service      = @"mobile.securitypay.pay";
    order.paymentType  = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay       = @"30m";
    order.showUrl      = @"m.alipay.com";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            /**
             *  回调
             */
            callBackData(resultDic);
            
            
            switch ([[resultDic objectForKey:@"resultStatus"] integerValue]) {
                case 9000:
                {
                    //付款成功
                }
                    break;
                case 6001:
                {
                    //用户中途取消  去订单详情
    
                }
                    break;
                case 6002:
                {
                    //网络连接错误
    
                    
                }
                    break;
                case 4000:
                {
                    //订单支付失败
    
                }
                    break;
                case 8000:
                {
                    //正在处理中
    
                }
                    break;
                default:
                    break;
            }

        }];

    }
}

@end
