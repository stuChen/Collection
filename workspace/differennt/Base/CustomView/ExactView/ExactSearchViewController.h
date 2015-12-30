//
//  ExactSearchViewController.h
//  differennt
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 bodecn. All rights reserved.
//
@protocol ExactSeachViewDelegate <NSObject>

- (void)ExactSeachView:(UIView *)ExactSeachView didSelectDoneWithSort:(NSString *)sort;

@end
#import <UIKit/UIKit.h>

@interface ExactSearchViewController : UIViewController

@property (strong,nonatomic) NSArray *dataArray;
@property (assign,nonatomic) id<ExactSeachViewDelegate> delegate;
- (void)show;
@end
