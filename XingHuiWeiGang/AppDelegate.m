//
//  AppDelegate.m
//  XingHuiWeiGang
//
//  Created by zx on 15/7/9.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "AppDelegate.h"
#import "ShakeViewControllerHelp.h"

#import <ShareSDK/ShareSDK.h>
#import <QZoneConnection/QZoneConnection.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
 
    ShakeViewControllerHelp *shakeHelpVC = [ShakeViewControllerHelp shareShakeVCHelp];
    self.window.rootViewController = shakeHelpVC;
    [self.window makeKeyAndVisible];
    
    [ShareSDK registerApp:@"7b8f42726909"];
    [self initSharePlat];
    //开启QQ空间网页授权开关(optional)
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];

    return YES;
}

#pragma mark---初始化社交平台
-(void)initSharePlat
{
    [ShareSDK connectWeChatWithAppId:@"wxc4f7ddd444ab4386"
                           appSecret:@"e5f9c9b752de08abd9514c1d95d82d80"
                           wechatCls:[WXApi class]];
    
    [ShareSDK connectQZoneWithAppKey:@"1104735700"
                           appSecret:@"jC8cfppdMfvgzsYf"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"1104735700"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //[ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               //appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                            // redirectUri:@"http://www.sharesdk.cn"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    
}

#pragma mark - 如果使用SSO（可以简单理解成客户端授权），以下方法是必要的
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

//iOS 4.2+
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if (![UserDefaults boolForKey:@"remberMe"]) {
#warning 移除数据
        
        
    }
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

@end
