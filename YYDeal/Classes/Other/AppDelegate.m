//
//  AppDelegate.m
//  YYDeal(HD)
//
//  Created by ihefe-0004 on 16/3/3.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UIImageView+WebCache.h"
#import "YYMainNavigationController.h"
#import "YYDealsViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] init];
    
    YYMainNavigationController *nav = [[YYMainNavigationController alloc] initWithRootViewController:[YYDealsViewController new]];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMAppKey];
    //第一个参数为新浪appkey,第二个参数为新浪secret，第三个参数是新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:SinaAppKey
                                              secret:SinaSecret
                                         RedirectURL:nil];
    return YES;
}

#pragma mark - 从新浪客户端回到自己应用时会自动调用(友盟内部会处理返回的accessToken)
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
