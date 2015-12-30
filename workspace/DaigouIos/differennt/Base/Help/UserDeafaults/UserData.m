//
//  UserData.m
//  Sahara
//
//  Created by Chen on 15/6/30.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import "UserData.h"

@implementation UserData
+ (BOOL)UserLoginState
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"])
    {
        return YES;
    }
    else return NO;
}

+ (void)cleanUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_dic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*

 */
+ (void)WriteUserInfo:(id)dic
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_dic"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user_dic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)reWriteUserInfo:(NSString *)value ForKey:(NSString *)key {
    
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dict setValue:value forKey:key];
    [UserData WriteUserInfo:dict];
}
/*

 
 */
+ (NSString *)keyForUser:(NSString *)key
{
    NSData *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_dic"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    NSString *string  = [NSString stringWithFormat:@"%@",[dic objectForKey:key]];
    return string;
}


+ (NSDictionary *)authData
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"auth"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"auth"];
    }
    return nil;
}

+ (NSString *)userId {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Id"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"Id"];
    }
    return nil;
}
/**
 *  缓存写入
 */
+ (void)UserDefaults:(NSString *)value key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  缓存读取
 */
+ (NSString *)UserDefaults:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
/**
 *  缓存清除
 */
+ (void)ClearUserDefaults:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  增加历史记录
 */
+ (void)AddHistroyDataForKey:(NSString *)key value:(NSString *)value {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if ([def objectForKey:key]) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[def objectForKey:key]];
        if ([array containsObject:value]) {
            [array removeObject:value];
        }
        [array insertObject:value atIndex:0];
        
        [def setObject:array forKey:key];
    }
    else {
        [def setObject:@[value] forKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  删除历史记录
 */
+ (NSArray *)DeleteHistroyDataForKey:(NSString *)key value:(NSString *)value {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if ([def objectForKey:key]) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[def objectForKey:key]];
        if ([array containsObject:value]) {
            [array removeObject:value];
        }
        [def setObject:array forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return array;
    }
    return nil;
}
/**
 *  查询历史记录
 */
+ (NSArray *)GetHistroyDataForKey:(NSString *)key value:(NSString *)value {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([def objectForKey:key]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *dataArray = [def objectForKey:key];
        for (NSString *keyValue in dataArray) {
            if ([[keyValue uppercaseString] rangeOfString:[value uppercaseString]].location != NSNotFound) {
                [array addObject:keyValue];
            }
        }
        return array;
    }
    return nil;
}
@end
