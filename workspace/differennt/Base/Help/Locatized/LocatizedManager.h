//
//  LocatizedManager.h
//  differennt
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kUserLanguage @"userLanguage"

@interface LocatizedManager : NSObject
@property (nonatomic,strong)NSString *currentLanguage;
@property (nonatomic,strong)NSBundle *languageBundle;

+(LocatizedManager *)shareInstance;
//切换语言
- (void)setUserlanguage:(NSString *)language;
-(void)initUserLanguage;
-(void)saveDefineUserLanguage:(NSString *)userLanguage;
-(NSString *)defineUserLanguage;

-(NSString *)locatizedStringForkey:(NSString *)keyStr;
-(UIStoryboard *)locatizedStoryboardWithName:(NSString *)storyBoardName;
@end
