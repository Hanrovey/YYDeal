
//
//  YYDealLocalListViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 2016/10/21.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealLocalListViewController.h"

@interface YYDealLocalListViewController ()

@end

@implementation YYDealLocalListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置左上角的返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back" highImageName:@"icon_back_highlighted" target:self action:@selector(back)];
    
    // 设置右上角的编辑按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)edit
{
    
}
@end
