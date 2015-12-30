//
//  FatherViewController.h
//  Sahara
//
//  Created by huangcan on 15/5/20.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FatherViewController : UIViewController
-( UIBarButtonItem *)creatSearchItemWithAction;
-( UIBarButtonItem *)creatShopItemWithAction;
-( UIBarButtonItem *)creatItemWithAction:( SEL )_action imageName:(NSString *)imageName;
/**
 *  创建所有品牌
 *
 *  @param _action 点击事件
 *
 *  @return 右
 */
-( UIBarButtonItem *)creatAllItemWithAction:( SEL )_action;
-( UIBarButtonItem *)creatItemWithAction:( SEL )_action title:(NSString *)title;


- (void)shopCarClick;


- (void)addLeftBtn:(BOOL)add BackBtn:(BOOL)back shopBag:(UIBarButtonItem *)shop Search:(UIBarButtonItem *)search ALL:(UIBarButtonItem *)all;


-(void)addCustomNavBarTitle:(NSString *)title
                    leftBar:(UIButton *)leftButton
                   rigthBar:(UIButton *)rigthButton whetherAddBackBar:(BOOL)backBar;
- (void)addRightItems:(UIBarButtonItem *)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
@end
