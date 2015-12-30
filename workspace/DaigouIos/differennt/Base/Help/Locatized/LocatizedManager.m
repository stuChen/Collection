//
//  LocatizedManager.m
//  differennt
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "LocatizedManager.h"
#define BaseBundle  @"Base"
@interface LocatizedManager(){
    NSBundle *_languageBundle;
}
@end
@implementation LocatizedManager


+ (LocatizedManager *)shareInstance{
    static LocatizedManager *languageTools;
    static  dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        languageTools = [[LocatizedManager alloc] init];
    });
    return languageTools;
}
//切换语言
- (void)setUserlanguage:(NSString *)language{

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //1.第一步改变bundle的值
    NSString *path  = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    _languageBundle = [NSBundle bundleWithPath:path];
    //2.持久化
    [def setValue:language forKey:kUserLanguage];
    [def synchronize];
    
    [self initUserLanguage];
}

- (void)initUserLanguage{
    NSUserDefaults *def    = [NSUserDefaults standardUserDefaults];
    NSString *userLanguage = [def valueForKey:kUserLanguage];
    if (!userLanguage) {
        NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
        NSArray *languages        = [defaults objectForKey : @"AppleLanguages" ];
        // 获得当前iPhone使用的语言
        NSString* currentLanguage = [languages objectAtIndex:0];
        userLanguage              = currentLanguage;
        [userLanguage substringFromIndex:0];
        if ([userLanguage hasPrefix:@"zh-Hans"]) {
            userLanguage = @"zh-Hans";
        }
        else if ([userLanguage hasPrefix:@"en"]) {
            userLanguage = @"en";
        }
        else if ([userLanguage hasPrefix:@"ja"]) {
            userLanguage = @"ja";
        }
        else if ([userLanguage hasPrefix:@"ko"]) {
            userLanguage = @"ko";
        }

    }
    //获取文件路径
    NSString *languagePath = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
    _languageBundle        = [NSBundle bundleWithPath:languagePath];//生成bundle

}

- (void)saveDefineUserLanguage:(NSString *)userLanguage{
    if (!userLanguage) {
        return;
    }
    [userLanguage substringFromIndex:0];
    if ([userLanguage hasPrefix:@"zh-Hans"]) {
        userLanguage = @"zh-Hans";
    }
    else if ([userLanguage hasPrefix:@"en"]) {
        userLanguage = @"en";
    }
    else if ([userLanguage hasPrefix:@"ja"]) {
        userLanguage = @"ja";
    }
    else if ([userLanguage hasPrefix:@"ko"]) {
        userLanguage = @"ko";
    }
    
    //
    if (userLanguage == _currentLanguage) {
        return;
    }
    _currentLanguage = userLanguage;
    NSString *path   = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj" ];
    _languageBundle  = [NSBundle bundleWithPath:path];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:userLanguage forKey:kUserLanguage];
    [def synchronize];
}
- (NSString *)defineUserLanguage{
    NSUserDefaults *def    = [NSUserDefaults standardUserDefaults];
    NSString *userLanguage = [def valueForKey:kUserLanguage];
    return userLanguage;
}
//获取sb
- (UIStoryboard *)locatizedStoryboardWithName:(NSString *)storyBoardName{
    UIStoryboard *storyboard = [UIStoryboard  storyboardWithName:storyBoardName bundle:_languageBundle];
    return storyboard ;
}

//获取标签
- (NSString *)locatizedStringForkey:(NSString *)keyStr{
    if (!_languageBundle) {
        NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
        NSArray *languages        = [defaults objectForKey : @"AppleLanguages" ];
        // 获得当前iPhone使用的语言
        NSString* currentLanguage = [languages objectAtIndex:0];
        [self saveDefineUserLanguage:currentLanguage];
    }
    //默认为本地资源文件名 为Localizable.strings
    NSString *str = [_languageBundle localizedStringForKey:keyStr value:nil table:@"Language"];
    return str;
}

@end
