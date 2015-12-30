//
//  FatherViewController.m
//  Sahara
//
//  Created by huangcan on 15/5/20.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import "FatherViewController.h"
#import <REFrostedViewController/UIViewController+REFrostedViewController.h>
#import <REFrostedViewController.h>
#define  ios7 ([[[UIDevice currentDevice] systemVersion] floatValue]>= 7.0 ?YES:NO)

@interface FatherViewController ()


@end

@implementation FatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];

    /*
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置显示的颜色
    bar.barTintColor = [UIColor whiteColor];
    //设置字体颜色
    bar.tintColor = [UIColor blackColor];
//    [self.navigationController setNavigationBarHidden:YES];
    
     UINavigationController* nav = [[UINavigationController alloc] init];
     self.nav.navigationBar.tintColor = [UIColor blackColor];
     //设置navigationbar为半透明状
     _myNav.navigationBar.translucent = YES;
     _myNav.navigationBar.barStyle = UIBarStyleBlack;
     */
}

- (void)addLeftBtn:(BOOL)add BackBtn:(BOOL)back shopBag:(UIBarButtonItem *)shop Search:(UIBarButtonItem *)search ALL:(UIBarButtonItem *)all {
    
    NSMutableArray *leftArray = [[NSMutableArray alloc]init];

    if (add) {
        [leftArray addObject:[self creatItemWithAction:@selector(showLeftManager) imageName:@"列表"]];
    }
    if (back) {
        [leftArray addObject:[self creatItemWithAction:@selector(popBack) imageName:@"返回-拷贝"]];
    }
    // Add a spacer on when running lower than iOS 7.0
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer. width = -10 ;
    [leftArray insertObject:negativeSpacer atIndex:0];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithArray:leftArray] animated:YES];
    
    
    // Add a spacer on when running lower than iOS 7.0
    UIBarButtonItem *rightNav = [[ UIBarButtonItem alloc ]
                                       initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                       target : nil action : nil ];
    rightNav. width = -10 ;
    NSMutableArray *rightArray = [[NSMutableArray alloc]init];
    [rightArray addObject:rightNav];

    if (all) {
        [rightArray addObject:all];
    }
    if (shop) {
        [rightArray addObject:shop];
    }
    if (search) {
        [rightArray addObject:search];
    }

    [ self.navigationItem setRightBarButtonItems:[NSArray arrayWithArray:rightArray] animated:YES];

}
//
- (void)addRightItems:(UIBarButtonItem *)firstObj, ... {
    
    id eachObject;
    va_list argumentList;
    if (firstObj) // The first argument isn't part of the varargs list,
    {                                   // so we'll handle it separately.
        NSMutableArray *rightArray = [[NSMutableArray alloc]init];
        [rightArray addObject: firstObj];
        va_start(argumentList, firstObj); // Start scanning for arguments after firstObject.
        while ((eachObject = va_arg(argumentList, id))) // As many times as we can get an argument of type "id"
            [rightArray addObject: eachObject]; // that isn't nil, add it to self's contents.
        va_end(argumentList);
        // Add a spacer on when running lower than iOS 7.0
        UIBarButtonItem *rightNav = [[ UIBarButtonItem alloc ]
                                     initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                     target : nil action : nil ];
        rightNav.width = -10 ;
        [rightArray insertObject:rightNav atIndex:0];
        [ self.navigationItem setRightBarButtonItems:[NSArray arrayWithArray:rightArray] animated:YES];
    }
}


/**
 *  展开侧滑栏
 */
- (void)showLeftManager {
    [self.frostedViewController presentMenuViewController];
}
/**
 *  返回
 */
- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  创建一个 UIBarButtonItem
 *
 *  @param _action action
 *
 *  @return UIBarButtonItem
 */
-( UIBarButtonItem *)creatItemWithAction:( SEL )_action imageName:(NSString *)imageName {
    UIButton * button = [ UIButton buttonWithType : UIButtonTypeCustom ];
    [button setImage :[ UIImage imageNamed : imageName] forState : UIControlStateNormal ];
    [button setFrame : CGRectMake ( 0 , 0 , 26 , 40 )];
    [button addTarget : self action :_action forControlEvents : UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[ UIBarButtonItem alloc ] initWithCustomView :button] ;
    return item;
}
/**
 *  创建一个 UIBarButtonItem
 *
 *  @param _action action
 *
 *  @return UIBarButtonItem
 */
-( UIBarButtonItem *)creatItemWithAction:( SEL )_action title:(NSString *)title {
    UIButton * button = [ UIButton buttonWithType : UIButtonTypeCustom ];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:FONT_NAME size:13];
    [button setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [button setFrame : CGRectMake ( 0 , 0 , 52 , 40 )];
    [button addTarget : self action :_action forControlEvents : UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[ UIBarButtonItem alloc ] initWithCustomView :button] ;
    return item;
}
/**
 *  创建一个 UIBarButtonItem
 *
 *  @param _action action
 *
 *  @return UIBarButtonItem
 */
