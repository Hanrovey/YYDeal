//
//  YYHistoryViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYHistoryViewController.h"
#import "YYDealLocalTool.h"
@interface YYHistoryViewController ()

@end

@implementation YYHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"浏览记录";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 刷新数据（保持顺序）
    [self.deals removeAllObjects];
    NSArray *historyDeals = [YYDealLocalTool sharedDealLocalTool].historyDeals;
    [self.deals addObjectsFromArray:historyDeals];
    [self.collectionView reloadData];
    
    // 设置左上角的返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back" highImageName:@"icon_back_highlighted" target:self action:@selector(back)];
    self.title = @"浏览记录";
}

#pragma mark - 实现父类方法
- (NSString *)emptyIcon
{
    return @"icon_latestBrowse_empty";
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
