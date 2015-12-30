//
//  NSObject+HaveVariable.m
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "NSObject+HaveVariable.h"
#import <objc/runtime.h>

@implementation NSObject (HaveVariable)
+ (BOOL) getVariableWithClass:(Class) myClass varName:(NSString *)name {
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)getVariablevarName:(NSString *)name {
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;

}
@end
