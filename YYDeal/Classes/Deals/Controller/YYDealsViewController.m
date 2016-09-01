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
#import "YYCity.h"
#import "YYRegion.h"
#import "YYSort.h"
#import "YYCategory.h"
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

/** 选中的状态 */
@property (nonatomic, strong) YYCity *selectedCity;
/** 当前选中的区域 */
@property (strong, nonatomic) YYRegion *selectedRegion;
/** 当前选中的子区域名称 */
@property (copy, nonatomic) NSString *selectedSubRegionName;
/** 当前选中的排序 */
@property (strong, nonatomic) YYSort *selectedSort;
/** 当前选中的分类 */
@property (strong, nonatomic) YYCategory *selectedCategory;
/** 当前选中的子分类名称 */
@property (copy, nonatomic) NSString *selectedSubCategoryName;
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
        
//        __weak typeof(self) weakSelf = self;
//        rv.changeCityBlock = ^{
//            [weakSelf.regionPopover dismissPopoverAnimated:YES];
//        };
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
    
    // 监听通知
    [self setupNotifications];
    
    // 添加导航栏右边内容
    [self setupNavRight];
    
    // 添加导航栏左边内容
    [self setupNavLeft];
    
    // 用户菜单
    [self setupUserMenu];
}

#pragma mark - 通知处理
/** 监听通知 */
- (void)setupNotifications
{
    YYAddObserver(cityDidSelect:, YYCityDidSelectNotification);
    YYAddObserver(sortDidSelect:, YYSortDidSelectNotification);
    YYAddObserver(categoryDidSelect:, YYCategoryDidSelectNotification);
    YYAddObserver(regionDidSelect:, YYRegionDidSelectNotification);
}

- (void)dealloc
{
    YYRemoveObserver;
}

- (void)regionDidSelect:(NSNotification *)note
{
    // 取出通知中的数据
    self.selectedRegion = note.userInfo[YYSelectedRegion];
    self.selectedSubRegionName = note.userInfo[YYSelectedSubRegionName];
    
    // 设置菜单数据
    self.regionMenu.titleLable.text = [NSString stringWithFormat:@"%@ - %@", self.selectedCity.name, self.selectedRegion.name];
    self.regionMenu.subTitleLable.text = self.selectedSubRegionName;
    
    // 关闭popover
    [self.regionPopover dismissPopoverAnimated:YES];
}

- (void)categoryDidSelect:(NSNotification *)note
{
    // 取出通知中的数据
    self.selectedCategory = note.userInfo[YYSelectedCategory];
    self.selectedSubCategoryName = note.userInfo[YYSelectedSubCategoryName];
    
    // 设置菜单数据
    self.categoryMenu.imageButton.image = self.selectedCategory.icon;
    self.categoryMenu.imageButton.highlightedImage = self.selectedCategory.highlighted_icon;
    self.categoryMenu.titleLable.text = self.selectedCategory.name;
    self.categoryMenu.subTitleLable.text = self.selectedSubCategoryName;
    
    // 关闭popover
    [self.categoryPopover dismissPopoverAnimated:YES];
}


- (void)cityDidSelect:(NSNotification *)note
{
    // 取出通知中的数据
    self.selectedCity = note.userInfo[YYSelectedCity];
    
    self.selectedRegion = [self.selectedCity.regions firstObject];
    
    self.regionMenu.titleLable.text = [NSString stringWithFormat:@"%@ - 全部", self.selectedCity.name];
    self.regionMenu.subTitleLable.text = nil;
    
    // 更换显示的区域数据
    YYRegionsViewController *regionsVc = (YYRegionsViewController *)self.regionPopover.contentViewController;
    regionsVc.regions = self.selectedCity.regions;
}

- (void)sortDidSelect:(NSNotification *)note
{
    // 取出通知中的数据
    self.selectedSort = note.userInfo[YYSelectedSort];
    
    self.sortMenu.subTitleLable.text = self.selectedSort.label;
    
    // 销毁popover
    [self.sortPopover dismissPopoverAnimated:YES];
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
    regionMenu.imageButton.image = @"icon_district";
    regionMenu.imageButton.highlightedImage = @"icon_district_highlighted";
    regionMenu.titleLable.text = @"区域";
    regionMenu.subTitleLable.text = @"全部";
    [regionMenu addTarget:self action:@selector(regionMenuClick)];
    UIBarButtonItem *regionItem = [[UIBarButtonItem alloc] initWithCustomView:regionMenu];
    self.regionMenu = regionMenu;
    
    // 4.排序
    YYDealsTopMenu *sortMenu = [YYDealsTopMenu menu];
    sortMenu.imageButton.image = @"icon_sort";
    sortMenu.imageButton.highlightedImage = @"icon_sort_highlighted";
    sortMenu.titleLable.text = @"排序";
    sortMenu.subTitleLable.text = @"默认排序";
    [sortMenu addTarget:self action:@selector(sortMenuClick)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortMenu];
    self.sortMenu = sortMenu;
    
    self.navigationItem.leftBarButtonItems = @[logoItem, categoryItem, regionItem, sortItem];
}

/** 分类 */
- (void)categoryMenuClick
{
    YYCategoriesViewController *cs = (YYCategoriesViewController *)self.categoryPopover.contentViewController;
    cs.selectedCategory = self.selectedCategory;
    cs.selectedSubCategoryName = self.selectedSubCategoryName;
    [self.categoryPopover presentPopoverFromRect:self.categoryMenu.bounds inView:self.categoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/** 区域 */
- (void)regionMenuClick
{
    YYRegionsViewController *rs = (YYRegionsViewController *)self.regionPopover.contentViewController;
    rs.selectedRegion = self.selectedRegion;
    rs.selectedSubRegionName = self.selectedSubRegionName;
    [self.regionPopover presentPopoverFromRect:self.regionMenu.bounds inView:self.regionMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

/** 排序 */
- (void)sortMenuClick
{
    YYSortsViewController *ss = (YYSortsViewController *)self.sortPopover.contentViewController;
    ss.selectedSort = self.selectedSort;
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
