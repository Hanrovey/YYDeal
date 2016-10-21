//
//  YYDealListViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealListViewController.h"
#import "YYDealCell.h"
#import "YYEmptyView.h"
#import "YYDealDetailController.h"
@interface YYDealListViewController ()<YYDealCellDelegate>

/** 没有数据时显示的view */
@property (nonatomic, weak) YYEmptyView *emptyView;
@end

@implementation YYDealListViewController

#pragma mark - 懒加载
- (YYEmptyView *)emptyView
{
    if (_emptyView == nil) {
        YYEmptyView *emptyView = [YYEmptyView emptyView];
        emptyView.image = [UIImage imageNamed:self.emptyIcon];
        [self.view insertSubview:emptyView belowSubview:self.collectionView];
        self.emptyView = emptyView;
    }
    return _emptyView;
}

- (NSMutableArray *)deals
{
    if (_deals == nil) {
        self.deals = [NSMutableArray array];
    }
    return _deals;
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(305, 305);
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupLayout:self.view.width orientation:self.interfaceOrientation];
}

#pragma mark - 处理屏幕的旋转
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
#warning 这里要注意：由于是即将旋转，最后的宽度就是现在的高度
    // 总宽度
    CGFloat totalWidth = self.view.height;
    [self setupLayout:totalWidth orientation:toInterfaceOrientation];
}

/**
 *  调整布局
 *
 *  @param totalWidth 总宽度
 *  @param orientation 显示的方向
 */
- (void)setupLayout:(CGFloat)totalWidth orientation:(UIInterfaceOrientation)orientation
{
    // 总列数
    int column = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    // 每一行的最小间距
    CGFloat lineSpacing = 25;
    // 每一列的最小间距
    CGFloat interitemSpacing = (totalWidth - column * layout.itemSize.width) / (column + 1);
    
    layout.minimumLineSpacing = lineSpacing;
    layout.minimumInteritemSpacing = interitemSpacing;
    
    // 设置cell与CollectionView边缘的间距
    layout.sectionInset = UIEdgeInsetsMake(lineSpacing, interitemSpacing, lineSpacing, interitemSpacing);
    
}

/**
 *  设置控制器view属性
 */
- (void)setupBaseView
{
    // 设置颜色
    self.collectionView.backgroundColor = [UIColor clearColor];
    // 垂直方向上永远有弹簧效果
    self.collectionView.alwaysBounceVertical = YES;
    
    self.view.backgroundColor = YYGlobalBg;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YYDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
}

#pragma mark - 数据源方法
#warning 如果要在数据个数发生的改变时做出响应，那么响应操作可以考虑在数据源方法中实现
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
#warning 控制emptyView的可见性
    self.emptyView.hidden = (self.deals.count > 0);
    
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"deal" forIndexPath:indexPath];
    cell.delegate = self;
    YYDeal *deal = self.deals[indexPath.item];
    cell.deal = deal;
    return cell;
    
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYDealDetailController *deailVC = [[YYDealDetailController alloc] init];
    deailVC.deal = self.deals[indexPath.item];
    [self presentViewController:deailVC animated:YES completion:nil];
}

@end
