//
//  CustomPushAnimation.m
//  differennt
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "CustomPushAnimation.h"

@implementation CustomPushAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext

{
    
    return 1.3;
    
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    
    //通过键值UITransitionContextToViewControllerKey获取需要呈现的视图控制器toVC
    UIViewController* toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
//    toViewController.view.frame = CGRectMake(_isPresent ? (2 * ScreenWidth) : 0, 0, ScreenWidth, ScreenHeight);
    if (_isPresent) {
        toViewController.view.frame   = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
        fromViewController.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        UIView *containerView         = [transitionContext containerView];
        //添加视图
        [containerView addSubview:toViewController.view];
        
    }
    else {
        toViewController.view.frame   = CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
        fromViewController.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    //切换在containerView中完成，需要将toVC.view加到containerView中

    
    /*
    //开始动画，这里使用了UIKit提供的弹簧效果动画，usingSpringWithDamping越接近1弹性效果越不明显，此API在IOS7之后才能使用
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         toViewController.view.frame = [UIScreen mainScreen].bounds;
                     } completion:^(BOOL finished) {
                         //添加视图
                         [containerView addSubview:toViewController.view];
                         //通知系统动画切换完成
                         [transitionContext completeTransition:YES];
                     }];
    */
    [UIView animateWithDuration:0.25 animations:^{
//        toViewController.view.frame = [UIScreen mainScreen].bounds;
//        toViewController.view.frame = CGRectMake(_isPresent ? 0 : (2 * ScreenWidth), 0, ScreenWidth, ScreenHeight);
        if (_isPresent) {
            toViewController.view.frame   = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            fromViewController.view.frame = CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
        }
        else {
            fromViewController.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
            toViewController.view.frame   = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        }
    }completion:^(BOOL finished) {
        if (_isPresent) {
            
            
        }
        else {
            [fromViewController.view removeFromSuperview];
            
        }
        // 切记不要忘记了噢
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
}

@end
