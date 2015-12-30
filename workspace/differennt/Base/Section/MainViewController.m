//
//  MainViewController.m
//  differennt
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self status];
}
- (void)status {
    self.title = LocatizedStirngForkey(@"不  同");
    
}

- (IBAction)test:(UIButton *)sender {
    
    switch (sender.tag - 10) {
        case 0:
            [[LocatizedManager shareInstance] setUserlanguage:@"zh-Hans"];
            break;
        case 1:
            [[LocatizedManager shareInstance] setUserlanguage:@"en"];
            break;
        case 2:
            [[LocatizedManager shareInstance] setUserlanguage:@"ja"];
            break;
        case 3:
            [[LocatizedManager shareInstance] setUserlanguage:@"ko"];
            break;
        default:
            break;
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"sdasdasds" object:nil];
}

@end
