//
//  GoodsViewController.m
//  differennt
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "GoodsViewController.h"

@interface GoodsViewController ()

@end

@implementation GoodsViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self addLeftBtn:YES
             BackBtn:YES
             shopBag:[self creatItemWithAction:nil imageName:@"购物包"]
              Search:[self creatItemWithAction:nil imageName:@"搜索"]
                 ALL:[self creatItemWithAction:nil imageName:@"ALL)"]];
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (self.navigationController.viewControllers.count == 1) {
//        return NO;
//    }
//    else {
//        return YES;
//    }
//}

@end
