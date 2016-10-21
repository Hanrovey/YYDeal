//
//  YYCollectViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 2016/10/21.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCollectViewController.h"
#import "YYDealLocalTool.h"

@interface YYCollectViewController ()

@end

@implementation YYCollectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"收藏记录";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 刷新数据（保持顺序）
    [self.deals removeAllObjects];
    NSArray *collectDeals = [YYDealLocalTool sharedDealLocalTool].collectDeals;
    [self.deals addObjectsFromArray:collectDeals];
    [self.collectionView reloadData];
    
    // 设置左上角的返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back" highImageName:@"icon_back_highlighted" target:self action:@selector(back)];
}

#pragma mark - 实现父类方法
- (NSString *)emptyIcon
{
    return @"icon_collects_empty";
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
