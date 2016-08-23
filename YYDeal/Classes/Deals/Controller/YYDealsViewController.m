//
//  YYDealsViewController.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealsViewController.h"
#import "AwesomeMenu.h"
#import "AwesomeMenuItem.h"
#import "YYDealsTopMenu.h"
#import "YYCategoriesViewController.h"
#import "YYRegionsViewController.h"
#import "YYSortsViewController.h"
@interface YYDealsViewController ()<AwesomeMenuDelegate>
/** 顶部菜单*/
/** 分类菜单 */
@property (weak, nonatomic) YYDealsTopMenu *categoryMenu;
/** 区域菜单 */
@property (weak, nonatomic) YYDealsTopMenu *regionMenu;
/** 排序菜单 */
@property (weak, nonatomic) YYDealsTopMenu *sortMenu;


/** 点击顶部菜单后弹出的Popover */
/** 分类Popover */
@property (strong, nonatomic) UIPopoverController *categoryPopover;
/** 区域Popover */
@property (strong, nonatomic) UIPopoverController *regionPopover;
/** 排序Popover */
@property (strong, nonatomic) UIPopoverController *sortPopover;
@end

@implementation YYDealsViewController

- (UIPopoverController *)categoryPopover
{
    if (_categoryPopover == nil) {
        
        YYCategoriesViewController *cv = [[YYCategoriesViewController alloc] init];
        self.categoryPopover = [[UIPopoverController alloc] initWithContentViewController:cv];
    }
    return _categoryPopover;
}

- (UIPopoverController *)regionPopover
{
    if (!_regionPopover) {
        YYRegionsViewController *rv = [[YYRegionsViewController alloc] init];
        self.regionPopover = [[UIPopoverController alloc] initWithContentViewController:rv];
        
        __weak typeof(self) weakSelf = self;
        rv.changeCityBlock = ^{
            [weakSelf.regionPopover dismissPopoverAnimated:YES];
        };
    }
    return _regionPopover;
}

- (UIPopoverController *)sortPopover
{
    if (!_sortPopover) {
        YYSortsViewController *sv = [[YYSortsViewController alloc] init];
        self.sortPopover = [[UIPopoverController alloc] initWithContentViewController:sv];
    }
    return _sortPopover;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加导航栏右边内容
    [self setupNavRight];
    
    // 添加导航栏左边内容
    [self setupNavLeft];
    
    // 用户菜单
    [self setupUserMenu];
}


#pragma mark - 导航栏右边处理
/**
 *  添加导航栏右边
 */
- (void)setupNavRight
{
    // 搜索
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithImageName:@"icon_search" highImageName:@"icon_search_highlighted" target:self action:@selector(searchClick)];
    searchItem.customView.width = 50;
    searchItem.customView.height = 27;
    
    // 地图
    UIBarButtonItem *mapItem = [UIBarButtonItem itemWithImageName:@"icon_map" highImageName:@"icon_map_highlighted" target:self action:@selector(mapClick)];
    mapItem.customView.width = searchItem.customView.width;
    mapItem.customView.height = searchItem.customView.height;
    
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
}

/**
 *  搜索
 */
- (void)searchClick
{
    
}

/**
 *  地图
 */
- (void)mapClick
{
    
}

#pragma mark - 导航栏左边处理
/**
 *  添加导航栏左边
 */
- (void)setupNavLeft
{
    // 1.Logo
    UIBarButtonItem *logoItem = [UIBarButtonItem itemWithImageName:@"icon_meituan_logo" highImageName:@"icon_meituan_logo" target:nil action:nil];
    logoItem.customView.userInteractionEnabled = NO;
    
    // 2.分类
    YYDealsTopMenu *categoryMenu = [YYDealsTopMenu menu];
    [categoryMenu addTarget:self action:@selector(categoryMenuClick)];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryMenu];
    self.categoryMenu = categoryMenu;
    
    // 3.区域
    YYDealsTopMenu *regionMenu = [YYDealsTopMenu menu];
    [regionMenu addTarget:self action:@selector(regionMenuClick)];
    UIBarButtonItem *regionItem = [[UIBarButtonItem alloc] initWithCustomView:regionMenu];
    self.regionMenu = regionMenu;
    
    // 4.排序
    YYDealsTopMenu *sortMenu = [YYDealsTopMenu menu];
    [sortMenu addTarget:self action:@selector(sortMenuClick)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortMenu];
    self.sortMenu = sortMenu;
    
    self.navigationItem.leftBarButtonItems = @[logoItem, categoryItem, regionItem, sortItem];
}

/** 分类 */
- (void)categoryMenuClick
{
    [self.categoryPopover presentPopoverFromRect:self.categoryMenu.bounds inView:self.categoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/** 区域 */
- (void)regionMenuClick
{
    [self.regionPopover presentPopoverFromRect:self.regionMenu.bounds inView:self.regionMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/** 排序 */
- (void)sortMenuClick
{
    [self.sortPopover presentPopoverFromRect:self.sortMenu.bounds inView:self.sortMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


/** 创建一个path菜单item  */
- (AwesomeMenuItem *)itemWithContent:(NSString *)content highlightedContent:(NSString *)highlightedContent
{
    UIImage *itemBg = [UIImage imageNamed:@"bg_pathMenu_black_normal"];
    return [[AwesomeMenuItem alloc] initWithImage:itemBg highlightedImage:nil ContentImage:[UIImage imageNamed:content] highlightedContentImage:[UIImage imageNamed:highlightedContent]];
}

/**
 *  用户菜单
 */
- (void)setupUserMenu
{
    // 1.周边的item
    AwesomeMenuItem *mineItem = [self itemWithContent:@"icon_pathMenu_mine_normal" highlightedContent:@"icon_pathMenu_mine_highlighted"];
    AwesomeMenuItem *collectItem = [self itemWithContent:@"icon_pathMenu_collect_normal" highlightedContent:@"icon_pathMenu_collect_highlighted"];
    AwesomeMenuItem *scanItem = [self itemWithContent:@"icon_pathMenu_scan_normal" highlightedContent:@"icon_pathMenu_scan_highlighted"];
    AwesomeMenuItem *moreItem = [self itemWithContent:@"icon_pathMenu_more_normal" highlightedContent:@"icon_pathMenu_more_highlighted"];
    NSArray *items = @[mineItem, collectItem, scanItem, moreItem];

    // 2.中间的开始item
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc]initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem optionMenus:items];
    [self.view addSubview:menu];
    // 整个菜单的活动范围
    menu.menuWholeAngle = M_PI_2;
    
    //约束
    CGFloat menuH = 200;
    [menu autoSetDimensionsToSize:CGSizeMake(200, menuH)];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];

    // 3.添加一个背景
    UIImageView *menuBg = [[UIImageView alloc] init];
    menuBg.image = [UIImage imageNamed:@"icon_pathMenu_background"];
    [menu insertSubview:menuBg atIndex:0];
    // 约束
    [menuBg autoSetDimensionsToSize:menuBg.image.size];
    [menuBg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menuBg autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    // 起点
    menu.startPoint = CGPointMake(menuBg.image.size.width * 0.5, menuH - menuBg.image.size.height * 0.5);
    // 禁止中间按钮旋转
    menu.rotateAddButton = NO;
    
    // 设置代理
    menu.delegate = self;
}

#pragma mark - 菜单代理
- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    // 显示xx图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
    // 恢复图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];

}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    [self awesomeMenuWillAnimateClose:menu];
}

























@end
