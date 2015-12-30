//
//  Conf.h
//  zhiquan
//
//  Created by huangcan on 15/6/12.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#ifndef zhiquan_Conf_h
#define zhiquan_Conf_h

#pragma mark - 常用  ------------ ------------ ------------ ------------ ------------ ------------
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define ENCODEING   NSUTF8StringEncoding  //系统环境使用的编码

#define  PHONEBOUNDS [UIScreen mainScreen].bounds;

#pragma mark - UserDefaults  ------------ ------------ ------------ ------------ ------------

//用户ID
#define USERID          [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"]
//用户名字
#define NICKNAME        [DataDefaults getStringForKey:@"NickName"]
//用户头像
#define HEADPIC         [DataDefaults getStringForKey:@"HeadPic"]

#pragma mark - 接口地址 ------------ ------------ ------------ ------------ ------------ ------------

//#define HOMEURL @"http://211.149.223.24:4467/App/"//测试
#define HOMEURL  @"http://211.149.223.24:7667/Api/"  //不同
#define UPPiCURL @"http://120.25.160.153/"
#define WXMEDIA  @"http://goldvoyager.com/APP/"

#define URI_HOME(url) [HOMEURL stringByAppendingString:url]
#define URI_LOGIN                                   URI_HOME(@"Account/Login")
#define URI_GetIndexData                            URI_HOME(@"Home/GetIndexData")
#define URI_GetBrandsGroup                          URI_HOME(@"Brand/GetBrandsGroup")
#define URI_GetBrandGoods                           URI_HOME(@"Brand/GetBrandGoods")
#define URI_GetAllClassifies                        URI_HOME(@"GoodsAttr/GetAllClassifies")
#define URI_GetGoodsDetail                          URI_HOME(@"Goods/GetGoodsDetail")
#define URI_GetSubjectGoods                         URI_HOME(@"Subject/GetSubjectGoods")
#define URI_AddWishList                             URI_HOME(@"GoodsStore/AddWishList")
#define URI_GetWishLists                            URI_HOME(@"GoodsStore/GetWishLists")
//账户相关
#define URI_GetSmsCode                              URI_HOME(@"Account/GetSmsCode")
#define URI_ValidateRegister                        URI_HOME(@"Account/ValidateRegister")

#define URI_WXMEDIA(url) [WXMEDIA stringByAppendingString:url]

#define URI_GETSNAPSHOOT                            URI_WXMEDIA(@"Circle/GetSnapshoot")
#define URI_GETTRADEDETAILHTML                      URI_WXMEDIA(@"Trade/GetTradeDetailHtml")
#define URI_GETPOSTDETAILHTML                       URI_WXMEDIA(@"Post/GetPostDetailHtml")


#define URI_UPPIC(url) [UPPiCURL stringByAppendingString:url]
#define URI_UPLOADPIC                               URI_UPPIC(@"Upload/UploadPic")

#pragma mark -  通知 ------------ ------------ ------------ ------------ ------------ ------------

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define KNOTIFICATION_PUSHMESSAGE @"pushMessage"
#endif
