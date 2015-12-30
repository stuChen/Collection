//
//  AppDelegate.h
//  Base
//
//  Created by bodecn on 15/10/21.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController/RECommonFunctions.h>
#import <REFrostedViewController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,REFrostedViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)initRootVc:(BOOL)pushVc;
@end