-( UIBarButtonItem *)creatSearchItemWithAction {
    UIButton * button = [ UIButton buttonWithType : UIButtonTypeCustom ];
    [button setImage :[ UIImage imageNamed : @"搜索" ] forState : UIControlStateNormal ];
    [button setFrame : CGRectMake ( 0 , 0 , 26 , 40 )];
    [button addTarget : self action :@selector(GlobalSeachClick) forControlEvents : UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[ UIBarButtonItem alloc ] initWithCustomView :button] ;
    return item;
}
/**
 *  创建购物袋
 *
 *  @param _action 点击事件
 *
 *  @return 右
 */
-( UIBarButtonItem *)creatShopItemWithAction {
    UIView *RightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 26, 40)];
    UIButton *ShopBag = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 26, 40)];
    [ShopBag setImage:[UIImage imageNamed:@"购物包"] forState:UIControlStateNormal];
    [RightView addSubview:ShopBag];
    
    UILabel *shopNumber  = [[UILabel alloc]init];
    shopNumber.font      = [UIFont fontWithName:FONT_NAME size:6];//[UIFont systemFontOfSize:6];
    shopNumber.text      = @"3";
    [shopNumber sizeToFit];
    shopNumber.textColor = [UIColor blackColor];
    shopNumber.center    = CGPointMake(ShopBag.center.x, ShopBag.center.y + 5);
    [RightView addSubview:shopNumber];
    [ShopBag addTarget : self action :@selector(shopCarClick) forControlEvents : UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[ UIBarButtonItem alloc ] initWithCustomView :RightView] ;
    
    return item;
}

/**
 *  创建所有品牌
 *
 *  @param _action 点击事件
 *
 *  @return 右
 */
-( UIBarButtonItem *)creatAllItemWithAction:( SEL )_action {
    UIButton * button = [ UIButton buttonWithType : UIButtonTypeCustom ];
    [button setImage :[ UIImage imageNamed : @"ALL)" ] forState : UIControlStateNormal ];
    [button setFrame : CGRectMake ( 0 , 0 , 26 , 40 )];
    [button addTarget : self action :_action forControlEvents : UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[ UIBarButtonItem alloc ] initWithCustomView :button] ;
    return item;
}


#pragma mark - 点击
- (void)shopCarClick {
    id brand = NSClassFromString(@"ShopCarViewController");
    //判断是否包含
    UIViewController *popVc;
    for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
        UIViewController *vc = self.navigationController.viewControllers[i];
        if ([vc isKindOfClass:brand]) {
            popVc = vc;
        }
    }
    popVc ? [self.navigationController popToViewController:popVc animated:YES] : [self.navigationController pushViewController:[[brand alloc] init] animated:YES];


}
- (void)GlobalSeachClick {
    id brand = NSClassFromString(@"GlobalSearchViewController");
    //判断是否包含
    UIViewController *popVc;
    for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
        UIViewController *vc = self.navigationController.viewControllers[i];
        if ([vc isKindOfClass:brand]) {
            popVc = vc;
        }
    }
    popVc ? [self.navigationController popToViewController:popVc animated:YES] : [self.navigationController pushViewController:[[brand alloc] init] animated:YES];
    
    
}























- (void)setLeftBtn {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationController.navigationItem.leftBarButtonItem = item;
    
}
-(void)addCustomNavBarTitle:(NSString *)title
                    leftBar:(UIButton *)leftButton
                   rigthBar:(UIButton *)rigthButton whetherAddBackBar:(BOOL)backBar {
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navView.backgroundColor = MAINCOLOR;
    [self.view addSubview:navView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(navView.center.x - 80, 20, 160, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    
    if (leftButton && backBar == NO) {
        leftButton.titleLabel.font = [UIFont systemFontOfSize:18];
        leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        leftButton.titleLabel.textColor = [UIColor whiteColor];
        leftButton.frame = CGRectMake(15, 20, 40, 40);
        [navView addSubview:leftButton];
    } else if (backBar == YES) {
        [navView addSubview:[self addBackBtn]];
    } else if (backBar == YES && leftButton) {
        [navView addSubview:[self addBackBtn]];
        leftButton.frame = CGRectMake(45, 20, 40, 40);
    }
    if (rigthButton) {
        rigthButton.titleLabel.textColor = [UIColor whiteColor];
        rigthButton.titleLabel.font = [UIFont systemFontOfSize:18];
        rigthButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        rigthButton.frame = CGRectMake(ScreenWidth - 59, 20, 40, 40);
        [navView addSubview:rigthButton];
    }
}
//返回按钮
- (UIButton *)addBackBtn {
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    return backBtn;
}

- (void)popViewConDelay
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationItem.titleView      = titleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
