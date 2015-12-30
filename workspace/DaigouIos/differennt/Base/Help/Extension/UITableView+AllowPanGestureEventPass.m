//
//  UITableView+AllowPanGestureEventPass.m
//  differennt
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "UITableView+AllowPanGestureEventPass.h"

@implementation UITableView (AllowPanGestureEventPass)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
    {
        return YES;
    }
    else
    {
        return  NO;
    }
}
@end
