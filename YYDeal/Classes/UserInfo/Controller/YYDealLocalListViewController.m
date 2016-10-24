
//
//  YYDealLocalListViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 2016/10/21.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealLocalListViewController.h"
#import "YYDealCell.h"
#import "YYDeal.h"
#define YYEditText @"编辑"
#define YYDoneText @"完成"


@interface YYDealLocalListViewController ()<YYDealCellDelegate>
@property (nonatomic, strong) UIBarButtonItem *selectAllItem;
@property (nonatomic, strong) UIBarButtonItem *unselectAllItem;
@property (nonatomic, strong) UIBarButtonItem *deleteItem;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@end

@implementation YYDealLocalListViewController

#pragma mark - 懒加载
- (UIBarButtonItem *)backItem
{
    if (_backItem == nil) {
        _backItem = [UIBarButtonItem itemWithImageName:@"icon_back" highImageName:@"icon_back_highlighted" target:self action:@selector(back)];
    }
    return _backItem;
}

- (UIBarButtonItem *)selectAllItem
{
    if (_selectAllItem == nil) {
        self.selectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"   全选   " style:UIBarButtonItemStylePlain target:self action:@selector(selectAll)];
    }
    return _selectAllItem;
}

- (UIBarButtonItem *)unselectAllItem
{
    if (_unselectAllItem == nil) {
        _unselectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"   全不选   " style:UIBarButtonItemStylePlain target:self action:@selector(unselectAll)];
    }
    return _unselectAllItem;
}

- (UIBarButtonItem *)deleteItem
{
    if (_deleteItem == nil) {
        _deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"   删除   " style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
        _deleteItem.enabled = NO;// 默认不可用
    }
    return _deleteItem;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置左上角的返回按钮
    self.navigationItem.leftBarButtonItems = @[self.backItem];
    
    // 设置右上角的编辑按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:YYEditText style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 清空状态
    for (YYDeal *deal in self.deals)
    {
        deal.editing = NO;
        deal.checking = NO;
    }
    
}

/**
 *  返回
 */
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



/**
 *  编辑
 */
- (void)edit
{
    NSString *title = self.navigationItem.rightBarButtonItem.title;
    if ([title isEqualToString:YYEditText])
    {
        self.navigationItem.rightBarButtonItem.title = YYDoneText;
        
        // 进入编辑状态
        for (YYDeal *deal in self.deals)
        {
            deal.editing = YES;
        }
        [self.collectionView reloadData];
        
        //左边显示4个item
        self.navigationItem.leftBarButtonItems = @[self.backItem,self.selectAllItem,self.unselectAllItem,self.deleteItem];
        
    }else
    {
        self.navigationItem.rightBarButtonItem.title = YYEditText;

        // 结束编辑状态
        for (YYDeal *deal in self.deals)
        {
            deal.editing = NO;
            deal.checking = NO;
        }
        [self.collectionView reloadData];
        
        // 左边显示1个item
        self.navigationItem.leftBarButtonItems = @[self.backItem];
    }
}

/**
 *  全选
 */
- (void)selectAll
{
    // 进入编辑状态
    for (YYDeal *deal in self.deals)
    {
        deal.checking = YES;
    }
    [self.collectionView reloadData];
    
    
    // 控制删除item的状态和文字
    [self dealCellDidClickCover:nil];
}

/**
 *  全不选
 */
- (void)unselectAll
{
    // 进入编辑状态
    for (YYDeal *deal in self.deals)
    {
        deal.checking = NO;
    }
    [self.collectionView reloadData];
    
    // 控制删除item的状态和文字
    [self dealCellDidClickCover:nil];
}

/**
 *  删除
 */
- (void)delete
{
    [self dealCellDidClickCover:nil];
}

#pragma mark - YYDealCellDelegate
- (void)dealCellDidClickCover:(YYDealCell *)dealCell
{
    BOOL deleteEnable = NO;
    int checkingCount = 0;
    // 1.删除item的状态
    for (YYDeal *deal in self.deals)
    {
        if (deal.isChecking)
        {
            deleteEnable = YES;
            checkingCount++;
        }
    }
    self.deleteItem.enabled = deleteEnable;
    
    // 2.删除item的文字
    if (checkingCount)
    {
        self.deleteItem.title = [NSString stringWithFormat:@"   删除(%d)   ", checkingCount];
    }else
    {
        self.deleteItem.title = @"   删除   ";
    }
}

/**
 *  返回即将删除的团购
 */
- (NSArray *)willDeleteDeals
{
    NSMutableArray *checkingDeals = [NSMutableArray array];
    
    // 取出被打钩的团购
    for (YYDeal *deal in self.deals)
    {
        if (deal.isChecking)
        {
            [checkingDeals addObject:deal];
            deal.checking = NO;
            deal.editing = NO;
        }
    }
    
    [self.deals removeObjectsInArray:checkingDeals];
    [self.collectionView reloadData];
    
    // 控制删除item的状态和文字
    [self dealCellDidClickCover:nil];
    
    return checkingDeals;
}
@end
