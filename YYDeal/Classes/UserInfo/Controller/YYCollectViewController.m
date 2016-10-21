//
//  YYCollectViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 2016/10/21.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCollectViewController.h"
#import "YYDealLocalTool.h"
#import "YYDeal.h"
@interface YYCollectViewController ()

@end

@implementation YYCollectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的收藏";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 刷新数据（保持顺序）
    [self.deals removeAllObjects];
    NSArray *collectDeals = [YYDealLocalTool sharedDealLocalTool].collectDeals;
    [self.deals addObjectsFromArray:collectDeals];
    [self.collectionView reloadData];
}

#pragma mark - 实现父类方法
- (NSString *)emptyIcon
{
    return @"icon_collects_empty";
}

/**
 *  删除
 */
- (void)delete
{
    NSMutableArray *temArr = [NSMutableArray array];
    for (YYDeal *deal in self.deals)
    {
        if (deal.isChecking)
        {
            [temArr addObject:deal];
        }
    }
    
    [[YYDealLocalTool sharedDealLocalTool] unsaveCollectDeals:temArr];
    
    [self.deals removeObjectsInArray:temArr];
    [self.collectionView reloadData];
}
@end
