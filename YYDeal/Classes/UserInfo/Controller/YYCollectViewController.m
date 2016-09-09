
//
//  YYCollectViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCollectViewController.h"

@interface YYCollectViewController ()

@end

@implementation YYCollectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置左上角的返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back" highImageName:@"icon_back_highlighted" target:self action:@selector(back)];
    self.title = @"我的收藏";
    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 实现父类方法
- (NSString *)emptyIcons
{
    return @"icon_collects_empty";
}
@end
