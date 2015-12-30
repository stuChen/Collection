//
//  AppDelegate.m
//  Base
//
//  Created by bodecn on 15/10/21.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "IndexViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "FatherNavigationController.h"
#import "DEMOMenuViewController.h"
#import "MenuViewController.h"

//
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialFacebookHandler.h"
#import "UMSocialTwitterHandler.h"
#import "UMSocialInstagramHandler.h"
#import <MobClick.h>
//
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window                 = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self status];
//    //设置字体
//    sleep(2);
    //
    [self initRootVc:NO];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)initRootVc:(BOOL)pushVc {
    FatherNavigationController *navigationController = [[FatherNavigationController alloc] initWithRootViewController:[[IndexViewController alloc] init]];
    MenuViewController *menuController               = [[MenuViewController alloc] init];//WithStyle:UITableViewStylePlain];
    
    // Create frosted view controller
    //
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction                = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle  = REFrostedViewControllerLiveBackgroundStyleDark;
    frostedViewController.liveBlur                 = YES;
    frostedViewController.delegate                 = self;
    frostedViewController.menuViewSize             = [UIScreen mainScreen].bounds.size;
    frostedViewController.panGestureEnabled        = NO;
    // Make it a root controller
    //
    self.window.rootViewController = frostedViewController;
    
}

- (void)status {
    [IQKeyboardManager sharedManager];
    [[LocatizedManager shareInstance] initUserLanguage];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self UMSocialSetting];
//    UINavigationBar *bar = [UINavigationBar appearance];
//    //设置显示的颜色
//    bar.barTintColor = [UIColor whiteColor];
//    //设置字体颜色
//    bar.tintColor = MAINCOLOR;
//    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : MAINCOLOR}];
//    //或者用这个都行
//    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : MAINCOLOR}];
    
//    NSArray *languages        = [NSLocale preferredLanguages];
//    NSString *currentLanguage = [languages objectAtIndex:0];
//    NSUserDefaults *def       = [NSUserDefaults standardUserDefaults];
//    NSArray* languages1       = [def objectForKey:@"AppleLanguages"];
//    NSString *current         = [languages1 objectAtIndex:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:@"sdasdasds" object:nil];
}
- (void)change {
//    MainViewController *a = [[MainViewController alloc]init];
//    self.window.rootViewController = a;
}

#pragma mark - 友盟
- (void)UMSocialSetting {
    //
    [MobClick startWithAppkey:@"566a285fe0f55a041f000fa6" reportPolicy:BATCH channelId:@""];
    
    
    
    
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"566a285fe0f55a041f000fa6"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"" appSecret:@"" url:@""];
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
//    
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil ,需要 #import "UMSocialSinaHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    //打开人人网SSO开关,需要 #import "UMSocialRenrenHandler.h"
//    [UMSocialRenrenHandler openSSO];
//    //设置易信Appkey和分享url地址,注意需要引用头文件 #import UMSocialYixinHandler.h
//    [UMSocialYixinHandler setYixinAppKey:@"yx35664bdff4db42c2b7be1e29390c1a06" url:@"http://www.umeng.com/social"];
//    //设置来往AppId，appscret，显示来源名称和url地址，注意需要引用头文件 #import "UMSocialLaiwangHandler.h"
//    [UMSocialLaiwangHandler setLaiwangAppId:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" appDescription:@"友盟社会化组件" urlStirng:@"http://www.umeng.com/social"];
//    //设置Facebook，AppID和分享url，需要#import "UMSocialFacebookHandler.h"
//    //默认使用iOS自带的Facebook分享framework，在iOS 6以上有效。若要使用我们提供的facebook分享需要使用此开关：
    [UMSocialFacebookHandler setFacebookAppID:@"1440390216179601" shareFacebookWithURL:@"http://www.umeng.com/social"];
    
//    //默认使用iOS自带的Twitter分享framework，在iOS 6以上有效。若要使用我们提供的twitter分享需要使用此开关：
    [UMSocialTwitterHandler openTwitter];
//    // TwitterSDK仅在iOS7.0以上有效，在iOS 6.x上自动调用系统内置Twitter授权
//    if (UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
//        [UMSocialTwitterHandler setTwitterAppKey:@"fB5tvRpna1CKK97xZUslbxiet" withSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K"];
//    }
    [UMSocialInstagramHandler openInstagramWithScale:NO paddingColor:[UIColor blackColor]];
    
    //这个接口只对默认分享面板平台有隐藏功能，自定义分享面板或登录按钮需要自己处理
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToInstagram, UMShareToWechatSession, UMShareToWechatTimeline]];
}


#pragma mark - 3D-touch 
- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler {
    DLog(@"%@",shortcutItem.type);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
//    //跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        NSLog(@"result = %@",resultDic);
//    }];
    
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        }];
    }
    
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
    }

    return YES;
}

#pragma mark - 侧滑栏
- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController");
}

@end
