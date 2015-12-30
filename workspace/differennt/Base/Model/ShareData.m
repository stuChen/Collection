//
//  ShareData.m
//  differennt
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "ShareData.h"

@implementation ShareData
+ (ShareData *)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
@end
