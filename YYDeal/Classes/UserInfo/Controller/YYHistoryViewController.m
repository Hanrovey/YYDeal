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
}

#pragma mark - 实现父类方法
- (NSString *)emptyIcon
{
    return @"icon_latestBrowse_empty";
}

@end
