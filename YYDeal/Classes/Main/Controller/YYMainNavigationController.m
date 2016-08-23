//
//  YYMainNavigationController.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYMainNavigationController.h"

@interface YYMainNavigationController ()

@end

@implementation YYMainNavigationController

+ (void)initialize
{
    // 设置整个app的导航栏颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置搜索取消按钮文字和颜色
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

@end
